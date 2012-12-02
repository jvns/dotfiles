export EDITOR=vim
export CLASSPATH=$CLASSPATH:/usr/share/java/clojure.jar:$HOME/clones/clojure-contrib/src/main/clojure
export PATH=$PATH:/var/lib/gems/1.8/bin
alias ls='ls --color'

# Improve history
export HISTSIZE=10000
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n;"
