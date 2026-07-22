# aw-tauri-zh

ActivityWatch 的中文二创版本，基于 [aw-tauri](https://github.com/ActivityWatch/aw-tauri) 修改。

> **关于本仓库**
>
> 这是 [ActivityWatch](https://activitywatch.net/) 的二次创作版本，由 [s13mjl](https://github.com/s13mjl) 维护。
>
> 本仓库中的所有信息（文档、论坛、捐赠链接等）除非另有说明，均指向原项目。原开发者团队保留所有权利。
>
> - **原仓库**：[github.com/ActivityWatch/aw-tauri](https://github.com/ActivityWatch/aw-tauri)
> - **二创仓库**：[github.com/s13mjl/aw-tauri-zh](https://github.com/s13mjl/aw-tauri-zh)
> - **原项目官网**：[activitywatch.net](https://activitywatch.net/)

## 二创改动内容

相较于原版 aw-tauri，本版本做了以下改进：

### 完整中文汉化
- 应用界面全部翻译为简体中文
- 保留了技术术语的英文原文

### Bug 修复（按严重程度分级）

**S 级（严重）**
- 修复分类编辑中的验证和保存问题

**A 级（高优先级）**
- 修复多个影响核心功能的 bug

**B 级（中等优先级）**
- `#1104` 移除暗色模式下 SVG 文字的 text-shadow
- `#851` 时间线条形图 Y 轴上限改为硬上限，防止溢出
- `#847`/`#1099` 添加长超时支持，解决导出和月度查询超时
- `#646` 修复客户端与服务端分类匹配行为不一致导致颜色不匹配
- `#852` 修复后台音频标签页不被计入活跃时间
- `#1117` 修复 always_active_pattern 设置不生效
- `#1007` 修复暗色模式下类别颜色对比度问题

**C 级（低优先级）**
- 修复多个 UI/UX 细节问题

**D 级（改进）**
- `#991` 优化查询缓存，避免相同查询选项触发重复查询
- `#775` 分类设置界面补充同深度匹配规则的说明
- `#406` 新增自动定期导出 JSON 备份功能
- `#394` 修复导入成功后显示 null 的问题
- `#352` 分类模式提示中补充 URL 分类说明

### 功能增强
- **分类优先级**：分类设置中新增优先级字段，同深度匹配时高优先级胜出
- **多模式输入**：分类规则中用"+"按钮添加多个字符串字段，不再用 `|` 表示"或"
- **自动备份**：可设置定期自动导出所有数据为 JSON 文件
- **查询优化**：深度比较查询选项，避免不必要的重复查询
- **暗色模式**：改善多种可视化组件在暗色模式下的文字对比度

## 构建

### 前置条件

- [Tauri v2 前置依赖](https://v2.tauri.app/start/prerequisites/)
- [Node.js](https://nodejs.org/)
- [Rust](https://rustup.rs/)（stable 工具链）

### 步骤

```sh
# 克隆（含子模块）
git clone --recursive https://github.com/s13mjl/aw-tauri-zh.git
cd aw-tauri-zh

# 安装依赖
npm install
cd aw-webui && npm install && cd ..

# 开发模式
make dev

# 构建 release 二进制（不打包安装包）
npx tauri build --no-bundle

# 构建并打包安装包
make build
```

## 配置

aw-tauri 从 TOML 文件读取配置：

| 平台 | 路径 |
|------|------|
| Linux    | `~/.config/activitywatch/aw-tauri/config.toml` |
| macOS    | `~/Library/Application Support/activitywatch/aw-tauri/config.toml` |
| Windows  | `%APPDATA%\activitywatch\aw-tauri\config.toml` |

首次运行时自动生成默认配置。示例：

```toml
port = 5600
discovery_paths = [
  "C:\\Users\\你的用户名\\aw-modules",
]

[autostart]
enabled = true
minimized = true
modules = [
  "aw-watcher-afk",
  "aw-watcher-window",
]
```

## 搭配原项目的其他子模块使用

aw-tauri 本身已内置 **aw-server-rust**（作为 Cargo 依赖编译进二进制，进程内启动 Rocket HTTP :5600）与 **aw-webui**（作为 git submodule 内嵌为静态资源），并接管了原 `aw-qt` 的进程管理职责。因此**你不需要再单独运行 aw-server 或 aw-qt**。

但各类 **watcher / 通知 / 同步** 模块仍需从[原项目](https://github.com/ActivityWatch)获取后放入模块发现目录，由 aw-tauri 自动拉起。下表列出常用的外部模块：

| 模块 | 作用 | 平台 | 来源 |
|------|------|------|------|
| **aw-watcher-afk** | 监测用户是否离开（AFK） | 全平台 | [ActivityWatch/aw-watcher-afk](https://github.com/ActivityWatch/aw-watcher-afk) |
| **aw-watcher-window** | 监测当前活动窗口/应用 | 全平台 | [ActivityWatch/aw-watcher-window](https://github.com/ActivityWatch/aw-watcher-window) |
| **aw-watcher-input** | 监测键盘鼠标输入统计（可选） | 全平台 | [ActivityWatch/aw-watcher-input](https://github.com/ActivityWatch/aw-watcher-input) |
| **aw-notify** | 通知桥，被 aw-tauri 以 `--output-only` 拉起 | 全平台 | [ActivityWatch/aw-notify](https://github.com/ActivityWatch/aw-notify) |
| **aw-sync** | 多设备数据同步（以 `daemon` 参数后台运行） | 全平台 | [ActivityWatch/aw-server-rust](https://github.com/ActivityWatch/aw-server-rust) 下的 `aw-sync` 二进制 |
| **aw-awatcher** | Wayland 下的合并 watcher（替代 afk+window） | Linux/Wayland | [ActivityWatch/awatcher](https://github.com/ActivityWatch/awatcher) |

> 获取方式：可从 [ActivityWatch 官方发布版](https://github.com/ActivityWatch/activitywatch/releases) 下载完整安装包后从中提取对应模块目录，或自行从各子仓库源码编译（Python 模块建议用 PyInstaller COLLECT 模式打包为完整目录）。

### 模块发现机制

aw-tauri 启动时会通过以下方式发现外部模块（见 [manager.rs](src-tauri/src/manager.rs) 与 [dirs.rs](src-tauri/src/dirs.rs)）：

1. **`discovery_paths`**（优先级最高）：`config.toml` 中配置的路径，会插入到系统 PATH 之前优先扫描；
2. **系统 PATH**：逐项扫描 PATH 中的所有目录；
3. **递归搜索 `aw-*` 子目录**：遇到以 `aw-` 开头的目录会自动进入继续查找，因此把模块放在 `aw-modules\aw-watcher-afk\` 这种子目录里也能被发现。

默认 `discovery_paths`（无需手动配置即可生效）：

| 平台 | 默认路径 |
|------|------|
| Windows  | `C:\Users\{用户名}\aw-modules`、`C:\Users\{用户名}\AppData\Local\Programs\ActivityWatch` |
| Linux    | `~/bin`、`~/.local/bin`、`~/.local/share/activitywatch/aw-tauri/modules`、`~/aw-modules` |
| macOS    | `~/aw-modules`，.app bundle 内还会扫描 `Contents/Resources/modules` |

### 推荐目录结构（Windows）

把各模块按"完整目录形态"放到 `C:\Users\{用户名}\aw-modules\` 下：

```
C:\Users\{用户名}\aw-modules\
├── aw-watcher-afk\              ← PyInstaller 目录形态（exe + 依赖）
│   ├── aw-watcher-afk.exe
│   └── _internal\
├── aw-watcher-window\
│   ├── aw-watcher-window.exe
│   └── _internal\
├── aw-notify\                   ← 需支持 --output-only 选项
│   ├── aw-notify.exe
│   └── _internal\
└── aw-sync.exe                  ← Rust 二进制，单文件即可
```

> **重要**：Python 模块（`aw-watcher-afk`、`aw-watcher-window`、`aw-notify` 等）必须以**完整目录形态**存在（exe + `_internal\` 依赖目录），**不能用 PyInstaller `--onefile` 打包出的单文件 exe**，否则会因缺少 DLL 导致启动失败。`aw-sync` 是 Rust 编译产物，无外部 DLL 依赖，单文件即可。

### 自动启动配置

默认 `autostart.modules` 列表（见 [lib.rs](src-tauri/src/lib.rs)）：

- **Windows / macOS**：`aw-watcher-afk`、`aw-watcher-window`、`aw-sync`（args=`"daemon"`）
- **Linux X11**：`aw-watcher-afk`、`aw-watcher-window`、`aw-sync`（args=`"daemon"`）
- **Linux Wayland**：`aw-awatcher`、`aw-sync`（args=`"daemon"`）

模块默认连接到内嵌 aw-server 的 `:5600` 端口；若 `config.toml` 中 `port` 改为非 5600，aw-tauri 会自动给子进程追加 `--port <port>` 参数。

`aw-notify` 不在默认 autostart 列表中，但一旦放入发现目录并在托盘菜单的"模块"子菜单里勾选启用，aw-tauri 会以特殊路径启动它（强制加 `--output-only`，逐行读取 stdout JSON 通知并转发为系统通知）。

## 架构

```
┌─────────────────────────────────────────────┐
│                  aw-tauri                    │
│  ┌───────────┐  ┌─────────────────────────┐ │
│  │ Tray Icon │  │   WebView (aw-webui)    │ │
│  │  + Menu   │  │                         │ │
│  └─────┬─────┘  └─────────────────────────┘ │
│  ┌─────┴──────────────────────────────────┐ │
│  │          Module Manager                │ │
│  └─────┬──────────────────────────────────┘ │
│  ┌─────┴──────────────────────────────────┐ │
│  │       aw-server-rust (embedded)        │ │
│  │         Rocket HTTP on :5600           │ │
│  └────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
        │ spawns child processes
        ▼
┌──────────────┐  ┌──────────────────┐
│ aw-watcher-  │  │ aw-watcher-      │
│ afk          │  │ window           │
└──────────────┘  └──────────────────┘
```

## 致谢

- **原开发者**：[Erik Bjare](https://github.com/ErikBjare) 及所有 [ActivityWatch 贡献者](https://github.com/ActivityWatch/activitywatch/graphs/contributors)
- **原项目**：[ActivityWatch](https://activitywatch.net/) — 一个优秀的开源时间追踪工具

本二创版本的所有改动基于原开发者的工作。如果你喜欢 ActivityWatch，请支持原开发者：
- [捐赠页面](https://activitywatch.net/donate/)
- [Patreon](https://www.patreon.com/erikbjare)
- [Open Collective](https://opencollective.com/activitywatch)

## 问题反馈

- **二创版本的问题**（汉化、二创引入的 bug）：[本仓库 Issues](https://github.com/s13mjl/aw-tauri-zh/issues)
- **ActivityWatch 本身的问题**：[原仓库 Issues](https://github.com/ActivityWatch/activitywatch/issues)

## 许可证

[MPL-2.0](LICENSE.txt) — 继承自原项目。
