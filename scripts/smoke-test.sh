#!/bin/bash

echo "Running smoke tests..."

BASE_URL="http://localhost:3000"

# 1. Check homepage
echo "Checking homepage..."
STATUS=$(curl -o /dev/null -s -w "%{http_code}" $BASE_URL)
if [ "$STATUS" != "200" ]; then
  echo "❌ Homepage failed with status $STATUS"
  exit 1
fi

# 2. Check health endpoint
echo "Checking health endpoint..."
STATUS=$(curl -o /dev/null -s -w "%{http_code}" $BASE_URL/health)
if [ "$STATUS" != "200" ]; then
  echo "❌ Health check failed"
  exit 1
fi

# 3. Check API endpoint (example)
echo "Checking API endpoint..."
STATUS=$(curl -o /dev/null -s -w "%{http_code}" $BASE_URL/api/v1/users)
if [ "$STATUS" != "200" ]; then
  echo "❌ API endpoint failed"
  exit 1
fi

echo "✅ All smoke tests passed!"
exit 0