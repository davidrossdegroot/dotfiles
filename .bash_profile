for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file


if [[ -n "$ZSH_VERSION" ]]; then  # quit now if in zsh
    return 1 2> /dev/null || exit 1;
fi;

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
