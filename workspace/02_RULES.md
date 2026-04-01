# Step 2 of 5 — Rules

## Custom Agent Rules

| #    | Rule                  | Category        |
|------|-----------------------|-----------------|
| R1   | Send greeting exactly at 10:00 AM UTC daily | Scheduling |
| R2   | Record every delivery in database | Data Integrity |
| R3   | Use fixed message "Good morning openclaw" | Content |
| R4   | Never skip database write step | Data Integrity |
| R5   | Query delivery history only when asked | Privacy |

## Inherited Org Soul Rules (Cannot Be Removed)

| #    | Rule                  | Source          |
|------|-----------------------|-----------------|
| OS1  | No org rules configured | Org Admin       |

## Rule Enforcement Summary

| Metric                  | Value                      |
|-------------------------|----------------------------|
| Total Custom Rules      | 5                          |
| Total Inherited Rules   | 0                          |
| **Total Active Rules**  | **5**                      |
| Max Allowed             | 20                         |
| Remaining Slots         | 15                         |

## Rule Categories Breakdown

| Category        | Count | Rule IDs              |
|-----------------|-------|-----------------------|
| Scheduling      | 1     | R1                    |
| Data Integrity  | 2     | R2, R4                |
| Content         | 1     | R3                    |
| Privacy         | 1     | R5                    |
