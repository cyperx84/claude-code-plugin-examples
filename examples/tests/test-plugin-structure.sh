#!/bin/bash
# Test script to validate plugin structure

set -e

PLUGIN_DIR=$1

if [ -z "$PLUGIN_DIR" ]; then
  echo "Usage: $0 <plugin-directory>"
  exit 1
fi

echo "🧪 Testing plugin structure: $PLUGIN_DIR"
echo "========================================="

# Test 1: plugin.json exists and is valid
echo "Test 1: Checking plugin.json..."
if [ ! -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]; then
  echo "❌ FAIL: plugin.json not found"
  exit 1
fi

if ! cat "$PLUGIN_DIR/.claude-plugin/plugin.json" | jq empty 2>/dev/null; then
  echo "❌ FAIL: plugin.json is not valid JSON"
  exit 1
fi

# Check required fields
PLUGIN_NAME=$(cat "$PLUGIN_DIR/.claude-plugin/plugin.json" | jq -r '.name // empty')
PLUGIN_VERSION=$(cat "$PLUGIN_DIR/.claude-plugin/plugin.json" | jq -r '.version // empty')

if [ -z "$PLUGIN_NAME" ]; then
  echo "❌ FAIL: plugin.json missing 'name' field"
  exit 1
fi

if [ -z "$PLUGIN_VERSION" ]; then
  echo "❌ FAIL: plugin.json missing 'version' field"
  exit 1
fi

echo "✅ PASS: plugin.json valid (name: $PLUGIN_NAME, version: $PLUGIN_VERSION)"

# Test 2: Commands have valid frontmatter
if [ -d "$PLUGIN_DIR/commands" ]; then
  echo ""
  echo "Test 2: Checking command files..."
  COMMAND_COUNT=0
  INVALID_COMMANDS=0

  while IFS= read -r -d '' CMD_FILE; do
    COMMAND_COUNT=$((COMMAND_COUNT + 1))

    # Check if file starts with frontmatter
    if ! head -1 "$CMD_FILE" | grep -q "^---$"; then
      echo "⚠️  WARNING: $CMD_FILE missing frontmatter"
      INVALID_COMMANDS=$((INVALID_COMMANDS + 1))
    fi
  done < <(find "$PLUGIN_DIR/commands" -name "*.md" -print0)

  if [ $INVALID_COMMANDS -gt 0 ]; then
    echo "⚠️  WARNING: $INVALID_COMMANDS/$COMMAND_COUNT commands have issues"
  else
    echo "✅ PASS: All $COMMAND_COUNT commands have valid frontmatter"
  fi
fi

# Test 3: Agents have valid frontmatter
if [ -d "$PLUGIN_DIR/agents" ]; then
  echo ""
  echo "Test 3: Checking agent files..."
  AGENT_COUNT=0
  INVALID_AGENTS=0

  while IFS= read -r -d '' AGENT_FILE; do
    AGENT_COUNT=$((AGENT_COUNT + 1))

    # Check if file starts with frontmatter
    if ! head -1 "$AGENT_FILE" | grep -q "^---$"; then
      echo "⚠️  WARNING: $AGENT_FILE missing frontmatter"
      INVALID_AGENTS=$((INVALID_AGENTS + 1))
    fi
  done < <(find "$PLUGIN_DIR/agents" -name "*.md" -print0)

  if [ $INVALID_AGENTS -gt 0 ]; then
    echo "⚠️  WARNING: $INVALID_AGENTS/$AGENT_COUNT agents have issues"
  else
    echo "✅ PASS: All $AGENT_COUNT agents have valid frontmatter"
  fi
fi

# Test 4: Hooks JSON is valid
if [ -f "$PLUGIN_DIR/hooks/hooks.json" ]; then
  echo ""
  echo "Test 4: Checking hooks.json..."

  if ! cat "$PLUGIN_DIR/hooks/hooks.json" | jq empty 2>/dev/null; then
    echo "❌ FAIL: hooks.json is not valid JSON"
    exit 1
  fi

  HOOK_COUNT=$(cat "$PLUGIN_DIR/hooks/hooks.json" | jq '.hooks | length')
  echo "✅ PASS: hooks.json valid ($HOOK_COUNT hooks defined)"
fi

# Test 5: MCP config is valid
if [ -f "$PLUGIN_DIR/.mcp.json" ]; then
  echo ""
  echo "Test 5: Checking .mcp.json..."

  if ! cat "$PLUGIN_DIR/.mcp.json" | jq empty 2>/dev/null; then
    echo "❌ FAIL: .mcp.json is not valid JSON"
    exit 1
  fi

  MCP_COUNT=$(cat "$PLUGIN_DIR/.mcp.json" | jq '.mcpServers | length')
  echo "✅ PASS: .mcp.json valid ($MCP_COUNT MCP servers defined)"
fi

# Test 6: Scripts are executable
if [ -d "$PLUGIN_DIR/scripts" ]; then
  echo ""
  echo "Test 6: Checking script executability..."
  NON_EXECUTABLE=0

  while IFS= read -r -d '' SCRIPT_FILE; do
    if [ ! -x "$SCRIPT_FILE" ]; then
      echo "⚠️  WARNING: $SCRIPT_FILE is not executable"
      NON_EXECUTABLE=$((NON_EXECUTABLE + 1))
    fi
  done < <(find "$PLUGIN_DIR/scripts" -name "*.sh" -print0)

  if [ $NON_EXECUTABLE -gt 0 ]; then
    echo "⚠️  WARNING: $NON_EXECUTABLE script(s) not executable (run: chmod +x scripts/*.sh)"
  else
    SCRIPT_COUNT=$(find "$PLUGIN_DIR/scripts" -name "*.sh" | wc -l)
    echo "✅ PASS: All $SCRIPT_COUNT scripts are executable"
  fi
fi

# Test 7: README exists
echo ""
echo "Test 7: Checking README..."
if [ ! -f "$PLUGIN_DIR/README.md" ]; then
  echo "⚠️  WARNING: README.md not found"
else
  echo "✅ PASS: README.md exists"
fi

echo ""
echo "========================================="
echo "✅ All critical tests passed for: $PLUGIN_NAME"
echo ""
