# 目录结构与文件介绍

- 本地信息放在`*/*.local`里，比如`zsh/.zshrc.local`下放API KEY
- `bootstrap.sh`：安装依赖工具（Homebrew 包）
- `install.sh`：备份并链接 dotfiles 到 `$HOME`

## 前置要求

在运行安装脚本前，请先确保：

1. 已安装 [Homebrew](https://brew.sh/)

2. `brew` 命令可用
   ```zsh
   brew --version
   ```

## 安装步骤

### 克隆项目并进入目录后，按顺序执行：

```zsh
chmod +x bootstrap.sh install.sh
./bootstrap.sh
./install.sh
```

### 说明
