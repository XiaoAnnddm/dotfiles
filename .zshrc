# -----------------------------------------------------------------------------
# Powerlevel10k instant prompt
# -----------------------------------------------------------------------------
# 该部分必须放在 .zshrc 顶部（靠近最上方），以便 Powerlevel10k 的 instant prompt 功能
# 能够在 shell 启动时尽早生效，加速命令行显示。
# 任何可能需要终端输入的初始化代码（如密码、交互式确认等）都应放在这部分之前。
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
# Zinit 插件管理器的安装和加载
# -----------------------------------------------------------------------------
# 安装 Zinit（如尚未安装），并加载 Zinit 主脚本。
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# 加载 zinit 的自动补全支持
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# -----------------------------------------------------------------------------
# Zinit 插件加载
# -----------------------------------------------------------------------------
# 加载常用 annex 扩展（无需 Turbo 模式）
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# 加载常用 Zsh 插件
zinit light zsh-users/zsh-syntax-highlighting   # 命令语法高亮
zinit light zsh-users/zsh-completions           # 丰富的自动补全
zinit light zsh-users/zsh-autosuggestions       # 历史命令自动建议
zinit light Aloxaf/fzf-tab                      # fzf tab 补全增强
zinit light jeffreytse/zsh-vi-mode              # vi 编辑模式

# -----------------------------------------------------------------------------
# Powerlevel10k 主题加载
# -----------------------------------------------------------------------------
zinit ice depth=1                              # 只拉取一层 git 历史，加速 clone
zinit light romkatv/powerlevel10k              # 优秀的 Zsh 主题

# -----------------------------------------------------------------------------
# 自动补全初始化
# -----------------------------------------------------------------------------
# compinit 必须在插件全部加载后调用，否则会导致补全脚本找不到。
autoload -Uz compinit
compinit

# -----------------------------------------------------------------------------
# Powerlevel10k 主题配置文件加载
# -----------------------------------------------------------------------------
# 如存在个性化配置，则加载
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -----------------------------------------------------------------------------
# 键位绑定（vi 模式和历史搜索）
# -----------------------------------------------------------------------------
bindkey -v                                     # 启用 vi 按键模式
bindkey '^P' up-line-or-search                 # Ctrl+P 搜索历史命令
bindkey '^N' down-line-or-search               # Ctrl+N 反向搜索历史命令

# -----------------------------------------------------------------------------
# 环境变量设置
# -----------------------------------------------------------------------------
export EDITOR=nvim                             # 默认文本编辑器为 nvim
export VISUAL=nvim                             # 可视化编辑器为 nvim
export SUDO_EDITOR=nvim                        # sudo 下编辑器为 nvim
export FCEDIT=nvim                             # fc 命令的编辑器
export TERMINAL=kitty                          # 终端程序名

# -----------------------------------------------------------------------------
# Zsh 基础选项
# -----------------------------------------------------------------------------
setopt autocd               # 直接输入目录名即可 cd 进入
setopt correct              # 命令自动纠错
setopt interactivecomments  # 交互模式下允许注释
setopt magicequalsubst      # 支持 foo=bar 这种参数的文件名扩展
setopt nonomatch            # 通配符未匹配时不报错
setopt notify               # 后台任务状态即时通知
setopt numericglobsort      # 数字排序文件名
setopt promptsubst          # 支持提示符中命令替换

# -----------------------------------------------------------------------------
# 历史记录配置
# -----------------------------------------------------------------------------
HISTSIZE=10000                  # 保留最多历史记录条数
HISTFILE=~/.zsh_history         # 历史记录文件路径
SAVEHIST=$HISTSIZE              # 实际保存条数
setopt appendhistory            # 追加历史而不是覆盖
setopt sharehistory             # 多终端共享历史
setopt hist_ignore_space        # 忽略以空格开头的命令
setopt hist_ignore_all_dups     # 忽略全部重复命令
setopt hist_save_no_dups        # 保存时不保留重复命令
setopt hist_ignore_dups         # 当前会话中不保留重复命令
setopt hist_find_no_dups        # 历史搜索不重复
setopt HIST_IGNORE_DUPS         # 同上，消除重复历史

# -----------------------------------------------------------------------------
# 自动补全美化与样式
# -----------------------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'         # 补全时不区分大小写
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"        # 颜色使用系统 LS_COLORS
zstyle ':completion:*' menu no                                 # 禁用补全菜单
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpatath' # cd 补全时预览文件夹内容

# -----------------------------------------------------------------------------
# 常用别名
# -----------------------------------------------------------------------------
alias c='clear'           # 清屏
alias q='exit'            # 退出终端
alias ..='cd ..'          # 返回上级目录
alias mkdir='mkdir -pv'   # 创建目录时输出过程
alias la='ls -a'          # 查看所有文件
alias cp='cp -iv'         # 交互式复制，显示详细信息
alias mv='mv -iv'         # 交互式移动，显示详细信息
alias rm='rm -iv'         # 交互式删除，显示详细信息
alias rmdir='rmdir -v'    # 删除目录时输出详细信息
alias grep='grep --color=auto'      # 高亮 grep 匹配
alias fgrep='fgrep --color=auto'    # 高亮 fgrep 匹配
alias egrep='egrep --color=auto'    # 高亮 egrep 匹配

# 代替工具，需要安装包
alias ls='lsd'
alias cat='bat'

# -----------------------------------------------------------------------------
# 历史搜索功能增强
# -----------------------------------------------------------------------------
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# -----------------------------------------------------------------------------
# 其它自动补全脚本（如有需要可保留，否则建议注释或删除）
# -----------------------------------------------------------------------------
[[ -f /home/andrew/.dart-cli-completion/zsh-config.zsh ]] && . /home/andrew/.dart-cli-completion/zsh-config.zsh || true

# -----------------------------------------------------------------------------
# 代理设置
# -----------------------------------------------------------------------------
# 代理地址和端口
proxy_host="127.0.0.1"
proxy_port="28090"

# 设置代理的函数
function proxy_on() {
    export http_proxy="http://${proxy_host}:${proxy_port}"
    export https_proxy="http://${proxy_host}:${proxy_port}"
    export all_proxy="socks5://${proxy_host}:${proxy_port}"
    echo "代理已启用，当前代理: ${http_proxy}"
}

# 取消代理的函数
function proxy_off() {
    unset http_proxy https_proxy all_proxy
    echo "代理已关闭"
}

# 查看当前代理的函数
function proxy_status() {
    if [ -n "$http_proxy" ]; then
        echo "当前代理: $http_proxy"
    else
        echo "当前没有设置代理"
    fi
}

# 定义便捷别名
alias pon="proxy_on"
alias poff="proxy_off"
alias pstatus="proxy_status"
