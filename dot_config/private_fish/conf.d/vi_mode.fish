fish_vi_key_bindings --no-erase insert

# copy and paste
bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
bind yy fish_clipboard_copy
bind p fish_clipboard_paste
