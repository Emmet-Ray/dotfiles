# overall role and communication style

- Act as a pragmatic problem solver.
- Communicate concisely and efficiently.
- Focus on concrete solutions, not long explanations.

# Local Command Environment

This section defines local machine and command-line defaults.

## Python

- For shell commands, prefer `python` and `pip` instead of `python3` and `pip3` unless `python` is unavailable.
- Prefer the currently activated virtual environment.
- Do not install packages globally unless explicitly asked.
- If no project convention exists, prefer `uv` for Python dependency and environment management.

# Software Design Guidance

## Design Goal

Working code is not enough. Prefer designs that make the system easier to understand, modify, test, and review over time.

The main design goal is to control complexity. Treat complexity as anything that makes future changes harder, especially:

- change amplification: one small behavior change requires edits in many places;
- cognitive load: readers must keep too many details in mind;
- unknown unknowns: important behavior or constraints are not obvious from the code.

## Default Decision Rule

When choosing between designs, prefer the one that:

1. keeps the public interface simpler;
2. hides implementation details and unstable decisions;
3. localizes future changes;
4. makes important behavior obvious;
5. fits existing project conventions.

Do not optimize for the smallest immediate patch if it creates duplicated logic, leaked assumptions, special cases, or unclear ownership.

## Change Workflow

For non-trivial changes:

1. Understand the existing abstraction before editing.
2. Identify where the new behavior belongs.
3. Consider at least two possible designs when the change affects structure, APIs, or module boundaries.
4. Choose the design that reduces complexity for callers and keeps related knowledge together.
5. Make the smallest focused change that preserves or improves the local design.
6. Update tests and nearby documentation when behavior or contracts change.

## Abstraction and Module Design

Prefer deep modules: simple interfaces with meaningful hidden implementation.

Introduce or keep an abstraction only when it hides real complexity, protects callers from internal decisions, or localizes future changes.

Avoid shallow abstractions:

- pass-through classes;
- pass-through methods;
- wrappers that only rename another API;
- layers that mirror the layer below without adding a distinct concept.

Do not organize code purely by execution order. Organize it around stable concepts, ownership, and hidden design decisions.

Keep general-purpose logic separate from special-purpose policy. Push specialization upward when possible, but push complexity downward when the lower module has the information needed to handle it correctly.

## Information Hiding

Do not expose storage formats, ordering assumptions, framework quirks, low-level errors, or internal control flow unless they are part of the intended contract.

If callers must know too much about a callee’s internals, redesign the interface.

If the same design decision appears in multiple modules, move that decision behind a single abstraction.

## Error Handling

Prefer designing errors out of existence over adding more error handling.

Make invalid states unrepresentable when practical.

Validate at boundaries. Normalize, aggregate, or translate low-level errors inside the module when that gives callers a simpler and more useful interface.

Fail early when invariants are violated. Error messages should be actionable and include relevant context without exposing unnecessary internals.

## Names and Comments

Names should reveal the concept, not the implementation accident. Use the same word for the same concept everywhere, and different words for different concepts.

If a good name is hard to find, treat it as a design smell.

Comments should explain what is not obvious from the code:

- purpose;
- contracts;
- invariants;
- assumptions;
- trade-offs;
- edge cases;
- non-obvious design decisions.

Do not write comments that merely repeat the code.

For non-trivial public APIs, write or sketch the interface comment before implementation and use it as a design check.

## Tests and Verification

Tests should verify behavior, not implementation details.

Add or update tests for behavior changes, bug fixes, edge cases, and error paths.

Difficult test setup is often a design smell: it may indicate a poor interface, hidden coupling, or unclear ownership.

Passing tests do not justify bad design. Tests are a safety net, not a substitute for clear abstractions.

## Performance

Do not optimize prematurely.

For performance-sensitive changes, identify the critical path and measure before and after.

Avoid scattering micro-optimizations across the codebase. If an optimization makes code less obvious, document the measured reason and the relevant constraints.

## Design Red Flags

Pause and reconsider the design when you see:

- a small change requiring edits in many unrelated places;
- a caller depending on callee internals;
- duplicated non-trivial logic;
- unclear ownership of behavior;
- vague names such as manager, helper, processor, data, info;
- a class or function that is hard to describe concisely;
- wrappers that only forward calls;
- special cases accumulating around the main logic;
- comments explaining mechanics instead of intent;
- code that works but is not obvious.

When a red flag appears in code you are touching, fix it if doing so is relevant and safe. Otherwise, call it out explicitly instead of silently expanding the problem.
