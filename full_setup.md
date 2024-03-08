0. (Prerequisites)

    1. Image the SD card and insert it into the Raspberry Pi (modify the files if needed [such as when enabling USB-otg mode]. Then wait for boot. 

    1. After the boot is complete, ensure you are able to access the terminal. 

    1. Connect to a network (ex. via `sudo raspi-config`)

    1. Enable SSH (ex. via `sudo raspi-config`). 

        To check if SSH is enabled correctly, you may perform a ssh loopback by `ssh <username>@127.0.0.1`, which is the host itself. 

    1. Set the user password (ex. via `sudo raspi-config`)

    1. Change the locale, time zone, keyboard input and layout, and wlan country (ex. via `sudo raspi-config`)

    1. Once the above steps are complete, follow the following recommendations in order. 

1. install `tmux` via the `sudo apt-get install tmux`. After it's complete, enter the following in `~/.tmux.conf` and save the file before start a tmux session. 

    ```bash
    unbind r
    bind r source-file ~/.tmux.conf
    
    setw -g mode-keys vi
    bind-key h select-pane -L
    bind-key j select-pane -D
    bind-key k select-pane -U
    bind-key l select-pane -R
    
    set -g status-position bottom
    set -g mouse on
    
    # tmux display things in 256 colors
    set -g default-terminal "tmux-256color"
    set -ag terminal-overrides ",xterm-256color:RGB"
    ```

    For a full installation, see tmux installation guide. 

2. In the tmux session, update the system via `sudo apt-get update`.

3. Set Bluetooth ssh (if applicable)

4. Set a static IP (if applicable).

5. Download / build Neovim (if applicable). Configure Neovim.

6. Update the `if` statement on line 59 of the `~/.bashrc` profile (setting the `PS1` variable) to the following

    ```bash
    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[03;41;97m\] \u\[\033[00;01;02;41;97m\]@\h \[\033[00m\]\[\033[00m\] ${PWD} \[\033[00;32m\]>\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h ${PWD} > '
    fi
    ```

    Add the following to the end of the file

    ```bash
    set -o vi
    export TERM=xterm-256color
    ```

1. Download needed utilities. Some suggestions are
    - `tree` (via `sudo apt-get install tree`)
    - `yt-dlp` (see guide)
    - `bypy`
    - `tigervnc`
    - `ripgrep` via (`sudo apt-get install ripgrep`)




