# Debian 12 Bookworm
Debian bookworm uses `NetworkManager` as the default network manager.

Run the following command to add a connection called `eduroam` with SSID `eduroam`

```bash
nmcli con add \
        type wifi \
        ifname wlan0 \
        con-name eduroam \
        ssid eduroam \
        ipv4.method auto \
        802-1x.eap peap \
        802-1x.phase2-auth mschapv2 \
        802-1x.identity <EDU EMAIL> \
        802-1x.password <PASSWORD> \
        wifi-sec.key-mgmt wpa-eap
```
Connections can be found at 

`/etc/NetworkManager/system-connections`

and could be renamed by renaming the file and editing its contents. 

To check currently available connections, you may use

`sudo nmcli c show`

To rename a connection:

'sudo nmcli c mod <connection-name> connection.id <new-connection-name>'

To find the attributes and values that can be applied to a connection, try

`sudo nmcli c mod <connection-name> <TAB>`

To view the attributes for a connection:

`sudo nmcli c show <connection-name>`

To modify the attribute of a connection, you may use

`sudo nmcli c modify <connection-name> attribute value`

Bring a network connection down and up

`sudo nmcli c down <connection-name>`

or

`sudo nmcli c up <connection-name>`

# Debian 11 Bullseye

Check that the `wlan0` interface is up by using the command

`sudo ifconfig wlan0 up`

Edit 

`/etc/networks/interfaces`

to the following (some of which are not applicable to wlan0)

```bash
# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
# source /etc/network/interfaces.d/*
auto lo
iface lo inet loopback
iface eth0 inet manual
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
```
then write and exit the file. 

Edit 

`/etc/wpa_supplicant/wpa_supplicant.conf`

and update `networks` to be the following

```bash
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=CA

network={
  ssid="eduroam"
  scan_ssid=1 # or 0, try both
  key_mgmt=WPA-EAP
  eap=PEAP
  identity="EDU EMAIL"
  password="PASSWORD"
  phase1="peaplabel=0"
  phase2="auth=MSCHAPV2"
}
```

then write and exit the file. 

Now, run the following commands in order

```bash
sudo systemctl restart wpa_supplicant.service
sudo wpa_cli -i wlan0 reconfigure

sudo killall wpa_supplicant
sudo wpa_supplicant -i wlan0 -D wext -c/etc/wpa_supplicant/wpa_supplicant.conf -B
```

it may take a while, but `wlan0` should now be connected. 

You may test that `wlan` is work by pinging google.com (i.e., `ping google.com`).

