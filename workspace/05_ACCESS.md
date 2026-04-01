# Step 5 of 5 — Access

## User Access

| Field              | Value                          |
|--------------------|--------------------------------|
| **Access Type**    | Open (no restrictions)         |

### Authorized Teams

| Team               | Access Level | Members (approx) |
|--------------------|-------------|-------------------|
| Everyone           | Full        | All              |

### Restricted From

None — this is a simple notification bot with no sensitive operations

---

## HiTL Approvers

None — all operations are fully automated

---

## Model Configuration

| Field                        | Value                          |
|------------------------------|--------------------------------|
| **Default Model**            | openrouter/anthropic/claude-sonnet-4.5 |
| **Reasoning Mode**           | Off                            |
| **Token Budget per Session** | 50,000                         |
| **Budget Reset**             | Per conversation               |

---

## Rate Limits

| Field                      | Value                          |
|----------------------------|--------------------------------|
| **Max Queries per Hour**   | Unlimited                      |
| **Max Concurrent Sessions**| 1 (cron-triggered only)        |

---

## Permission Matrix

| Permission                | Granted |
|---------------------------|---------|
| Read delivery history     | ✅ Yes  |
| Send greeting (manual)    | ✅ Yes  |
| Modify greeting message   | ❌ No   |
| Access other agents' data | ❌ No   |
| Modify database schema    | ❌ No   |
