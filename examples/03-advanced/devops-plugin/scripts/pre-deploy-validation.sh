#!/bin/bash
# Pre-deployment validation script

set -e

echo "🔍 Running pre-deployment validation..."

# Check cluster health
echo "Checking cluster health..."
if ! kubectl get nodes | grep -q "Ready"; then
  echo "❌ Cluster not healthy"
  exit 1
fi

# Check for sufficient resources
echo "Checking cluster capacity..."
NODE_CPU=$(kubectl top nodes --no-headers | awk '{sum+=$3} END {print sum}' | sed 's/%//')
if [ "${NODE_CPU:-0}" -gt 85 ]; then
  echo "❌ Cluster CPU usage too high (${NODE_CPU}%)"
  exit 1
fi

# Check for ongoing deployments
echo "Checking for concurrent deployments..."
PENDING_ROLLOUTS=$(kubectl get deployments --all-namespaces -o json | jq '[.items[] | select(.status.conditions[] | select(.type=="Progressing" and .status=="True"))] | length')
if [ "$PENDING_ROLLOUTS" -gt 0 ]; then
  echo "⚠️  Warning: $PENDING_ROLLOUTS deployment(s) in progress"
fi

# Run tests (if available)
if [ -f "package.json" ]; then
  echo "Running tests..."
  npm test --silent || {
    echo "❌ Tests failed"
    exit 1
  }
fi

echo "✅ Pre-deployment validation passed"
exit 0
