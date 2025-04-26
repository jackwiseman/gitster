# vim:et sts=2 sw=2 ft=zsh
#
# Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#
# Requires the `prompt-pwd` and `git-info` zmodules to be included in the .zimrc file.

setopt nopromptbang prompt{cr,percent,sp,subst}

zstyle ':zim:prompt-pwd' git-root yes

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'

  if [[ -n $UNICODE_SUPPORT ]]; then
    # Unicode-supporting terminal
    CLEAN='%F{green}%{%G✓%}'
    DIRTY='%F{yellow}%{%G✗%}'
  else
    # Plain TTY-safe symbols
    CLEAN='%F{green}[OK]'
    DIRTY='%F{yellow}[X]'
  fi

  zstyle ':zim:git-info:clean' format "$CLEAN"
  zstyle ':zim:git-info:dirty' format "$DIRTY"

  zstyle ':zim:git-info:keys' format \
      'prompt' ' %F{cyan}%b%c %C%D'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

PS1=''
if [[ -n "$SSH_CONNECTION" ]]; then
  PS1='%F{white}%n@%m '
fi
PS1+='%B%(?:%F{green}:%F{red})%{%G'
if [[ -n "$UNICODE_SUPPORT" ]]; then
  PS1+='➜'
else
  PS1+='>'
fi
PS1+='%} %F{white}$(prompt-pwd)${(e)git_info[prompt]}%f%b '
unset RPS1
