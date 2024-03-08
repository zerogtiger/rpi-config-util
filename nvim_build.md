1. Download the developer tools by running 

`sudo apt-get install ninja-build gettext cmake unzip curl git`

2. Download the source code for the wanted release from the Neovim GitHub via `curl -LO https://github.com/neovim/neovim/archive/refs/tags/v0.9.5.zip`. Extract the compressed archive. 

3. Navigate to the `neovim-X.X.X` directory and run the build command `make CMKE_BUILD_TYPE=RelWithDebInfo`

4. After the build is complete, run 

    `cpack -G DEB`

    to build the DEB package, and

    `sudo dpkg -i nvim-linux64.deb`

    to install it. After it's done, verify Neovim is up and running via `nvim`. Afterwards, you may remove the `neovim` directory. 

