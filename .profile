source /usr/share/www/intranet.directstartv.com/scripts/srcsync-dir/helper.sh
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

function gitprompt () {
	local gitbranch=$(git branch 2>&1 | grep '\*' | sed -e 's/\* //g')
	if [[ "$gitbranch" != "" ]]; then
      PS1="${GREEN}\w -${BLUE} ${gitbranch} ${GREEN}➔ ${LIGHT_GRAY}"
    else
      PS1="${GREEN}\w${BLUE} ${GREEN}➔ ${LIGHT_GRAY}"
    fi
}
PROMPT_COMMAND=gitprompt

# Setting PATH for Python 3.6
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"

export PATH="$HOME/.cargo/bin:$PATH"
