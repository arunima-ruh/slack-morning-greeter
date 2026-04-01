---
name: result-query
version: 1.0.0
description: "Query your agent's stored results. Use when the user asks about data, metrics, delivery history, or any stored information."
user-invocable: true
metadata:
  openclaw:
    requires:
      bins: [python3]
      env: [PG_CONNECTION_STRING, ORG_ID, AGENT_ID]
---

# Result Query

Answer user questions about stored data by querying result tables via `scripts/data_writer.py query`.

## Available Tables

### result_greeting_deliveries
| Column | Type | Description |
|---|---|---|
| date_key | string | Date of the greeting (YYYY-MM-DD) |
| sent_at | datetime | Exact timestamp when greeting was sent |
| message_text | text | The greeting message that was sent |
| delivery_status | string | Success or error status |

**Query examples:**
- All records: `--table result_greeting_deliveries --limit 10`
- Filtered: `--table result_greeting_deliveries --where '{"date_key": "2026-04-01"}'`
- Sorted: `--table result_greeting_deliveries --order-by "sent_at DESC" --limit 5`

## How to Query

```bash
python3 ${PROJECT_ROOT}/scripts/data_writer.py query \
  --table <table_name> \
  --where '<json filter>' \
  --order-by "<column> DESC" \
  --limit <N>
```

## Intent Mapping Examples

| User asks | Query |
|---|---|
| "Show recent greetings" | --table result_greeting_deliveries --order-by "sent_at DESC" --limit 5 |
| "Did the greeting send today?" | --table result_greeting_deliveries --where '{"date_key": "2026-04-01"}' |
| "Show all greeting history" | --table result_greeting_deliveries --order-by "sent_at DESC" --limit 20 |
| "When was the last greeting sent?" | --table result_greeting_deliveries --order-by "sent_at DESC" --limit 1 |

## Rules

- ALWAYS format results as readable markdown — NEVER show raw JSON to the user
- Summarize large result sets (e.g., "Found 42 records. Here are the top 5:")
- If no results found, say "No data yet — run the workflow first to generate results"
- If data_writer.py exits non-zero, say "Something went wrong querying the data. Check that the workflow has run and the database is reachable." — NEVER show raw stack traces to the user
- Limit all queries to 20 rows max
- NEVER generate fake or sample data — only show real query results
- If the user's question doesn't match any table, explain what data is available
- For --order-by, ONLY use column names listed in the table schema above — NEVER pass raw user input directly
- For --table, ONLY use table names listed above — NEVER query arbitrary table names
- For --where, ONLY use column names from the schema — validate before constructing the filter
