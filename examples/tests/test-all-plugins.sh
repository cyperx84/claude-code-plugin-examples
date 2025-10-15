#!/bin/bash
# Test all example plugins

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXAMPLES_DIR="$(dirname "$SCRIPT_DIR")"

echo "🧪 Testing All Example Plugins"
echo "=============================="
echo ""

TOTAL_PLUGINS=0
PASSED_PLUGINS=0
FAILED_PLUGINS=0

# Test beginner plugins
echo "📚 BEGINNER PLUGINS"
echo "==================="
for PLUGIN in "$EXAMPLES_DIR"/01-beginner/*/; do
  if [ -d "$PLUGIN" ]; then
    TOTAL_PLUGINS=$((TOTAL_PLUGINS + 1))
    if bash "$SCRIPT_DIR/test-plugin-structure.sh" "$PLUGIN"; then
      PASSED_PLUGINS=$((PASSED_PLUGINS + 1))
    else
      FAILED_PLUGINS=$((FAILED_PLUGINS + 1))
    fi
    echo ""
  fi
done

# Test intermediate plugins
echo "📚 INTERMEDIATE PLUGINS"
echo "======================="
for PLUGIN in "$EXAMPLES_DIR"/02-intermediate/*/; do
  if [ -d "$PLUGIN" ]; then
    TOTAL_PLUGINS=$((TOTAL_PLUGINS + 1))
    if bash "$SCRIPT_DIR/test-plugin-structure.sh" "$PLUGIN"; then
      PASSED_PLUGINS=$((PASSED_PLUGINS + 1))
    else
      FAILED_PLUGINS=$((FAILED_PLUGINS + 1))
    fi
    echo ""
  fi
done

# Test advanced plugins
echo "📚 ADVANCED PLUGINS"
echo "==================="
for PLUGIN in "$EXAMPLES_DIR"/03-advanced/*/; do
  if [ -d "$PLUGIN" ]; then
    TOTAL_PLUGINS=$((TOTAL_PLUGINS + 1))
    if bash "$SCRIPT_DIR/test-plugin-structure.sh" "$PLUGIN"; then
      PASSED_PLUGINS=$((PASSED_PLUGINS + 1))
    else
      FAILED_PLUGINS=$((FAILED_PLUGINS + 1))
    fi
    echo ""
  fi
done

# Summary
echo "=============================="
echo "📊 TEST SUMMARY"
echo "=============================="
echo "Total plugins tested: $TOTAL_PLUGINS"
echo "✅ Passed: $PASSED_PLUGINS"
echo "❌ Failed: $FAILED_PLUGINS"
echo ""

if [ $FAILED_PLUGINS -eq 0 ]; then
  echo "🎉 All plugins passed validation!"
  exit 0
else
  echo "⚠️  Some plugins failed validation"
  exit 1
fi
