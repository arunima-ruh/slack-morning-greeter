# Step 4 of 5 — Triggers

## Active Triggers

### T1 — On User Message (Always On)

| Field       | Value                              |
|-------------|------------------------------------|
| **Type**    | Conversational                     |
| **Status**  | ✅ Always On                       |
| **Channel** | Webchat, configured channels       |

**Sample User Queries This Trigger Handles:**

- "Show my recent greetings"
- "Did the greeting send today?"
- "Show failed deliveries"
- "What was yesterday's message?"
- "Show greeting history for the past week"

**Note:** This agent does NOT execute workflow steps in response to chat messages. It only queries and displays stored data. Workflow execution is cron-triggered only.

---

### T2 — Scheduled: Morning Greeting

| Field           | Value                              |
|-----------------|------------------------------------|
| **Type**        | Scheduled                          |
| **Status**      | ✅ Active                          |
| **Frequency**   | Weekdays only (Mon-Fri)            |
| **Time**        | 10:00 AM IST (04:30 UTC)           |
| **Cron**        | `30 4 * * 1-5`                     |

**What It Does:**

- Generates a simple "Good morning! ☀️" message
- Sends the message to the configured Slack channel using the native message() tool
- Logs the delivery status (sent/failed) to the database

**Important:** This trigger is the ONLY way the workflow executes. Users cannot trigger greetings via chat.

---

## Trigger Summary

| Trigger Type        | Count | Trigger IDs |
|---------------------|-------|-------------|
| Conversational      | 1     | T1          |
| Scheduled           | 1     | T2          |
| Heartbeat           | 0     | None        |
| Webhook             | 0     | None        |
