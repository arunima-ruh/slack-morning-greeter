# ☀️ Slack Morning Greeter

## Agent Overview

| Field            | Value                          |
|------------------|--------------------------------|
| **Agent Name**   | Slack Morning Greeter          |
| **Agent ID**     | `slack-morning-greeter`        |
| **Version**      | 1.0.0                          |
| **Avatar**       | ☀️                              |
| **Tone**         | Friendly and warm              |
| **Scope**        | Daily morning greeting delivery via Slack DM |
| **Model**        | openrouter/anthropic/claude-sonnet-4.5 |
| **Token Budget** | 50,000 per conversation        |
| **Status**       | Ready for deployment           |
| **Created By**   | OpenClaw Agent Factory         |
| **Created On**   | 2026-04-01                     |

## Greeting Message

```
Good morning! I'm your Slack Morning Greeter. I send a friendly "Good morning openclaw" to your Slack DM every day at 10:00 AM UTC.
```

## Agent File Structure

```
slack-morning-greeter/
├── README.md
├── openclaw.json
├── result-schema.yml
├── requirements.txt
├── .env.example
├── env-manifest.yml
├── .gitignore
├── check-environment.sh
├── install-dependencies.sh
├── test-workflow.sh
├── scripts/
│   └── data_writer.py
├── cron/
│   └── morning-greeting.json
├── workspace/
│   ├── SOUL.md
│   ├── 01_IDENTITY.md
│   ├── 02_RULES.md
│   ├── 03_SKILLS.md
│   ├── 04_TRIGGERS.md
│   ├── 05_ACCESS.md
│   ├── 06_WORKFLOW.md
│   ├── 07_REVIEW.md
│   └── skills/
│       ├── data-writer/
│       ├── greeting-sender/
│       └── result-query/
├── skills/
│   ├── data-writer/
│   ├── greeting-sender/
│   └── result-query/
└── workflows/
    └── main.yaml
```

## Quick Stats

| Metric              | Count            |
|----------------------|-----------------|
| Custom Rules         | 5                |
| Inherited Org Rules  | 0                |
| Total Skills         | 3                |
| Skills (HiTL)       | 0                |
| Skills (Auto)        | 3                |
| Scheduled Triggers   | 1                |
| Heartbeat Monitors   | 0                |
| Webhook Triggers     | 0                |
| Accessible Teams     | Everyone         |

## Quick Start

### 1. Install Dependencies

```bash
./install-dependencies.sh
```

### 2. Configure Environment

```bash
cp .env.example .env
# Edit .env with your Slack credentials
```

### 3. Check Environment

```bash
./check-environment.sh
```

### 4. Test Workflow

```bash
./test-workflow.sh
```

### 5. Deploy

Deploy this agent to your OpenClaw instance and enable the cron job. First greeting will send at 10:00 AM UTC tomorrow.

## Required Environment Variables

- `SLACK_BOT_TOKEN` — Your Slack bot token (xoxb-...)
- `SLACK_USER_ID` — Target user ID for greeting (U...)

## Optional Environment Variables

- `PG_CONNECTION_STRING` — PostgreSQL for delivery tracking
- `ORG_ID` — Organisation identifier
- `AGENT_ID` — Agent identifier (defaults to slack-morning-greeter)

## What This Agent Does

- Sends "Good morning openclaw" via Slack DM daily at 10:00 AM UTC
- Records each delivery in PostgreSQL (optional)
- Answers questions about greeting history

## What This Agent Does NOT Do

- Custom greeting messages per day
- Multiple recipients
- Dynamic content (weather, news, etc.)
- Two-way conversation

## Support

For detailed documentation, see the `workspace/` directory:
- **01_IDENTITY.md** — Agent identity and persona
- **02_RULES.md** — Behavior rules
- **03_SKILLS.md** — Skills and execution modes
- **04_TRIGGERS.md** — Trigger configuration
- **05_ACCESS.md** — Access control
- **06_WORKFLOW.md** — End-to-end process flow
- **07_REVIEW.md** — Final summary and deployment checklist
