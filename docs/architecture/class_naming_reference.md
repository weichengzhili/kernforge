# KernForge 类名参考手册

- 文档编号：ARCH-0001
- 适用范围：C++ 与 Rust 两套实现
- 状态：基线

## 1. 标识符作用域

| 层面 | 规则 | 示例 |
|---|---|---|
| 产品名 | KernForge | — |
| 短标识 | kf | — |
| C++ 命名空间 | kf::<module> | kf::process |
| Rust crate | <module> | process |
| Rust lib 名 | <module> | process |
| CMake target | <module> | process |
| 二进制 | <role> 或 kfctl | supervisord |
| 文件系统 | /etc/kernforge、/var/lib/kernforge | — |
| 环境变量 | <NAME> | LOG_LEVEL |
| 配置键 | snake_case | rt_runtime_percent |

类型名不带 kf 前缀，由命名空间或 crate 隔离。

## 2. 词法规则

- 类型、枚举、trait：PascalCase
- 函数、方法、变量、字段：snake_case
- 常量：C++ `kPascalCase`，Rust `SCREAMING_SNAKE_CASE`
- 枚举值：PascalCase（两语言一致）
- 文件名：snake_case（Chromium 约定）
- 缩写不超过 3 个字母，统一写 Cgroup、Pid、Rt、Oom

## 3. 组件后缀语义

| 后缀 | 语义 | 禁止用途 |
|---|---|---|
| Controller | 管理资源生命周期与状态迁移 | 一次性配置写入 |
| Supervisor | 监督其他组件启停重启 | 业务逻辑 |
| Gateway | 封装系统调用或外部边界 | 业务编排 |
| Applier | 将配置单次施加到内核 | 持续状态管理 |
| Guard | 保护性约束 | 通用工具 |
| Handle | RAII 资源句柄 | 配置描述 |
| Spec | 不可变创建描述 | 运行时状态 |
| Config | 静态配置 | 运行时决策 |
| Policy | 决策规则 | 执行动作 |
| Strategy | 可替换算法 | 状态持有 |
| Engine | 规则执行引擎 | 单一规则 |
| Registry | 索引与查询 | 生命周期管理 |
| Probe | 健康/状态探测 | 业务采集 |
| Snapshot | 某时刻状态快照 | 持续视图 |
| Event | 事件数据 | 事件处理 |
| Sink | 事件出口 | 事件源 |
| Exporter | 指标导出 | 指标计算 |
| Reporter | 状态上报 | 状态存储 |
| Encoder | 序列化 | 传输 |
| Validator | 校验 | 修复 |
| Reader | 持续读取流 | 一次性加载 |
| Loader | 一次性加载 | 持续读取 |
| Subscriber | 订阅事件 | 发布事件 |
| Channel | 通信通道 | 业务协议 |
| Region | 内存区域 | 分配器 |
| Notifier | 通知原语 | 事件总线 |
| Queue | 队列 | 调度器 |
| Decision | 决策结果 | 决策规则 |
| Status | 状态值 | 状态机 |
| State | 状态枚举或状态机 | 配置 |
| Partition | 分区定义 | 分区管理 |
| Mutex | 同步原语 | 锁策略 |
| Source | 时间/数据来源 | 派生计算 |

## 4. 头文件后缀约定（对齐 Chromium ForTesting）

| 类型 | 位置 | 后缀 | 可见性 |
|---|---|---|---|
| 公开聚合头 | `include/kf/<module>.h` | `.h` | CMake PUBLIC |
| 模块私有聚合 | `src/<module>/<module>_internal.h` | `_internal.h` | CMake PRIVATE |
| 模块子功能私有 | `src/<module>/<sub>/<feature>_internal.h` | `_internal.h` | CMake PRIVATE |
| 测试专用 | `src/<module>/<feature>_for_testing.h` | `_for_testing.h` | 仅测试 target |

禁止 `<class>.h` 与 `<class>.cpp` 在 `src/` 下成对镜像（Chromium 反模式）。

## 5. 禁止命名

- Manager、Mgr
- Util、Utils、Helper
- Misc、Common（作为类型名）
- Impl、Base、Abstract（作为唯一类型名）
- Data、Info、Object、Item
- Handler、Processor（除非明确处理对象）
- I 前缀接口
- 中英混拼

## 6. 评审清单

- 类型名是否表达职责而非实现？
- 后缀是否在本手册语义表中？
- 是否出现禁止词？
- C++ 与 Rust 同名类型语义是否一致？
- 私有头是否只被本模块 `.cpp` 包含？
