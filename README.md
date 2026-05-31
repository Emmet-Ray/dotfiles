# 目录结构与文件介绍

- 使用 GNU Stow 管理 dotfiles。每个顶层目录是一个 stow package，目录内容对应 `$HOME` 下的相对路径
- 本地信息放在`*/*.local`里，比如`zsh/.zshrc.local`下放API KEY，这类文件不会提交到 Git
- `bootstrap.sh`：安装依赖工具（Homebrew 包）
- `install.sh`：备份已有冲突文件，并用 stow 链接 dotfiles 到 `$HOME`

## 当前 packages

- `zsh`：`~/.zshrc`、`~/.zprofile`、`~/aliases.zsh`
- `git`：`~/.gitconfig`、`~/.gitignore_global`
- `tmux`：`~/.tmux.conf`
- `codex`：`~/.codex/AGENTS.md`、`~/.codex/config.toml`

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

`install.sh` 会先检查每个 package 对应的目标文件。如果目标已经是正确的软链，会跳过；如果目标位置已有普通文件或其他软链，会移动到 `~/.dotfiles_backup/<timestamp>/` 后再运行 stow。

如果只想手动链接某个 package，可以直接运行：

```zsh
stow --no-folding --target="$HOME" zsh
stow --no-folding --target="$HOME" git
stow --no-folding --target="$HOME" tmux
stow --no-folding --target="$HOME" codex
```
