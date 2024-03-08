Note: you may need `sudo` permissions for some of the following

1. Install `bluez-tools` via the package manager (i.e., `sudo apt-get install bluez-tools`)

1. Edit 
    
    `/etc/systemd/network/pan0.netdev`

    to be the following
    ```bash
    [NetDev]
    Name=pan0
    Kind=bridge
    ```
2. Edit 

    `/etc/systemd/network/pan0.network`

    to be following
    ```bash
    [Match]
    Name=pan0
    
    [Network]
    Address=172.168.1.1/24
    DHCPServer=yes
    ```

3. Edit 

    `/etc/systemd/system/bt-agent.service`

    to be the following
    ```bash
    [Unit]
    Description=Bluetooth Auth Agent
    
    [Service]
    ExecStart=/usr/bin/bt-agent -c NoInputNoOutput
    Type=simple
    
    [Install]
    WantedBy=multi-user.target
    ```

4. Edit 

    `/etc/systemd/system/bt-network.service`

    to be the following
    ```bash
    [Unit]
    Description=Bluetooth NEP PAN
    After=pan0.network
    
    [Service]
    ExecStart=/usr/bin/bt-network -s nap pan0
    Type=simple
    
    [Install]
    WantedBy=multi-user.target
    ```

4. Run the following commands in order
    ```bash
    sudo systemctl enable systemd-networkd
    sudo systemctl enable bt-agent
    sudo systemctl enable bt-network
    sudo systemctl start systemd-networkd
    sudo systemctl start bt-agent
    sudo systemctl start bt-network
    ```

5. Edit 

    `/etc/rc.local`

    and add the following before `exit 0`.
    ```bash
    sudo bluetoothctl <<EOF
    power on
    discoverable on
    pairable on
    EOF
    ```

6. Edit 

    `/etc/bluetooth/main.conf`

    and uncomment 
    ```bash
    DiscoverableTimeout = 0
    ```

7. Add the following to the user `.bashrc`
    ```bash
    sudo bt-adapter --set Discoverable 0
    ```

To manually set visibility, run
```bash
sudo bt-adapter --set Discoverable 1
```

Now, open your device's bluetooth settings and the Raspberry Pi should be able to be discovered. 
