---
name: greeting-composer
version: 1.0.0
description: "Generates the morning greeting message for Slack delivery"
user-invocable: false
metadata:
  openclaw:
    requires:
      bins: [bash, date]
      env: []
---

# Greeting Composer

Generates a simple "Good morning!" message with the current date.

## Input
None (uses system date)

## Output
`/tmp/greeting-composer_${RUN_ID}.json`

```json
{
  "message": "Good morning! ☀️",
  "channel": "${SLACK_CHANNEL}",
  "timestamp": "2026-04-01T10:00:00+05:30"
}
```

## Execution
```bash
{baseDir}/scripts/run.sh
```
