# Step 4 of 5 — Triggers

## Active Triggers

### conversational — On User Message (Always On)

| Field       | Value                              |
|-------------|------------------------------------|
| **Type**    | Conversational                     |
| **Status**  | ✅ Always On                       |
| **Channel** | Any (Slack, Telegram, Web UI)      |

**Sample User Queries This Trigger Handles:**

- "Did the greeting send today?"
- "Show recent greetings"
- "When was the last greeting sent?"
- "Show greeting history"
- "What data do you track?"

---

### morning-greeting — Scheduled: Daily Morning Greeting

| Field           | Value                              |
|-----------------|------------------------------------|
| **Type**        | Scheduled                          |
| **Status**      | ✅ Active                          |
| **Frequency**   | Daily                              |
| **Time**        | 10:00 AM UTC                       |
| **Cron**        | `0 10 * * *`                       |

**What It Does:**

- Sends "Good morning openclaw" via Slack DM
- Records delivery timestamp in database
- Updates delivery status (success/error)

---

## Trigger Summary

| Trigger Type    | Count | Status  |
|-----------------|-------|---------|
| Conversational  | 1     | ✅ On   |
| Scheduled       | 1     | ✅ On   |
| Heartbeat       | 0     | N/A     |
| Webhook         | 0     | N/A     |
| **Total**       | **2** | **Active** |
