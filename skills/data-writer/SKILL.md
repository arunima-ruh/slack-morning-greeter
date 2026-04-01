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

Handles all database operations with safety guards. Only CREATE TABLE IF NOT EXISTS, INSERT, and ON CONFLICT DO UPDATE are allowed. DROP, DELETE, TRUNCATE, ALTER are BLOCKED.

## Provision (first run only)
```bash
python3 ${PROJECT_ROOT}/scripts/data_writer.py provision
```

## Write to result_greeting_deliveries
```bash
python3 ${PROJECT_ROOT}/scripts/data_writer.py write \
  --table result_greeting_deliveries \
  --conflict "date_key" \
  --run-id "${RUN_ID}" \
  --records '[{"date_key": "2026-04-01", "sent_at": "2026-04-01T10:00:00Z", "message_text": "Good morning openclaw", "delivery_status": "success"}]'
```

## Query result_greeting_deliveries
```bash
python3 ${PROJECT_ROOT}/scripts/data_writer.py query \
  --table result_greeting_deliveries \
  --limit 10 \
  --order-by "computed_at DESC"
```
