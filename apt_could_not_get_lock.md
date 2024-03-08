If the following error pops up

```bash
E: Could not get lock /var/lib/dpkg/lock. It is held by process 4577 (dpkg)
N: Be aware that removing the lock file is not a solution and may break your system.
E: Unable to lock the administration directory (/var/lib/dpkg/), is another process using it?
```

You may first run

`sudo apt clean`

and then reboot via

`sudo reboot`

Afterward, run 

`sudo dpkg --configure -a`

followed by

`sudo apt-get upgrade`

if any error persists, work with each errored out package individually. 

