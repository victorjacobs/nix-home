---
name: implementation-handoff
description: Investigate a coding task and produce a concise implementation handoff for another coding agent. Use when the user wants research/context for a later implementation agent rather than implementation now.
---

Investigate the requested task and produce an implementation handoff.

The handoff should transfer understanding to another coding agent without prescribing a detailed implementation plan.

Include:

## Objective
What needs to be achieved and what success looks like.

## Current system
Relevant architecture, components, data flow, and existing behavior discovered in the repository.

## Relevant code
Important files, modules, functions, types, APIs, tests, configuration, and dependencies.

## Constraints
Compatibility requirements, conventions, invariants, interfaces that should not change, and security/performance considerations.

## Decisions already made
Requirements or architectural choices that are fixed.

## Findings
Non-obvious behavior, coupling, edge cases, technical debt, traps, and failed assumptions discovered during investigation.

## Open questions
Anything that could not be confidently determined and should be resolved during implementation.

## Validation
Tests, commands, acceptance criteria, and observable behavior that can verify the implementation.

Clearly distinguish:
- Observed: verified facts about the repository.
- Required: constraints or requirements that must be followed.
- Suggested: potentially useful approaches that are not requirements.
- Unknown: unresolved questions.

Do not:
- produce a numbered implementation procedure;
- prescribe exact code changes unless required by a constraint;
- pretend the implementation approach is fully knowable before coding;
- implement the feature;
- invent repository details.

The implementation agent should inspect the repository itself, choose the implementation approach, and adapt it as new information emerges.

Prefer concrete repository findings over generic advice.
