# Step 3 of 5 — Skills

## Plain English Description (Input)

```
Send a daily morning greeting "Good morning openclaw" via Slack DM at 10:00 AM UTC, and track delivery history in a database.
```

## Added Skills

| #    | Skill ID          | Skill Name           | Mode   | Risk Level | Description                |
|------|-------------------|----------------------|--------|------------|----------------------------|
| S1   | `data-writer`     | Data Writer          | Auto   | Low        | Handles all database operations with safety guards |
| S2   | `greeting-sender` | Greeting Sender      | Auto   | Low        | Sends morning greeting via Slack DM and records delivery |
| S3   | `result-query`    | Result Query         | Auto   | Low        | Query delivery history (user-invocable) |

## Execution Mode Summary

| Mode  | Count          | Skill IDs                  |
|-------|----------------|----------------------------|
| HiTL  | 0              | None                       |
| Auto  | 3              | data-writer, greeting-sender, result-query |

## HiTL Skills — Approval Details

None — all skills are fully automated

## Skill Dependencies (Execution Order)

```
data-writer
    ↓
greeting-sender (uses native message tool)
    ↓
data-writer (write results)
```

## Skills Not Found in Library — Custom Built

| Skill ID              | Reason for Custom Build                |
|-----------------------|----------------------------------------|
| `greeting-sender`     | Simple custom logic for Slack greeting with database tracking |

## ClawHub Skills Considered but Not Added

None — all functionality covered by custom skills and native tools
