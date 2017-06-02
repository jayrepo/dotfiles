[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
/* xrandr --dpi 125 */
VBoxClient-all &
exec i3
