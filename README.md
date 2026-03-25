This project demonstrates **production readiness practices** by defining:

* Safe deployment procedures
* Incident response runbooks
* Post-deployment smoke testing

The goal is to ensure that **any engineer can deploy, verify, and recover the system independently**.

---

## Project Structure

```
assignment_17_app/
├── docs/
│   └── assignment-17.md        # Deployment checklist + runbooks
├── scripts/
│   └── smoke-test.sh          # Post-deploy validation script
├── app/
├── config/
└── db/
```

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd assignment_17_app
```

---

### 2. Install Dependencies

```bash
bundle install
```

---

### 3. Setup Database

```bash
bin/rails db:create
bin/rails db:migrate
```

---

### 4. Start Server

```bash
bin/rails server
```

App will run on:

```
http://localhost:3000
```

---

## Smoke Test

Run the post-deployment verification script:

```bash
./scripts/smoke-test.sh
```

### What it checks:

* Homepage availability
* `/health` endpoint
* `/api/v1/users` endpoint

---

## Key Endpoints

| Endpoint        | Purpose                       |
| --------------- | ----------------------------- |
| `/health`       | Health check (returns 200 OK) |
| `/api/v1/users` | Sample API endpoint           |

---

## Runbook & Deployment Guide

Detailed operational procedures are available here:

```
docs/assignment-17.md
```

Includes:

* Deployment checklist
* Rollback plan
* API outage handling
* Sidekiq backlog handling

---

## Incident Handling

### API Outage

* Check logs
* Verify health endpoint
* Restart services
* Rollback if required

### Sidekiq Backlog

* Inspect queue
* Restart workers
* Retry failed jobs
* Scale workers if needed

---

## Rollback Strategy

* Revert to last stable commit
* Rollback DB migrations (if required)
* Restart services
* Verify system health

---

## Completion Criteria

This project ensures:

* Another engineer can follow the runbook independently
* Deployment includes rollback & verification
* Smoke tests validate critical paths

---

## Common Pitfalls Avoided

* Missing rollback steps
* Vague runbooks
* Non-functional smoke tests

---

## Key Learnings

* Production-safe deployments
* Structured incident response
* System health validation

---
