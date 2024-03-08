TO BE UPDATED:

1. Install the windows manager via
    
    `sudo apt-get install i3`

2. Install xinit package via

    `sudo apt-get install xinit`

    `sudo apt-get install lightdm`

    `sudo sed -i s/greeter-session=pi-greeter/greeter-session=lightdm-gtk-greeter/g /etc/lightdm/lightdm.conf`

    get status: `sudo systemctl status lightdm`

    `echo "exec i3" > .xinit.rc`

    --

    Install dependencies (XServer, xterm): 
    `sudo apt-get install xserver-xorg xserver-xorg-core xserver-common xterm xfonts-base xfonts-100dpi xfonts-75dpi xfonts-scalable`

    TigerVNC server:
    `sudo apt-get install tigervnc-standalone-server`

    Display manager:
    `sudo apt-get install lightdm`

    Edit the `[XDMCPServer]` section of `/etc/lightdm/lightdm.conf` to be the following

    ```bash
    [XDMCPServer]
    enabled=true
    port=177
    ```

    `sudo systemctl restart lightdm.service`

    `sudo systemctl status lightdm.service`

    <!-- Full: -->
    <!-- Install TigerVNC: `TigerVNC server: sudo apt-get install tigervnc-standalone-server xfonts-scalable xfonts-100dpi xfonts-75dpi --no-install-recommends` -->
    <!---->
    <!-- ```bash -->
    <!-- sudo edit-lightdm-config -->
    <!-- sudo make-systemd-xvnc -->
    <!-- sudo reboot -->
    <!-- ``` -->
