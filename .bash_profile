# If you need to have php@7.2 first in your PATH run:
#   echo 'export PATH="/usr/local/opt/php@7.2/bin:$PATH"' >> ~/.bash_profile
#   echo 'export PATH="/usr/local/opt/php@7.2/sbin:$PATH"' >> ~/.bash_profile

# For compilers to find php@7.2 you may need to set:
#   export LDFLAGS="-L/usr/local/opt/php@7.2/lib"
#   export CPPFLAGS="-I/usr/local/opt/php@7.2/include"

export BASE_PS1="\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[33m\]\$(parse_git_branch)\[\033[34m\] \$\[\033[00m\] "


# Should we print timestamps?
TIME_START=false

# Print timestamps to determine why starting a terminal is slow
timestamp() {
	if [ "$TIME_START" = true ] ; then
		if ! [ -z "$1" ]                           # Is parameter #1 zero length?
		then
			echo $1
		fi
	  python -c 'import time; print time.time()'
	fi
}

# Loading nvm was slow. Only load NPM when this function is explicitly called
version_nvm() {
	export PS1="[$(nvm_ls 'current')] $BASE_PS1"
}

add_nvm_ps1() {
	nvm $@
	version_nvm
}


load_nvm() {
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	version_nvm
	alias nvm=add_nvm_ps1
}

nvm_use() {
	load_nvm && nvm use && version_nvm
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

timestamp "Start"
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

timestamp "Non-interactive check done"

# Auto complete for git
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

timestamp "Auto complete for git done"

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


timestamp "History appending done"

# Change the window title of X terminals
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'


# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if type -P gdircolors >/dev/null ; then
	if [[ -f ~/.dircolors ]] ; then
		eval $(gdircolors ~/.dircolors/dircolors.256dark)
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval $(dircolors -b /etc/DIR_COLORS)
	fi
fi

export PS1="\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[33m\]\$(parse_git_branch)\[\033[34m\] \$\[\033[00m\] "

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;35;40'

export HISTCONTROL=ignoreboth:erasedups

timestamp "Adding color and aliases done"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


function venv_activate() {
    source .virtualenv/bin/activate
}

function venv_create() {
		python3 -m venv .virtualenv
}



# # export PATH="/usr/local/opt/php@7.2/bin:$PATH"
# # export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
# export PATH="/Applications/MAMP/bin/php/php7.3.7/bin:$PATH"


# PHP_VERSION=`ls /Applications/MAMP/bin/php/ | sort -n | tail -1`

# export PATH="/Users/lucasswartsenburg/google-cloud-sdk/bin:/Users/lucasswartsenburg/.composer/vendor/bin:$PATH"
