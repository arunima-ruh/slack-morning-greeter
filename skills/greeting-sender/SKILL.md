---
name: greeting-sender
version: 1.0.0
description: "Sends morning greeting via Slack DM and records delivery"
user-invocable: false
metadata:
  openclaw:
    requires:
      bins: [bash, date]
      env: [SLACK_BOT_TOKEN, SLACK_USER_ID]
---

# Greeting Sender

Sends the morning greeting "Good morning openclaw" via Slack DM using the native `message` tool and records the delivery in the database.

## Execution

```bash
{baseDir}/scripts/run.sh
```

## Input
None (triggered by cron)

## Output
- File: `/tmp/greeting-sender_${RUN_ID}.json`
- Format: JSON with delivery record
- Example:
```json
{
  "date_key": "2026-04-01",
  "sent_at": "2026-04-01T10:00:00Z",
  "message_text": "Good morning openclaw",
  "delivery_status": "success"
}
```
