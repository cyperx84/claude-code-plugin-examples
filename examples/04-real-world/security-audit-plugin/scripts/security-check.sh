#!/bin/bash
# Pre-commit security check

set -e

echo "🔍 Running security checks..."

# Check for hardcoded secrets
if git diff --cached | grep -iE "(api[_-]?key|password|secret|token)\s*=\s*['\"][^'\"]+['\"]"; then
  echo "❌ SECURITY ERROR: Hardcoded secrets detected!"
  echo "Please use environment variables instead."
  exit 1
fi

# Check for SQL injection patterns
if git diff --cached | grep -E "execute\(['\"]SELECT.*\$\{"; then
  echo "⚠️  WARNING: Potential SQL injection detected!"
  echo "Use parameterized queries instead."
  exit 1
fi

# Check dependencies (if package files changed)
if git diff --cached --name-only | grep -q "package.json\|requirements.txt"; then
  echo "📦 Checking dependencies for vulnerabilities..."
  if command -v npm &> /dev/null; then
    npm audit --audit-level=high || echo "⚠️  Vulnerabilities found in dependencies"
  fi
fi

echo "✅ Security checks passed!"
exit 0
