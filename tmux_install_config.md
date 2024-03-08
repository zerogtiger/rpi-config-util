1. Install tmux (likely via the package manager). For instance,

    `sudo apt-get install tmux`

2. Open the configuration file `~/.tmux.conf` and enter the following

    ```bash
    unbind r
    bind r source-file ~/.tmux.conf

    # Optional, changes the leader key from C-b to C-s
    # set -g prefix C-s

    # VI keymaps to switching between panes
    setw -g mode-keys vi
    bind-key h select-pane -L
    bind-key j select-pane -D
    bind-key k select-pane -U
    bind-key l select-pane -R

    # Location and mouse
    set -g status-position bottom
    set -g mouse on

    # tmux display things in 256 colors
    set -g default-terminal "tmux-256color"
    set -ag terminal-overrides ",xterm-256color:RGB"
    ```

3. Install the Tmux Plugin Manager (TPM) via the following

    `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

    and add the following to the `.tmux.conf` file

    ```bash
    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'

    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    run -b '~/.tmux/plugins/tpm/tpm'
    ```
    Save and source the file. Then quit Tmux if it is open and re-enter it. 

4. Press `<leader>I`, where `<leader>` is the leader key set above (usually `<C-b>`), to install TPM.

5. Now, you may install and configure any Tmux plugins. A recommended configuration can be found below

    ```bash
    # ...
    set -g @plugin 'christoomey/vim-tmux-navigator'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'dracula/tmux'

    set -g @dracula-show-powerline true
    set -g @dracula-show-left-sep " "
    set -g @dracula-show-right-sep " "
    set -g @dracula-plugins "ssh-session network network-ping cpu-usage ram-usage"
    set -g @dracula-ram-usage-colors "dark_purple white"
    set -g @dracula-cpu-usage-colors "pink dark_gray"
    set -g @dracula-ssh-session-colors "orange dark_gray"
    set -g @dracula-border-contrast true
    set -g @dracula-show-flags true
    set -g @dracula-show-left-icon session

    #...
    ```
