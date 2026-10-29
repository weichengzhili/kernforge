# KernForge 目录布局策略

- 文档编号：ARCH-0002
- 参考：LLVM（模块级镜像 + 模块根 CMakeLists）与 Chromium（components 内部按职责分治）

## 1. 顶层结构
kernforge/
├── contracts/ 跨语言契约（proto / schema / abi）
├── cpp/ C++ 实现
├── rust/ Rust 实现
├── deploy/ 部署资产（systemd / cgroup / sysctl / logrotate）
├── config/ 出厂默认配置
├── tests/acceptance/ 语言无关验收
├── tools/ 独立工具
├── docs/ architecture / operations / adr
└── scripts/ 构建与发布脚本

C++ 与 Rust 共享 `contracts/`、`deploy/`、`config/`、`docs/`、`tests/acceptance/`，各自独立构建体系，避免工具链互相污染。

## 2. C++ 模块布局（LLVM 式模块级镜像）

- 公开头：`include/kf/<module>.h`，一模块一聚合头
- 私有头：`src/<module>/<module>_internal.h`
- 实现：`src/<module>/**/*.cpp`
- 每个模块有自己的 `CMakeLists.txt`（LLVM 约定）
- 依赖通过 `target_link_libraries` 的 PUBLIC/PRIVATE 表达（替代 Chromium `DEPS`）

聚合头阈值：单头超过 **400 行**才允许拆为 `include/kf/<module>/` 子目录。

## 3. 模块内职责子目录（Chromium 式）

仅当模块 `.cpp` 数 > 8 或职责族 > 2 时开子目录：
src/process/
├── process_internal.h
├── lifecycle/{lifecycle_state,lifecycle_controller,exit_decision}.cpp
├── creation/{process_spec,process_handle}.cpp
└── registry/process_registry.cpp


子目录名使用 `snake_case` 职责词（`lifecycle`/`creation`/`registry`/`cgroup`/`scheduler`/`oom`/`restart`/`health`），禁止 `common`/`util`/`misc`。

## 4. 测试命名（对齐 Chromium `_unittest.cc`）

- 单元测试：`cpp/tests/<module>/<feature>_test.cpp`
- 集成测试：`cpp/tests/integration/<scenario>_test.cpp`
- 实时测试：`cpp/tests/realtime/<scenario>_test.cpp`
- 测试专用头：`<feature>_for_testing.h`，仅测试 target 可见

## 5. Rust 布局

Rust 不复制 C++ 的 `include/`+`src/` 分层；`src/lib.rs` 即模块入口，`pub`/`pub(crate)` 表达可见性。一个 `.rs` 承载一个内聚职责族，不引入 `detail/` 子目录。

## 6. 可见性边界强制

| 边界 | 强制手段 |
|---|---|
| 公开头 ↔ 私有头 | CMake `target_include_directories(PUBLIC vs PRIVATE)` |
| 模块间依赖 | `target_link_libraries` 的 PUBLIC/PRIVATE |
| 测试专用代码 | 独立 test target，不链接到生产 target |
| Rust 跨 crate 可见性 | Cargo 依赖声明 + `pub`/`pub(crate)` |

违反边界的 `#include` 在编译期失败，不依赖 review。

## 7. 命名一致性

C++ 与 Rust 共享以下类型名，语义一致：

`ProcessSpec`、`ProcessHandle`、`LifecycleState`、`LifecycleController`、
`ExitDecision`、`ProcessRegistry`、`CgroupV2Controller`、`OomGuard`、
`ProcessSupervisor`、`RestartPolicy`、`AuditSink`、`MetricsExporter`

差异仅在封装：C++ 类、Rust `trait` + `struct`。
