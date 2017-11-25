# rofi-colorscheme-switch

![Alt Text](https://thumbs.gfycat.com/UnsungScratchyAmericancrocodile-size_restricted.gif)

### Setup

If you want to test if the script works in your enviroment run `printf "%b" \033]11;#00FF00\007` in your terminal or when you use tmux `printf "%b" "\033Ptmux;\033\033]11;#00FF00\007\033\\"`. When your terminal background does not turn green, rofi-colorscheme-switcher is not compatible with your setup.

Run `colorscheme-switch -h` to get a short help text.

Add `-modi colorscheme:rofi-colorscheme-switch` to your rofi configuration.
