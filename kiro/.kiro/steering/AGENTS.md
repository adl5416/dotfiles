# Preferences

## Communication
- Be terse. No filler, no fluff.
- Use simple words. Prose is fine.
- Skip obvious explanations.
- Don't over-qualify or hedge.

## Code
- Don't add comments that restate what the code does.
- Show diffs or changes inline when possible.
- Prefer complete working examples over fragments.

## Documentation
- Use Sphinx (reStructuredText) for project docs
- AsciiDoc for design/planning documents
- Markdown for READMEs and lightweight docs
- Google-style docstrings in Python
- Keep docs next to the code they describe

# Tech Stack

## Languages
- Python (primary scripting/application language)
- C++ (systems/performance-critical work)

## Environment
- Linux Mint (development)
- Neovim (editor)

## CI/CD
- GitLab CI

## Build Tools
- Python: pip, uv, venv
- C++: CMake, GNU

# Projects

All repos live under `~/Code/Iridium/`. GitLab instance: `gitlab.uk.cambridgeconsultants.com`

## Tarts (Test System)

| Repo | Path | Description | Language/Build |
|------|------|-------------|----------------|
| tarts | `Tarts/tarts` | Jam test libraries, scripts, and schedules for MPE transceivers | Python, Make |
| tos | `Tarts/tos` | Test Orchestration Software — manages and runs all TARTS tests | Python, Make |
| artr | `Tarts/artr` | ARTR hardware abstraction library used by TOS | Python, Make |
| artr-config | `Tarts/artr-config` | TOML config files for ARTR racks (git submodule of tarts) | TOML |
| trg | `Tarts/trg` | Test Report Generator — JUnit XML to PDF reports | Python, Make |
| documentation | `Tarts/documentation` | Sphinx docs: Maintainers Guide, Core Dev Guide, Product Test Guide | Sphinx/RST |

## Ess (Pulsar)

| Repo | Path | Description | Language/Build |
|------|------|-------------|----------------|
| pulsar-calibration | `Ess/pulsar-calibration` | Pulsar calibration scripts (installable via pipx) | Python, Make |
| pulsar-l1-test | `Ess/pulsar-l1-test` | Pulsar L1 test suite | Python |

## DevOps

| Repo | Path | Description | Language/Build |
|------|------|-------------|----------------|
| ansible | `DevOps/ansible` | Ansible playbooks for P2747/P3142 infrastructure | Ansible, Make |
| tarts-base-image | `DevOps/tarts-base-image` | Packer/Ansible VM image for TARTS CI rigs | Packer, Ansible |

## Idk (SDK/Tools)

| Repo | Path | Description | Language/Build |
|------|------|-------------|----------------|
| idk-9704 | `Idk/idk-9704` | IDK 9704 project | Make |
| sfx-sdk-doc-generator | `Idk/sfx-sdk-doc-generator` | Auto-generates ESVDs from Jira/GitLab data | Python |

## Other

| Repo | Path | Description |
|------|------|-------------|
| ctrl-alt-elite | `ctrl-alt-elite` | GitLab migration planning (CC → Iridium hosted) |
| Test-Integration | `Test-Integration` | Integration test configs (9523, 9770, 960x, 9810) |

# AWS Access

- Account: 336701967277
- Region: us-west-2
- Profile: isllc-336701967277-AWSAdministratorAccess

## AWS Daily Login

```bash
aws sso login --profile isllc-336701967277-AWSAdministratorAccess
```

## MCP Server

The `aws-api` MCP server in `.kiro/settings/mcp.json` uses this profile.
It provides tools for S3, Athena, CloudWatch, and other AWS services.
