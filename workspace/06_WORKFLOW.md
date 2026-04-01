# Workflow — End-to-End Process Flow

## Complete Workflow

```
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│   PHASE 1: Database Initialization                                      │
│                                                                          │
│   Provision database schema and tables                   ← [Auto]       │
│           ↓                                                              │
│   If PG_CONNECTION_STRING not set → Skip database steps                 │
│   If PG_CONNECTION_STRING set → Continue                                │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   PHASE 2: Greeting Delivery (Triggered: T1)                            │
│                                                                          │
│   Generate date_key (YYYY-MM-DD)                         ← [Auto]       │
│           ↓                                                              │
│   Send "Good morning openclaw" via Slack DM              ← [Auto]       │
│           ↓                                                              │
│   Record delivery timestamp                              ← [Auto]       │
│           ↓                                                              │
│   If send succeeds → Set status = "success"                              │
│   If send fails → Set status = "error"                                   │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   PHASE 3: Data Storage                                                 │
│                                                                          │
│   Write delivery record to result_greeting_deliveries   ← [Auto]       │
│           ↓                                                              │
│   Upsert on conflict (date_key)                         ← [Auto]       │
│           ↓                                                              │
│   If database write fails → Log error, continue                          │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   PHASE 4: User Queries (Triggered: Conversational)                     │
│                                                                          │
│   User asks "Did the greeting send today?"              ← [Auto]       │
│           ↓                                                              │
│   Query result_greeting_deliveries for today's date     ← [Auto]       │
│           ↓                                                              │
│   Format results as markdown                             ← [Auto]       │
│           ↓                                                              │
│   If no results → "No data yet — workflow hasn't run"                    │
│   If results found → Show delivery status and timestamp                  │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

## Exception Handling

| Exception                        | Agent Action                          | Escalation           |
|----------------------------------|---------------------------------------|----------------------|
| Slack API returns 401/403        | Log error, set status = "error"       | User (check token)   |
| PG_CONNECTION_STRING invalid     | Skip database steps, continue         | User (check DB config) |
| Database write fails             | Log error, continue workflow          | User (check DB access) |
| User ID not found in Slack       | Return error message to user          | User (verify USER_ID) |
