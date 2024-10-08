# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mvn redis-cli sbt scala web-search lol jira docker brew aws docker-compose sudo yarn fasd)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias -g vim='nvim'
alias l='ls -lFh' #size, type, human readable
alias la='ls -lAFh' #long list, show almost all, type, human readable
alias ll='ls -l' #long list
alias ldot='ls -ld .*'

alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias grep='grep --color'

alias t='tail -f'

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L='| less'
alias -g M='| most'
alias -g LL='2>&1 | less'
alias -g CA='2>&1 | cat -A'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'

alias h='history'
alias sortnr='sort -n -r'
alias whereami=display_info

# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
if is-at-least 4.2.0; then
  # open browser on urls
  _browser_fts=(htm html de org net com at cx nl se dk dk php)
  for ft in $_browser_fts ; do alias -s $ft=open ; done

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex scala)
  for ft in $_editor_fts ; do alias -s $ft=vim ; done

  _image_fts=(jpg jpeg png gif mng tiff tif xpm)
  for ft in $_image_fts ; do alias -s $ft='open -a Preview'; done

  _media_fts=(ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts ; do alias -s $ft='open -a VLC' ; done

  #read documents
  alias -s pdf='open -a Preview'

  #list whats inside packed file
  alias -s zip="unzip -l"
  alias -s rar="unrar l"
  alias -s tar="tar tf"
  alias -s tar.gz="echo "
fi

alias zsource="source ~/.zshrc"
alias cddev="cd ~/dev"

alias gitlog='git log --pretty --oneline'

function Docker-Cleanup() {
  docker rm -f $(docker ps -aq)
  docker volume rm $(docker volume ls -qf dangling=true)
}

alias grd='cd "$(git rev-parse --show-toplevel)"'

function GitRebaseCommit() {
  grd
  last_commit=$(echo -n $(git log -1 --pretty=%B | xargs))
  read -q "REPLY?Previous commit: $last_commit. Rebase [y/N]? "
  echo "\n"
  if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    git reset HEAD^
    git add .
    git commit -m "$last_commit"
  else
    echo "Bailing"
  fi
}
alias dockerClean='Docker-Cleanup'

alias lcm='echo -n $(git log -1 --pretty=%B | xargs) | pbcopy'
alias grc='GitRebaseCommit'
alias master='git switch master'
alias git='hub'

source $(brew --prefix nvm)/nvm.sh
eval "$(/opt/homebrew/bin/brew shellenv)"

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home'
launchctl setenv JAVA_HOME $JAVA_HOME

export NVM_DIR="/Users/reid/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
	dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
	[[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
	print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

# don't check for new mail
MAILCHECK=0
MAIL=0

eval $(thefuck --alias)
source $(brew --prefix)/opt/chtf/share/chtf/chtf.sh

if [ -f ~/.bash_profile ]; then
	source ~/.bash_profile
fi

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export ANDROID_HOME="/usr/local/share/android-sdk"
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export ANDROID_AVD_HOME=$HOME/.android/avd
export ANDROID_SDK="/usr/local/share/android-sdk"
export ANDROID_NDK_REPOSITORY="/usr/local/share/android-ndk"
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$PATH

export GEM_HOME=/Users/reid/.gem
export PATH="$GEM_HOME/bin:$PATH"
export PATH="${PATH}:$(python3 -c 'import site; print(site.USER_BASE)')/bin"

export NODE_OPTIONS="--max-old-space-size=8192"

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
