#!/bin/bash
# Coverage threshold checking script

COVERAGE_FILE="coverage/coverage-summary.json"
MIN_COVERAGE=80

if [ -f "$COVERAGE_FILE" ]; then
  # Extract coverage percentage (works with Jest/Vitest coverage-summary.json)
  COVERAGE=$(cat "$COVERAGE_FILE" | grep -o '"lines":{"total":[0-9]*,"covered":[0-9]*,"skipped":[0-9]*,"pct":[0-9.]*' | grep -o 'pct":[0-9.]*' | cut -d':' -f2)

  if [ -n "$COVERAGE" ]; then
    COVERAGE_INT=${COVERAGE%.*}

    echo "📊 Current coverage: ${COVERAGE}%"

    if [ "$COVERAGE_INT" -lt "$MIN_COVERAGE" ]; then
      echo "⚠️  Coverage below threshold (${MIN_COVERAGE}%)"
      echo "Consider adding more tests to reach ${MIN_COVERAGE}%"
    else
      echo "✅ Coverage meets threshold (${MIN_COVERAGE}%)"
    fi
  fi
else
  echo "ℹ️  No coverage report found. Run tests with coverage enabled."
fi
