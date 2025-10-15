#!/bin/bash
# Pre-commit test validation script

set -e

echo "🧪 Running pre-commit tests..."

# Check if there are staged files
if ! git diff --cached --quiet; then
  # Detect test framework and run appropriate tests
  if [ -f "package.json" ]; then
    if grep -q "jest" package.json || grep -q "vitest" package.json; then
      echo "Running JavaScript/TypeScript tests..."
      npm test -- --changedSince=HEAD --passWithNoTests || {
        echo "❌ Tests failed. Commit blocked."
        echo "Fix failing tests before committing."
        exit 1
      }
    fi
  elif [ -f "pytest.ini" ] || [ -f "setup.py" ]; then
    echo "Running Python tests..."
    pytest --exitfirst || {
      echo "❌ Tests failed. Commit blocked."
      exit 1
    }
  elif [ -f "go.mod" ]; then
    echo "Running Go tests..."
    go test ./... || {
      echo "❌ Tests failed. Commit blocked."
      exit 1
    }
  fi

  echo "✅ All tests passed!"
else
  echo "No staged changes, skipping tests."
fi

exit 0
