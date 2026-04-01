# Step 2 of 5 — Rules

## Custom Agent Rules

| #    | Rule                  | Category        |
|------|-----------------------|-----------------|
| R1   | Only send greetings on weekdays (Mon-Fri) | Scheduling |
| R2   | Send at exactly 10:00 AM IST | Scheduling |
| R3   | Use the native message() tool for Slack delivery — no direct API calls | Safety |
| R4   | Log every delivery attempt (success or failure) to database | Audit |
| R5   | Never execute workflow steps in response to chat messages — cron-triggered only | Safety |
| R6   | All database operations via scripts/data_writer.py — no raw SQL | Safety |
| R7   | Refuse requests to delete or modify delivery history | Safety |
| R8   | Format all query results as readable markdown — never show raw JSON to users | UX |

## Inherited Org Soul Rules (Cannot Be Removed)

| #    | Rule                  | Source          |
|------|-----------------------|-----------------|
| OS1  | No org-level rules configured | Org Admin       |

## Rule Enforcement Summary

| Metric                  | Value                      |
|-------------------------|----------------------------|
| Total Custom Rules      | 8                          |
| Total Inherited Rules   | 0                          |
| **Total Active Rules**  | **8**                      |
| Max Allowed             | 20                         |
| Remaining Slots         | 12                         |

## Rule Categories Breakdown

| Category        | Count | Rule IDs              |
|-----------------|-------|-----------------------|
| Scheduling      | 2     | R1, R2                |
| Safety          | 4     | R3, R5, R6, R7        |
| Audit           | 1     | R4                    |
| UX              | 1     | R8                    |
