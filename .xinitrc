# this makes it work in Ubuntu
#xhost +SI:localuser:$USER

# Set fallback pointer
#xsetroot -cursor_name left_ptr # Already have KDE set

# Fix scrolling on some GTK3 applications but disables gromit-mpx
#export GDK_CORE_DEVICE_EVENTS=1

# in case Java applications display /nothing/
# wmname LG3D
# export _JAVA_AWT_WM_NONREPARENTING=1

sh ~/.xmodmap
exec /usr/local/bin/wayfire
#exec /usr/bin/river
#exec /usr/bin/sway
#exec /usr/local/bin/stumpwm
