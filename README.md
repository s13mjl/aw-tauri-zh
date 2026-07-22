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
