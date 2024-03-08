# Debian 11 Bullseye

This enables the Raspberry Pi as a USB ethernet gadget through USB-OTG.

If configuring on the Raspberry Pi 0, be sure to use the legacy version of Raspberry Pi OS. (Debian 11 (Bullseye))

After the SD-card has been imaged (if using a pre-existing setup, simply take the SD-card out of the Pi [not tested]) and plug it into a computer. 

Navigate to the drive and perform the following
1. open `cmdline.txt` and add `modules-load=dwc2,g_ether` before `rootwait`. Save the file. 

2. Open `config.txt` and add `dtoverlay=dwc2` on a new line after `[all]`. Save the file

3. Safely eject the drive and return it to the Raspberry Pi, then connect the USB cable direct to the computer and the Raspberry's USB port (that supports OTG mode).

The Raspberry Pi should now be detected as an Ethernet gadget and SSH should now work. Use the command `ssh <username>@<pihostname>.local`. 

