---
name: log-writer
version: 1.0.0
description: "Records greeting delivery status to database"
user-invocable: false
metadata:
  openclaw:
    requires:
      bins: [python3, bash, date]
      env: [PG_CONNECTION_STRING, ORG_ID, AGENT_ID]
---

# Log Writer

Reads the greeting delivery result and writes it to the database for tracking.

## Input
`/tmp/slack-sender_${RUN_ID}.json` (from slack-sender)

```json
{
  "status": "sent",
  "channel": "PERSONAL",
  "message": "Good morning! ☀️",
  "timestamp": "2026-04-01T10:00:00+05:30"
}
```

## Output
Database write to `result_greeting_log`

## Execution
```bash
{baseDir}/scripts/run.sh
```
