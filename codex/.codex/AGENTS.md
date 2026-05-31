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

# Engineering and Coding Standards

## Core Principle

Working code is necessary but not sufficient. Code must also be easy to understand, easy to modify, easy to test, and hard to misuse.

Prefer strategic programming over tactical programming. Do not solve the immediate problem by adding fragile patches, duplicated logic, or special cases that make the system harder to maintain later.

Optimize for long-term clarity and maintainability, not just short-term implementation speed.

## Complexity Management

- Treat complexity as the main enemy of software design.
- Keep code obvious. A reader should be able to understand the purpose, behavior, and important constraints of the code without excessive context.
- Avoid changes that make future changes harder, even if they work today.
- Complexity accumulates incrementally. Small unclear names, small duplicated branches, small leaked assumptions, and small special cases matter.
- When complexity is unavoidable, hide it behind a clear and stable abstraction.
- Prefer simple interfaces even if the implementation behind them is somewhat more complex.
- Do not expose internal details, storage formats, ordering assumptions, framework quirks, or low-level implementation choices unless callers genuinely need them.

## Module and API Design

- Prefer deep modules: a module should provide a simple interface while encapsulating meaningful behavior.
- Avoid shallow modules: do not create classes, functions, or wrappers whose interface is almost as complex as their implementation.
- Design APIs around the common case. The common path should be simple, explicit, and hard to misuse.
- Keep rare options optional and out of the way.
- Separate general-purpose code from special-purpose code.
- Push complexity downward into the module that has the information needed to handle it correctly.
- Avoid pass-through methods, pass-through classes, and pass-through variables that merely forward calls without adding a distinct abstraction.
- Different layers should provide different abstractions. Do not create layers that simply rename or mirror the layer below.
- Avoid temporal decomposition: do not structure modules only around the chronological order of execution. Structure them around stable concepts and hidden design decisions.
- Combine code when it shares important information or when combining it simplifies the interface.
- Split code when it separates independent concepts, isolates special-purpose behavior, or improves information hiding.
- Prefer somewhat general abstractions, but do not overgeneralize for hypothetical future requirements.

## Designing Changes

- Before making a non-trivial change, understand the existing abstraction and where the new behavior belongs.
- For important design decisions, consider at least two possible designs before implementing.
- Choose the design that reduces complexity for callers and localizes future changes.
- When adding a feature, look for the underlying abstraction that should own the behavior instead of only adding branches to existing code.
- Make focused changes. Avoid unrelated rewrites unless they are necessary to support the requested change.
- When modifying existing code, leave the touched area cleaner when it is safe and relevant.
- Preserve existing conventions unless there is a strong reason to change them.
- Do not introduce new patterns, dependencies, layers, or abstractions without a concrete benefit.

## Error Handling

- Prefer designing errors out of existence over adding more error handling.
- Make invalid states unrepresentable when practical.
- Use clear validation at boundaries.
- Do not force every caller to handle low-level exceptions that can be handled or normalized inside the module.
- Aggregate, translate, or mask low-level errors when that produces a simpler and more useful interface.
- Fail early for violated invariants.
- Error messages should be actionable and include relevant context without exposing unnecessary internals.

## Naming

- Use precise, consistent, and intention-revealing names.
- A good name should create a clear mental image of what the thing represents.
- Avoid vague names such as `data`, `info`, `manager`, `helper`, `processor`, `stuff`, or `temp` unless the scope is extremely small and the meaning is obvious.
- Avoid names that are too broad for what the code actually does.
- Avoid extra words that do not add meaning.
- Use the same word for the same concept everywhere.
- Use different words for different concepts.
- If a good name is hard to find, treat it as a design smell. The concept may not be clean enough yet.

## Comments and Documentation

- Comments should explain things that are not obvious from the code.
- Do not write comments that merely repeat what the code says.
- Use comments to document purpose, contracts, invariants, assumptions, trade-offs, edge cases, and non-obvious design decisions.
- Interface comments should describe how to use the abstraction, what it guarantees, and what callers should not rely on.
- Interface comments should not expose implementation details unless those details are part of the contract.
- Implementation comments should explain why the code exists or why it is written in a particular way, not narrate every line.
- Keep comments close to the code they describe.
- Update comments when changing behavior.
- For non-trivial public APIs, write or sketch the interface documentation before implementation. Use the documentation as a design tool.
- Prefer higher-level comments that clarify intent over low-level comments that duplicate mechanics.

## Readability

- Code should be designed for ease of reading, not ease of writing.
- Prefer straightforward control flow.
- Avoid clever code unless it is clearly justified.
- Avoid hidden side effects.
- Avoid excessive nesting.
- Keep related logic together.
- Keep unrelated logic separate.
- Make dependencies explicit.
- Make important behavior easy to find.
- If code requires a long explanation to understand, consider redesigning it.

## Tests

- Tests should verify behavior, not implementation details.
- Add or update tests for meaningful behavior changes, bug fixes, edge cases, and error paths.
- Keep tests deterministic, focused, and readable.
- Test names should describe the behavior being tested.
- Difficult test setup is often a sign of a poor interface or excessive coupling.
- Passing tests do not justify bad design. Tests are a safety net, not a substitute for clear abstractions.
- Prefer tests that make future refactoring safer.

## Performance

- Do not optimize prematurely.
- Measure before and after performance-sensitive changes.
- Optimize around the actual critical path.
- Avoid scattering micro-optimizations across the codebase.
- Preserve clarity unless the performance benefit is real and important.
- If an optimization makes code less obvious, document the reason, the measured evidence, and the relevant constraints.

## Red Flags

Actively look for these design smells and fix them when they are relevant to the current task:

- A module has a complicated interface but little internal functionality.
- A design decision is duplicated across multiple modules.
- A caller must know too much about a callee’s internal behavior.
- A method only forwards arguments to another method without adding a useful abstraction.
- Code is organized around execution order rather than stable concepts.
- General-purpose logic and special-purpose logic are mixed together.
- The same non-trivial logic appears in multiple places.
- A name is vague, misleading, or hard to choose.
- A comment repeats the code instead of explaining intent.
- A small change requires edits in many unrelated places.
- A function or class is hard to describe concisely.
- The code works, but its behavior is not obvious.

## Preferred Implementation Style

- Prefer small, cohesive functions and classes with clear responsibilities.
- Prefer explicit data models and well-defined boundaries.
- Prefer boring, reliable code over clever code.
- Prefer local reasoning: a reader should not need to inspect many distant files to understand a change.
- Prefer standard library and existing project utilities before adding new dependencies.
- Reuse existing helpers, patterns, and conventions before inventing new ones.
- Keep public interfaces stable unless changing them clearly improves the design.
- When introducing a new abstraction, make sure it hides real complexity rather than merely adding another layer.
