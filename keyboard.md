To change the keyboard layout, edit

`/etc/default/keyboard/`

For instance,
```bash
XKBMODEL="apple_laptop"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
```

For a description of available keyboard layouts, variants, options, see

`man 5 keyboard`

which should point to the file

`/usr/share/X11/xkb/rules/base.lst`
