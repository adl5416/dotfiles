---
name: coding-standards
description: Coding standards and style conventions. Use when writing, reviewing, or refactoring code.
---

## Python
- Follow PEP 8 except line length — long lines are fine, do not wrap for length
- Type annotations on all function signatures
- Prefer dataclasses or Pydantic for structured data
- Use pytest for testing, not unittest
- Docstrings on public functions (Google style)
- Prefer f-strings over .format() or %
- Use pathlib over os.path
- Prefer list/dict comprehensions when readable

## C/C++
- Modern C++17/20
- RAII and smart pointers, avoid raw new/delete
- Use standard library algorithms over hand-rolled loops
- CMake for builds
- snake_case for functions/variables, PascalCase for types
- Header guards or #pragma once

## General
- Prefer simple, readable code over clever code
- Functions should do one thing
- Name things clearly — avoid abbreviations and acronyms unless universally understood
- Tests for all new functionality
- No dead code or commented-out code in commits
