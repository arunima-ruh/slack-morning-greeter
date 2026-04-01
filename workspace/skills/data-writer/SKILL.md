---
name: data-writer
version: 1.0.0
description: "Writes and queries agent results via scripts/data_writer.py."
user-invocable: false
metadata:
  openclaw:
    always: true
    requires:
      bins: [python3]
      env: [PG_CONNECTION_STRING, ORG_ID, AGENT_ID]
---

# Data Writer

## Provision (first run only)
```bash
python3 scripts/data_writer.py provision
```

## Write to result_greeting_log
```bash
python3 scripts/data_writer.py write \
  --table result_greeting_log \
  --conflict "date_key" \
  --run-id "${RUN_ID}" \
  --records '[{"date_key": "2026-04-01", "channel": "PERSONAL", "message_content": "Good morning!", "sent_at": "2026-04-01T10:00:00+05:30", "status": "sent"}]'
```

## Query result_greeting_log
```bash
python3 scripts/data_writer.py query \
  --table result_greeting_log \
  --limit 10 \
  --order-by "computed_at DESC"
```
