---
name: testing-patterns
description: Testing patterns and expectations. Use when writing, reviewing, or discussing tests.
---

## General Principles
- Test behavior, not implementation details
- One logical assertion per test (multiple asserts OK if testing one concept)
- Tests should be fast, isolated, and deterministic
- Name tests to describe expected behavior: `test_returns_empty_list_when_no_results`
- Arrange-Act-Assert structure

## Coverage
- All new features and bug fixes require tests
- Bug fix tests must fail before the fix and pass after
- Aim for meaningful coverage, not percentage targets

## Unit Tests
- Mock external dependencies (network, filesystem, databases)
- Don't mock the thing you're testing
- Prefer fakes/stubs over complex mock setups when possible

## Integration Tests
- Test real interactions between components
- Use test databases/containers, not production
- Clean up state between tests

## Python (pytest)
- Use fixtures for setup/teardown
- Parametrize for multiple input cases
- Use `tmp_path` for filesystem tests
- Prefer `pytest.raises` for exception testing

## C/C++ (Google Test / Catch2)
- Test edge cases: null, empty, boundary values
- Use ASSERT for fatal checks, EXPECT for non-fatal

## Anti-patterns to Avoid
- Tests that depend on execution order
- Sleeping/waiting for time-based conditions (use polling or events)
- Testing private methods directly
- Overly broad integration tests that test everything at once
