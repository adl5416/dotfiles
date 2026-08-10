---
name: coding
description: Coding standards and style conventions. Use when writing, reviewing, or refactoring code.
---

## Python
- Follow PEP 8 except line length — long lines are fine, do not wrap for length
- Put type annotations on all function declarations
- Prefer dataclasses or Pydantic for structured data
- Use pytest for testing, not unittest
- Use docstrings on all functions (Google style)
- Prefer f-strings over .format() or %
- Use pathlib over os.path
- Prefer list/dict comprehensions when readable
- Prefer uv over pip

## C/C++
- Use Modern C++17/20
- Use RAII and smart pointers, avoid raw new/delete
- Use standard library algorithms over hand-rolled loops
- Use CMake for builds
- Use snake_case for functions/variables, PascalCase for types
- Use header guards or #pragma once

## General
- Prefer simple, readable code over clever code
- Functions should do one thing
- Name things clearly — avoid abbreviations and acronyms unless universally understood (like USB)
- Never ever use one letter variable names (instead of `for p in pipelines`, use `for pipeline in pipelines`)
- Use clear full words for variable names
- Add unit tests for all new functionality
- No dead code or commented-out code in commits
- Don't add comments that restate what the code does
