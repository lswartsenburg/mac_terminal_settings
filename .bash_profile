# ~/.zshrc
load_nvm() {
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
function venv_activate() {
    source .virtualenv/bin/activate
}
function venv_create() {
	python3 -m venv .virtualenv
}

# Install zsh autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/local/etc/bash_completion.d

# Install starship
eval "$(starship init zsh)"


# Install https://github.com/gibbling/dircolors

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if type -P gdircolors >/dev/null ; then
	if [[ -f ~/.dircolors ]] ; then
		eval $(gdircolors ~/.dircolors/dircolors.256dark)
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval $(gdircolors -b /etc/DIR_COLORS)
	fi
fi

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;35;40'

export HISTCONTROL=ignoreboth:erasedups

