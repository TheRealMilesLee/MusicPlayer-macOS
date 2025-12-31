# Patagonia Pulse - macOS 音乐播放器 / Music Player

<div align="center">

![macOS](https://img.shields.io/badge/macOS-14.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0%20%7C%206.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Version](https://img.shields.io/badge/Version-1.5-red.svg)

**一款专为 macOS 设计的现代化音乐播放器**  
**A Modern Music Player Designed for macOS**

[功能特性 Features](#功能特性--features) • [安装 Installation](#安装--installation) • [使用指南 Usage](#使用指南--usage) • [兼容性 Compatibility](#兼容性--compatibility)

</div>

---

## 📖 简介 / Introduction

### 中文

Patagonia Pulse 是一款原生的 macOS 音乐播放器应用，采用 SwiftUI 构建，提供了优雅的用户界面和强大的音乐管理功能。该应用支持本地音乐库管理，具有艺术家、专辑分类浏览，以及最近播放历史记录等功能。

应用采用现代化的 macOS 设计语言，包括半透明毛玻璃效果、原生窗口样式，以及流畅的动画过渡，为用户提供了极致的视听体验。

### English

Patagonia Pulse is a native macOS music player application built with SwiftUI, offering an elegant user interface and powerful music management capabilities. The application supports local music library management with features including artist and album categorization, recent playback history, and more.

The app adopts modern macOS design language with translucent vibrancy effects, native window styling, and smooth animations, providing users with an exceptional audio-visual experience.

---

## ✨ 功能特性 / Features

### 核心功能 / Core Features

#### 🎵 音乐播放 / Music Playback
- **多格式支持** / **Multi-format Support**: 支持 MP3、MP4、WAV、FLAC 等常见音频格式
- **播放控制** / **Playback Controls**: 播放/暂停、前进/后退、停止
- **进度控制** / **Progress Control**: 可拖拽的进度条，实时显示播放时间
- **循环播放** / **Repeat Mode**: 单曲循环功能
- **随机播放** / **Shuffle Mode**: 随机播放模式

#### 📚 音乐库管理 / Library Management
- **文件夹导入** / **Folder Import**: 选择本地音乐文件夹快速导入
- **元数据读取** / **Metadata Reading**: 自动提取歌曲标题、艺术家、专辑、封面等信息
- **多视图浏览** / **Multiple Views**:
  - 本地播放列表视图（Local Playlist View）
  - 艺术家分类视图（Artist View）
  - 专辑分类视图（Album View）
  - 最近播放视图（Recent View）

#### 🔍 搜索功能 / Search Function
- **实时搜索** / **Real-time Search**: 支持按歌名、艺术家、专辑搜索
- **输入验证** / **Input Validation**: 智能搜索输入验证

#### 🎨 用户界面 / User Interface
- **毛玻璃效果** / **Vibrancy Effect**: 现代化的半透明背景
- **原生 macOS 风格** / **Native macOS Style**: 无边框透明标题栏
- **专辑封面显示** / **Album Artwork Display**: 播放时显示专辑封面
- **深色模式支持** / **Dark Mode Support**: 完美适配系统深色模式
- **响应式设计** / **Responsive Design**: 自适应窗口大小

#### ⌨️ 快捷键支持 / Keyboard Shortcuts
- **⌘ + O**: 打开音乐文件夹 / Open Music Folder

---

## 🛠 技术栈 / Technology Stack

### 开发语言与框架 / Language & Frameworks
- **Swift**: 5.0 - 6.0
- **SwiftUI**: 用于构建用户界面
- **AVFoundation**: 音频播放核心
- **AVKit**: 媒体资源管理
- **AppKit**: macOS 原生 UI 组件

### 架构设计 / Architecture
- **MVVM 架构**: Model-View-ViewModel 设计模式
- **响应式编程**: 使用 `@StateObject`, `@EnvironmentObject`, `@Binding`
- **异步编程**: async/await 用于元数据加载

### 关键组件 / Key Components
```
MusicPlayer/
├── PatagoniaPulse/
│   ├── PatagoniaPulseApp.swift        # 应用入口 / App Entry
│   ├── ModelAndFunctions/              # 模型与业务逻辑 / Models & Business Logic
│   │   ├── MusicViewModel.swift        # 音乐视图模型 / Music View Model
│   │   ├── MusicTrack.swift           # 音轨模型 / Track Model
│   │   ├── MusicLibrary.swift         # 音乐库 / Library
│   │   ├── AudioPlayManager.swift     # 播放管理器 / Play Manager
│   │   └── FileLoadingManager.swift   # 文件加载器 / File Loader
│   └── View/                          # 视图层 / Views
│       ├── ContentView.swift          # 主界面 / Main View
│       ├── LocalPlaylistsView.swift   # 本地播放列表 / Local Playlist
│       ├── ArtistView.swift          # 艺术家视图 / Artist View
│       ├── AlbumView.swift           # 专辑视图 / Album View
│       └── RecentView.swift          # 最近播放 / Recent View
```

---

## 📋 系统要求 / System Requirements

### 最低要求 / Minimum Requirements
- **操作系统 / OS**: macOS 14.0 (Sonoma) 或更高版本 / or later
- **内存 / RAM**: 4 GB
- **存储空间 / Storage**: 100 MB 可用空间 / available space
- **处理器 / Processor**: Apple Silicon (M1/M2/M3) 或 Intel 处理器 / or Intel Processor

### 推荐配置 / Recommended Requirements
- **操作系统 / OS**: macOS 15.0 (Sequoia) 或更高版本 / or later
- **内存 / RAM**: 8 GB 或更高 / or higher
- **处理器 / Processor**: Apple Silicon (M1 及以上) / (M1 or later)

---

## 兼容性 / Compatibility

### macOS 版本兼容性列表 / macOS Version Compatibility List

| macOS 版本 / Version | 版本号 / Build | 兼容性 / Compatibility | 测试状态 / Test Status | 备注 / Notes |
|---------------------|---------------|----------------------|----------------------|-------------|
| macOS Sequoia | 15.0 - 15.6+ | ✅ 完全兼容 / Fully Compatible | ✅ 已测试 / Tested | 开发目标版本 / Development Target |
| macOS Sonoma | 14.0 - 14.7 | ✅ 完全兼容 / Fully Compatible | ✅ 已测试 / Tested | 最低支持版本 / Minimum Version |
| macOS Ventura | 13.x | ⚠️ 理论兼容 / Theoretically Compatible | ⚠️ 未测试 / Untested | 需修改部署目标 / Deployment Target Adjustment Required |
| macOS Monterey | 12.x | ⚠️ 理论兼容 / Theoretically Compatible | ⚠️ 未测试 / Untested | 需修改部署目标 / Deployment Target Adjustment Required |
| macOS Big Sur | 11.x | ❌ 不兼容 / Not Compatible | ❌ 不支持 / Not Supported | SwiftUI 版本限制 / SwiftUI Version Limit |
| 更早版本 / Earlier | ≤ 10.x | ❌ 不兼容 / Not Compatible | ❌ 不支持 / Not Supported | 不支持 / Not Supported |

### 处理器架构支持 / Processor Architecture Support

| 架构 / Architecture | 兼容性 / Compatibility | 性能 / Performance |
|-------------------|----------------------|-------------------|
| Apple Silicon (M1/M2/M3/M4) | ✅ 原生支持 / Native Support | ⚡️ 最佳性能 / Optimal |
| Intel x86_64 | ✅ 完全支持 / Fully Supported | ✓ 良好 / Good |

### 支持的音频格式 / Supported Audio Formats

| 格式 / Format | 支持状态 / Support | 备注 / Notes |
|--------------|-------------------|-------------|
| MP3 (.mp3) | ✅ 完全支持 / Fully Supported | 常见格式 / Common Format |
| MP4/M4A (.mp4) | ✅ 完全支持 / Fully Supported | iTunes 格式 / iTunes Format |
| WAV (.wav) | ✅ 完全支持 / Fully Supported | 无损格式 / Lossless |
| FLAC (.flac) | ✅ 完全支持 / Fully Supported | 无损格式 / Lossless |
| AAC | ✅ 通过 AVFoundation 支持 / Via AVFoundation | |
| ALAC | ✅ 通过 AVFoundation 支持 / Via AVFoundation | Apple 无损 / Apple Lossless |

---

## 💿 安装 / Installation

### 方式一：下载预编译版本 / Method 1: Download Pre-built Release

1. 下载 `Patagonia Pulse.dmg` 文件 / Download the `Patagonia Pulse.dmg` file
2. 双击 DMG 文件打开 / Double-click to open the DMG file
3. 将应用拖拽到"应用程序"文件夹 / Drag the app to Applications folder
4. 首次打开时，右键点击应用并选择"打开" / Right-click and select "Open" for first launch
5. 如果遇到安全提示，前往"系统设置 > 隐私与安全性"允许应用运行  
   If you see a security warning, go to "System Settings > Privacy & Security" to allow the app

### 方式二：从源码编译 / Method 2: Build from Source

#### 前置要求 / Prerequisites
- Xcode 14.0 或更高版本 / or later
- macOS 14.0+ 开发环境 / development environment
- Apple Developer 账户（用于代码签名，可选）/ Apple Developer account (for code signing, optional)

#### 编译步骤 / Build Steps

```bash
# 1. 克隆仓库 / Clone the repository
git clone https://github.com/TheRealMilesLee/MusicPlayer-macOS.git
cd MusicPlayer-macOS

# 2. 打开 Xcode 项目 / Open Xcode project
open MusicPlayer/PatagoniaPulse.xcodeproj

# 3. 在 Xcode 中:
#    - 选择 "PatagoniaPulse" scheme
#    - 选择目标设备 "My Mac"
#    - 点击 Run (⌘ + R) 或 Archive 构建发布版本
#
# 3. In Xcode:
#    - Select "PatagoniaPulse" scheme
#    - Select target device "My Mac"
#    - Click Run (⌘ + R) or Archive for release build
```

#### 命令行编译 / Command Line Build

```bash
# 编译 Debug 版本 / Build Debug version
xcodebuild -project MusicPlayer/PatagoniaPulse.xcodeproj \
           -scheme PatagoniaPulse \
           -configuration Debug \
           -destination 'platform=macOS' \
           build

# 编译 Release 版本 / Build Release version
xcodebuild -project MusicPlayer/PatagoniaPulse.xcodeproj \
           -scheme PatagoniaPulse \
           -configuration Release \
           -destination 'platform=macOS' \
           -archivePath ./build/PatagoniaPulse.xcarchive \
           archive
```

---

## 🎮 使用指南 / Usage

### 首次使用 / First Time Setup

1. **启动应用** / **Launch App**: 双击应用图标启动 Patagonia Pulse
2. **选择音乐文件夹** / **Select Music Folder**:
   - 点击菜单栏 "Open" → "Choose Music Folder…" 
   - 或使用快捷键 `⌘ + O`
   - 选择包含音乐文件的文件夹
3. **等待加载** / **Wait for Loading**: 应用将自动扫描并加载音乐文件的元数据
4. **开始播放** / **Start Playing**: 双击任意歌曲开始播放

### 播放控制 / Playback Controls

#### 基本操作 / Basic Operations
- **播放/暂停** / **Play/Pause**: 点击播放按钮或双击歌曲
- **前进/后退** / **Forward/Backward**: 点击前进/后退按钮切换曲目
- **停止** / **Stop**: 点击停止按钮完全停止播放
- **进度调节** / **Seek**: 拖拽进度条到指定位置
- **循环播放** / **Repeat**: 点击无限循环图标启用单曲循环
- **随机播放** / **Shuffle**: 点击随机播放图标启用随机模式

#### 视图切换 / View Navigation
- **本地播放列表** / **Local Playlist**: 查看所有导入的音乐文件
- **艺术家** / **Artists**: 按艺术家浏览音乐
- **专辑** / **Albums**: 按专辑浏览音乐
- **最近播放** / **Recent**: 查看最近播放的歌曲历史

#### 搜索功能 / Search
- 在搜索框中输入歌名、艺术家或专辑名称进行搜索  
  Enter song title, artist, or album name in the search box
- 搜索结果会实时更新 / Search results update in real-time

### 界面说明 / Interface Overview

```
┌─────────────────────────────────────────────────────────────┐
│  ⚫ ⚫ ⚫                      Patagonia Pulse                 │
├──────────┬──────────────────────────────────────────────────┤
│          │                                                   │
│ Playlists│          [Search Bar]                           │
│          │                                                   │
│ • Local  │   ┌────────────────────────────────────┐        │
│ • Recent │   │  Title  │ Duration │ Artist │ Album│        │
│          │   ├────────────────────────────────────┤        │
│Categories│   │  Song 1 │  3:45   │  xxx   │  xxx │        │
│          │   │  Song 2 │  4:12   │  xxx   │  xxx │        │
│ • Artist │   │  ...                                │        │
│ • Album  │   └────────────────────────────────────┘        │
│          │                                                   │
├──────────┴──────────────────────────────────────────────────┤
│  🎵 [Album Art]  ⏮ ▶️/⏸ ⏭ 🔁 🔀                           │
│       └─────○──────────────────┘  [Time Display]           │
│              Now Playing: Song Name                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔧 故障排除 / Troubleshooting

### 常见问题 / Common Issues

#### 1. 应用无法打开 / App Won't Open
**问题** / **Problem**: 提示"无法打开，因为它来自身份不明的开发者"  
**解决方案** / **Solution**:
- 右键点击应用，选择"打开" / Right-click the app and select "Open"
- 前往"系统设置 > 隐私与安全性"，点击"仍要打开"  
  Go to "System Settings > Privacy & Security", click "Open Anyway"

#### 2. 音乐文件无法加载 / Music Files Not Loading
**问题** / **Problem**: 选择文件夹后，歌曲列表为空  
**解决方案** / **Solution**:
- 确保文件夹包含支持的音频格式（MP3, MP4, WAV, FLAC）  
  Ensure the folder contains supported audio formats
- 检查文件权限，允许应用访问该文件夹  
  Check file permissions and grant app access to the folder
- 重新选择文件夹 / Re-select the folder

#### 3. 元数据缺失 / Missing Metadata
**问题** / **Problem**: 显示"Unknown"艺术家或专辑  
**解决方案** / **Solution**:
- 音频文件可能缺少元数据标签 / Audio files may lack metadata tags
- 使用音乐标签编辑器（如 Mp3tag）添加元数据  
  Use a music tag editor (like Mp3tag) to add metadata
- 重新导入文件 / Re-import the files

#### 4. 播放无声音 / No Sound During Playback
**问题** / **Problem**: 播放进度条移动但无声音  
**解决方案** / **Solution**:
- 检查系统音量和静音设置 / Check system volume and mute settings
- 确认音频输出设备设置正确 / Verify correct audio output device
- 尝试播放其他歌曲 / Try playing other songs
- 重启应用 / Restart the application

#### 5. 应用崩溃或卡顿 / App Crashes or Freezes
**问题** / **Problem**: 应用在使用过程中崩溃或无响应  
**解决方案** / **Solution**:
- 减少音乐库大小，分批导入 / Reduce library size, import in batches
- 检查是否有损坏的音频文件 / Check for corrupted audio files
- 更新 macOS 到最新版本 / Update macOS to the latest version
- 重新安装应用 / Reinstall the application

---

## 🏗️ 开发与构建 / Development & Build

### 开发环境设置 / Development Environment Setup

```bash
# 1. 安装 Xcode Command Line Tools / Install Xcode Command Line Tools
xcode-select --install

# 2. 克隆项目 / Clone project
git clone https://github.com/TheRealMilesLee/MusicPlayer-macOS.git
cd MusicPlayer-macOS

# 3. 打开项目 / Open project
open MusicPlayer/PatagoniaPulse.xcodeproj
```

### 项目配置 / Project Configuration

#### Bundle Identifier
```
com.edu.ucdavis.Hengyi.Patagonia
```

#### 部署目标 / Deployment Target
```
macOS 14.0
```

#### Swift 版本 / Swift Version
```
Swift 5.0 (Target)
Swift 6.0 (Build SDK)
```

### 代码风格 / Code Style

本项目遵循以下编码规范 / This project follows these coding conventions:
- Swift 官方命名规范 / Swift official naming conventions
- 使用 4 空格缩进 / 4-space indentation
- 驼峰命名法 / CamelCase naming
- 详细的文档注释 / Detailed documentation comments

---

## 🤝 贡献 / Contributing

欢迎贡献代码、报告问题或提出新功能建议！  
Contributions, issues, and feature requests are welcome!

### 如何贡献 / How to Contribute

1. **Fork 本仓库** / **Fork the repository**
2. **创建功能分支** / **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **提交更改** / **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **推送到分支** / **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **创建 Pull Request** / **Create a Pull Request**

### 开发指南 / Development Guidelines

- 确保代码通过编译，无警告 / Ensure code compiles without warnings
- 添加必要的注释和文档 / Add necessary comments and documentation
- 遵循现有的代码风格 / Follow existing code style
- 测试你的更改 / Test your changes

---

## 📝 更新日志 / Changelog

### Version 1.5 (Current / 当前版本)
- ✨ 添加半透明毛玻璃效果 / Added vibrancy blur effect
- ✨ 优化窗口样式和用户体验 / Optimized window style and UX
- 🐛 修复文件加载相关问题 / Fixed file loading issues
- ⚡️ 改进元数据异步加载性能 / Improved async metadata loading performance
- 🎨 更新 UI 设计和动画效果 / Updated UI design and animations

### Future Plans / 未来计划
- 🔮 支持播放列表管理 / Playlist management support
- 🔮 添加均衡器功能 / Add equalizer functionality
- 🔮 支持在线音乐流媒体 / Online music streaming support
- 🔮 添加歌词显示功能 / Add lyrics display
- 🔮 支持 Last.fm scrobbling
- 🔮 支持音乐库统计功能 / Music library statistics

---

## 📄 许可证 / License

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

```
MIT License

Copyright (c) 2022 Ideologist (Hengyi Li)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👨‍💻 作者 / Author

**Hengyi Li** ([@TheRealMilesLee](https://github.com/TheRealMilesLee))
- 机构 / Institution: UC Davis
- Email: Refer to GitHub profile

---

## 🙏 致谢 / Acknowledgments

- 感谢 Apple 提供的强大 SwiftUI 和 AVFoundation 框架  
  Thanks to Apple for the powerful SwiftUI and AVFoundation frameworks
- 感谢所有为开源社区做出贡献的开发者  
  Thanks to all developers contributing to the open-source community
- 特别感谢所有测试者和反馈问题的用户  
  Special thanks to all testers and users who provided feedback

---

## 📞 支持 / Support

如果你喜欢这个项目，请给它一个 ⭐️！  
If you like this project, please give it a ⭐️!

遇到问题？/ Having issues?
- 📫 提交 Issue / Submit an Issue: [GitHub Issues](https://github.com/TheRealMilesLee/MusicPlayer-macOS/issues)
- 💬 参与讨论 / Join Discussion: [GitHub Discussions](https://github.com/TheRealMilesLee/MusicPlayer-macOS/discussions)

---

<div align="center">

**Made with ❤️ for macOS**

[⬆ 回到顶部 / Back to Top](#patagonia-pulse---macos-音乐播放器--music-player)

</div>
