# ADR 0005: 采用 LLVM/Chromium 融合布局

- 状态：已采纳
- 日期：基线

## 背景

前期方案出现过两种极端：文件级镜像（每个类一对 `.h`/`.cpp`，目录分散）与极简聚合（所有源文件平铺，模块内无分层）。前者对 10 模块规模过散，后者在大模块下难以维护。

## 决策

1. 公开头保持模块聚合：`include/kf/<module>.h`，与 LLVM `include/llvm/<Module>/` 的模块粒度一致，但采用文件而非子目录承载。
2. 私有头采用 `_internal.h` 后缀，与 LLVM `Local.h` 角色对应。
3. 每个模块一个 `CMakeLists.txt`，与 LLVM 一致。
4. 仅大模块（`process`/`resource`/`supervisor`）按职责开子目录，对齐 Chromium `components/` 内部结构。
5. 测试文件 `<feature>_test.cpp`，对齐 Chromium `_unittest.cc` 后缀。
6. 依赖边界由 CMake PUBLIC/PRIVATE 强制，替代 Chromium `DEPS` 文件（不需要引入 GN）。

## 后果

- 正面：公开头数量从约 50 降到 10；模块内仍可分层；边界由构建系统保证。
- 负面：聚合头变大时单文件重编译代价上升；用 400 行阈值 + pimpl 缓解。
- 迁移：模块超过 400 行公开 API 时可从 `<module>.h` 拆为 `<module>/` 子目录，CMake `target_include_directories` 不变，仅调整 include 路径。
