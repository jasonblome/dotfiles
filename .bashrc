echo "$(date +'%m/%d/%C %H:%M:%S') Evaluating ~/.bashrc"

export EDITOR=emacs

# don't allow duplicates in the history file
export HISTCONTROL=ignoredups:erasedups

# allow for a large history
export HISTSIZE=10000
export HISTFILESIZE=1000000

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# Add the JetBrains tools to the search path
export PATH="/home/${USER}/install/intellij/bin/:/home/${USER}/install/pycharm/bin/:/home/${USER}/install/datagrip/bin/:$PATH"

# Add anaconda to the search path
export PATH="/home/${USER}/install/anaconda/bin:$PATH"

# Set java home to 1.8
export JAVA_HOME=/usr/lib/jvm/java-openjdk/

# Ignore missing github SSL certs
export GIT_SSL_NO_VERIFY=1

# Ignore GTK accessibility warning
export NO_AT_BRIDGE=1

# color variables
if [ -f ~/.colorsetup ]; then
    source ~/.colorsetup
fi

# fun unicode characters
# the easy way to get the utf-8 code is to fire up python
# set a string variable s = u'\u${UNICODE-NUMBER} and then
# do s.encode('utf-8')
COFFEE_MUG=
#$(echo -e "\xe2\x98\x95")
CROSSBONES=
#$(echo -e "\xe2\x98\xa0")

export CLICOLOR=1
alias less='less -r'
alias ls='ls --color=always'
alias grep='grep --color=always'

# the color to use when running the hl (highlight command)
export HIGHLIGHTER_COLOR="\[${CONSOLE_ATTR_BOLD}${CONSOLE_FG_RED}\]"
function hl {
    # turn the parameter list into an R.E. for sed
    RE=$(echo "$@" | sed -E 's/[[:space:]]+/|/g')
    sed -E "s/$RE/${HIGHLIGHTER_COLOR}&${CONSOLE_ATTR_NONE}/g"
}

export CONSOLE_USER_COLOR="\[$(tput setaf 202)\]"
export CONSOLE_HOST_COLOR="\[$(tput setaf 160)\]"
export CONSOLE_PWD_COLOR="\[$(tput setaf 25)\]"
export TERM_TITLE=""
bash_prompt_command() {
    # update the history so that commands are immediately appended to the file
    # append any new commands to the history file
    history -a
    # clear the history list
    history -c
    # re-read the history list from the file
    history -r
    RETURN_CODE_COLOR="${CONSOLE_FG_RED}${CROSSBONES}${CONSOLE_ATTR_NONE} "
    if [[ $? == 0 ]]; then
	RETURN_CODE_COLOR="${CONSOLE_FG_GREEN}${COFFEE_MUG}${CONSOLE_ATTR_NONE} "
    fi
    export PS1="\[\033]0;$TERM_TITLE \u@\h:\w\007\]${RETURN_CODE_COLOR}\t ${CONSOLE_USER_COLOR}\u${CONSOLE_ATTR_NONE}@${CONSOLE_HOST_COLOR}\h${CONSOLE_ATTR_NONE}:${CONSOLE_PWD_COLOR}\w${CONSOLE_ATTR_NONE} "
}

PROMPT_COMMAND=bash_prompt_command
function set_title() {
    export TERM_TITLE=$1
}
