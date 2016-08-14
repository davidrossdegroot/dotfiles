export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file
