# Workflow — End-to-End Process Flow

## Complete Workflow

```
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│   PHASE 1: Database Provisioning (First Run Only)                       │
│                                                                          │
│   Provision result_greeting_log table                 ← [Auto]          │
│           ↓                                                              │
│   If table exists → skip                                                 │
│   If table missing → create                                              │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   PHASE 2: Greeting Composition                                         │
│                                                                          │
│   Generate "Good morning! ☀️" message                 ← [Auto]          │
│           ↓                                                              │
│   Add timestamp (current time in UTC)                 ← [Auto]          │
│           ↓                                                              │
│   Write to /tmp/greeting-composer_${RUN_ID}.json     ← [Auto]          │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   PHASE 3: Slack Delivery                                               │
│                                                                          │
│   Read greeting message from temp file                ← [Auto]          │
│           ↓                                                              │
│   Send via Slack using message() tool                 ← [Auto]          │
│           ↓                                                              │
│   Write delivery status to /tmp/slack-sender_${RUN_ID}.json ← [Auto]   │
│                                                                          │
│   If delivery fails → log status="failed"                                │
│   If delivery succeeds → log status="sent"                               │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   PHASE 4: Database Logging                                             │
│                                                                          │
│   Read delivery status from temp file                 ← [Auto]          │
│           ↓                                                              │
│   Extract: date_key, channel, message, sent_at, status ← [Auto]        │
│           ↓                                                              │
│   Upsert into result_greeting_log                     ← [Auto]          │
│     (conflict key: date_key)                                             │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

## Trigger Flow

| Trigger | Activates | Workflow Phases |
|---------|-----------|-----------------|
| T1 (User message) | Conversational mode — query only | None (no workflow execution) |
| T2 (Cron: 10 AM IST Mon-Fri) | Workflow execution | All phases (1-4) |

**CRITICAL:** The workflow ONLY runs when triggered by cron (T2). Chat messages do NOT execute the workflow — they only query stored data.

## Exception Handling

| Exception                        | Agent Action                          | Escalation           |
|----------------------------------|---------------------------------------|----------------------|
| Slack API rate limit exceeded    | Log status="failed", skip retry       | None (next cron run) |
| SLACK_BOT_TOKEN invalid          | Log status="failed", report to logs   | None (manual fix)    |
| Database connection fails        | Log to stdout, skip database write    | None (agent continues without DB) |
| Temp file missing                | Exit with error code 1                | None (cron retry)    |
| message() tool unavailable       | Log status="failed", exit             | None (manual investigation) |

## Recovery Behavior

- **Database writes are optional** — if PG_CONNECTION_STRING is not set, agent skips logging and continues
- **Cron handles retries** — failed runs do NOT auto-retry within the same execution
- **Upsert on date_key** — re-running the same day overwrites the previous log entry (safe to re-run)
- **No state carryover** — each run is independent, no cross-run dependencies
