## 🚀 Production Readiness & Operational Runbook

---

## 1. Deployment Checklist

### ✅ Pre-Deployment

* [ ] Code reviewed and approved
* [ ] All tests passing (unit, integration)
* [ ] Environment variables configured
* [ ] Database backup taken
* [ ] Migrations reviewed for safety (no long locks, large table rewrites)
* [ ] Feature flags enabled (if applicable)

---

### 🚢 Deployment Steps

* [ ] Pull latest code on server
* [ ] Install dependencies (`bundle install`, `yarn install`)
* [ ] Precompile assets
* [ ] Run database migrations:

  ```bash
  rails db:migrate
  ```
* [ ] Restart application server (Puma/Passenger)
* [ ] Restart background workers (Sidekiq)

---

### 🔍 Post-Deployment Verification

* [ ] Application is accessible (homepage loads)
* [ ] API health endpoint returns 200
* [ ] Background jobs are processing
* [ ] Logs show no critical errors
* [ ] Smoke test script passes

---

### 🔁 Rollback Plan

* [ ] Identify last stable release
* [ ] Revert code:

  ```bash
  git checkout <previous_commit>
  ```
* [ ] Rollback database (if needed):

  ```bash
  rails db:rollback STEP=1
  ```
* [ ] Restart services
* [ ] Verify system health

---

## 2. Incident Runbook

---

### 🚨 API Outage Runbook

#### Step 1: Identify Issue

* Check application logs:

  ```bash
  tail -f log/production.log
  ```
* Verify server status (CPU, memory)
* Check if app is responding:

  ```bash
  curl -I http://your-app.com/health
  ```

---

#### Step 2: Quick Fixes

* Restart application server:

  ```bash
  systemctl restart app
  ```
* Restart web server (NGINX):

  ```bash
  systemctl restart nginx
  ```

---

#### Step 3: Investigate Root Cause

* Recent deployments?
* Database connectivity issues?
* External API failures?

---

#### Step 4: Escalation

* Notify team
* Rollback if issue persists

---

### 📦 Sidekiq Backlog Runbook

#### Step 1: Check Queue Status

* Access Sidekiq dashboard (`/sidekiq`)
* Identify queue size and latency

---

#### Step 2: Immediate Actions

* Restart Sidekiq:

  ```bash
  systemctl restart sidekiq
  ```
* Scale workers (if possible)

---

#### Step 3: Diagnose Issue

* Check failing jobs
* Look for:

  * External API delays
  * Database locks
  * Infinite retries

---

#### Step 4: Resolution

* Fix failing job logic
* Clear stuck jobs (if safe)
* Retry failed jobs

---

#### Step 5: Prevention

* Add retries with backoff
* Add monitoring alerts
* Optimize heavy jobs

---

## 3. Release Checklist Table

| Step                | Status | Notes |
| ------------------- | ------ | ----- |
| Code Reviewed       | ☐      |       |
| Tests Passed        | ☐      |       |
| DB Backup Taken     | ☐      |       |
| Migrations Safe     | ☐      |       |
| Deploy Completed    | ☐      |       |
| Smoke Tests Passed  | ☐      |       |
| Rollback Plan Ready | ☐      |       |

---

## 4. Self-Check Answers

**1. First steps during API outage**

* Check logs
* Verify health endpoint
* Restart services

**2. How is rollback triggered safely**

* Revert to previous commit
* Rollback DB if needed
* Restart services
* Verify system health

**3. Which checks confirm system is healthy**

* Health endpoint returns 200
* Logs show no errors
* Background jobs processing
* Smoke tests pass

---

# 🧪 `scripts/smoke-test.sh`

```bash
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
```

---

## 💡 Pro Tips (what reviewers love)

* Keep runbooks **actionable** (commands > theory)
* Always include **rollback**
