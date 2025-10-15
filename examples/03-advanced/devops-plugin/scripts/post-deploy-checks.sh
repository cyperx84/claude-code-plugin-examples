#!/bin/bash
# Post-deployment verification script

echo "🔍 Running post-deployment checks..."

# Wait for rollout to complete
echo "Waiting for rollout to complete..."
sleep 5

# Check pod status
echo "Checking pod status..."
FAILED_PODS=$(kubectl get pods --all-namespaces --field-selector status.phase!=Running,status.phase!=Succeeded 2>/dev/null | grep -v "No resources" | wc -l)
if [ "$FAILED_PODS" -gt 0 ]; then
  echo "⚠️  Warning: $FAILED_PODS pod(s) not running"
  kubectl get pods --all-namespaces --field-selector status.phase!=Running
fi

# Check if deployment is healthy
echo "Verifying deployment health..."
READY_REPLICAS=$(kubectl get deployments --all-namespaces -o json | jq '[.items[] | select(.status.readyReplicas == .status.replicas)] | length')
TOTAL_DEPLOYMENTS=$(kubectl get deployments --all-namespaces -o json | jq '.items | length')

echo "📊 Deployments: $READY_REPLICAS/$TOTAL_DEPLOYMENTS ready"

if [ "$READY_REPLICAS" -eq "$TOTAL_DEPLOYMENTS" ]; then
  echo "✅ All deployments healthy"
else
  echo "⚠️  Some deployments not fully ready"
fi

echo "✅ Post-deployment checks complete"
