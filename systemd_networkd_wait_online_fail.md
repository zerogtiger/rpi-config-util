TO BE UPDATED:

It sounds as if you have >1 systemd.network(5) configuration file in /etc/systemd/network (or have [Match] section specifying >1 interface with a wildcard) with none set with the RequiredForOnline=false directive in the [Link] section. In that case, systemd-networkd-wait-online.service will expect all the systemd-networkd managed interfaces to reach a routable operational state.

Though setting that directive will also make it ignored by systemd-networkd-wait-online.service entirely, which is also probably not what you want. If you don't care about ordering against the network-online.target, then you might as well disable and/or mask the unit.

If you would prefer to retain the advantages of ordering dependencies against network-online.target, then the easiest way around this that I've found is to simply use the --any switch. Either create the file /etc/systemd/system/systemd-networkd-wait-online.service.d/override.conf or use sudo systemctl edit systemd-networkd-wait-online.service (which will also create the same file) and include these lines...

[Service]
ExecStart=
ExecStart=/usr/lib/systemd/systemd-networkd-wait-online --any
A subsequent sudo systemctl daemon-reload and sudo systemctl restart systemd-networkd-wait-online.service should tell you immediately whether it worked or not.

Alternatively, you can use the --interface= and/or --ignore= switches with systemd-networkd-wait-online. These may be used in place of, or in conjunction with, the --any switch shown above. If used with the --any switch, it will only consider those interfaces passed to --interface=, or not explicitly disregarded with --ignore=, when determining whether the machine has reached an online state.
