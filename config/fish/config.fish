if status is-interactive
    atuin init fish | source
end

starship init fish | source

# Setting PATH for Python 3.12
# The original version is saved in /Users/3ux1n3/.config/fish/config.fish.pysave

if command -v ngrok &>/dev/null
    eval "$(ngrok completion)"
end

set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"
set -g fish_greeting ""
