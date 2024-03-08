# Semi-automatic (for repeated networks)

Note: not tested

1. edit `/etc/network/interfaces` and write
    ```
    auto wlan0
    iface wlan0 inet dhcp
                    wpa-ssid <ssid>
                    wpa-psk <password>
    ```
    Then save and close the file. 

2. Use the command `sudo dhclient wlan0`

# Manual

Note: 
- Not fully tested
- for new networks
- last step password doesn't work

1. Get wifi card up and running: `sudo ifconfig wlan0 up`

2. Scan for a list of wifi networks in range: `sudo iwlist wlan0 scan`

3. `sudo iwconfig wlan0 essid <target essid> key s:<password>`

# `sudo raspi-config`

Note: only works on Raspberry Pi

1. Open Raspberry Pi's config with `sudo raspi-config`

2. Select `1 System Options`

3. Select `1 Wireless LAN`

4. Select the country

5. Enter the SSID and password as prompted

# Checking

- `iwgetid` will show the SSID of the connected network

- `iwconfig` will provide full wireless connection details

