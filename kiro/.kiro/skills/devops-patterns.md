---
name: devops-patterns
description: DevOps conventions for CI/CD, containers, and infrastructure. Use when writing pipelines, Dockerfiles, or deployment configs.
---

## Docker
- Use multi-stage builds to keep images small
- Pin base image versions, don't use :latest
- Run as non-root user
- One process per container
- Use .dockerignore

## GitLab CI
- Use stages: lint, test, build, deploy
- Cache dependencies between jobs
- Use rules: over only:/except:
- Keep jobs idempotent
- Store secrets in CI/CD variables, never in repo

## Ansible
- Idempotent playbooks — safe to run repeatedly
- Use roles for reusable logic
- Variables in group_vars/host_vars, not hardcoded
- Tag tasks for selective runs

## Infrastructure
- Infrastructure as code — no manual changes
- Environments should be reproducible from config alone
- Use health checks and readiness probes
- Log to stdout, aggregate externally

## Security
- Least privilege for service accounts
- Rotate secrets on a schedule
- Scan images for vulnerabilities in CI
