[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
VBoxClient-all &
exec i3
