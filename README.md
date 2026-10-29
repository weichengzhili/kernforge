# KernForge

Industrial Process Lifecycle Supervisor.

- Code prefix : `kf`
- Filesystem  : `/kernforge`
- Version     : 0.1.0

Layout modeled after LLVM (`include/` ↔ `src/` module mirroring,
per-module `CMakeLists.txt`) and Chromium (`components/` internal
responsibility subdirectories, snake_case directory names,
`_for_testing.h` suffix, build-system-enforced dependency boundaries).

Documents:

- `docs/architecture/class_naming_reference.md`
- `docs/architecture/layout_policy.md`
- `docs/adr/0005-llvm-chromium-layout.md`
