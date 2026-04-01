# Step 5 of 5 — Access

## User Access

| Field              | Value                          |
|--------------------|--------------------------------|
| **Access Type**    | Team-wide                      |

### Authorized Teams

| Team               | Access Level | Members (approx) |
|--------------------|-------------|-------------------|
| Engineering        | Full        | TBD               |

### Restricted From

No restrictions — agent is accessible to all team members with OpenClaw access.

---

## HiTL Approvers

This agent has no human-in-the-loop approval steps. All workflow execution is fully automated.

---

## Model Configuration

| Field                | Value                          |
|----------------------|--------------------------------|
| **Primary Model**    | Default (inherited from org)   |
| **Fallback Model**   | Not configured                 |
| **Token Budget**     | Not specified (use org default)|

---

## External API Access

| API / Service      | Purpose                | Auth Method           | Rate Limit       |
|--------------------|------------------------|-----------------------|------------------|
| Slack              | Message delivery       | Bot token             | Standard tier    |
| PostgreSQL         | Greeting history       | Connection string     | No limit         |

---

## Data Access Scope

| Data Source        | Access Level           | Notes                          |
|--------------------|------------------------|--------------------------------|
| result_greeting_log | Read/Write (own schema)| Agent can query and write logs |
| Other schemas      | No access              | Blocked at database level      |

---

## Security Notes

- **Database safety:** All operations via scripts/data_writer.py — no raw SQL, no DROP/DELETE/TRUNCATE
- **Slack token:** Store SLACK_BOT_TOKEN in .env, never commit to git
- **Read-only queries:** Users can query greeting history but cannot delete records
- **No external webhooks:** Agent does not expose any inbound webhook endpoints
