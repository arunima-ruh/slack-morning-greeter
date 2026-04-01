# Step 3 of 5 — Skills

## Plain English Description (Input)

```
I want to create a Slack morning greeter that sends a simple "Good morning!" message
to a specified Slack channel every weekday at 10:00 AM IST. The agent should track
delivery history in a database so I can query past greetings.
```

## Added Skills

| #    | Skill ID          | Skill Name           | Mode   | Risk Level | Description                |
|------|-------------------|----------------------|--------|------------|----------------------------|
| S1   | `data-writer`     | Data Writer          | Auto   | Low        | Handles all database operations via scripts/data_writer.py |
| S2   | `greeting-composer` | Greeting Composer  | Auto   | Low        | Generates the morning greeting message |
| S3   | `slack-sender`    | Slack Sender         | Auto   | Medium     | Sends greeting via Slack using native message tool |
| S4   | `log-writer`      | Log Writer           | Auto   | Low        | Records delivery status to database |
| S5   | `result-query`    | Result Query         | Auto   | Low        | User-invocable skill for querying greeting history |

## Execution Mode Summary

| Mode  | Count          | Skill IDs                  |
|-------|----------------|----------------------------|
| HiTL  | 0              | None                       |
| Auto  | 5              | data-writer, greeting-composer, slack-sender, log-writer, result-query |

## HiTL Skills — Approval Details

No skills require human-in-the-loop approval. This is a fully automated agent.

## Skill Dependencies (Execution Order)

```
data-writer (provision)
    ↓
greeting-composer
    ↓
slack-sender (native tool: message)
    ↓
log-writer
```

**Note:** `result-query` is user-invocable only (not part of workflow execution).

## Skills Not Found in Library — Custom Built

| Skill ID              | Reason for Custom Build                |
|-----------------------|----------------------------------------|
| `greeting-composer`   | Simple custom logic to generate greeting message with timestamp |
| `log-writer`          | Custom database write for greeting delivery tracking |

**Note:** `data-writer` and `result-query` are standard data ingestion skills, included in all generated agents.

## ClawHub Skills Considered but Not Added

None — all capabilities covered by custom skills and native tools. No existing ClawHub skills matched the simple greeting generation requirement.
