To copy files from one machine to another, we may use `scp`:

`scp <options> <userid>@<src hostname>:<file location> <userid>@<dest hostname>:<file location>`

Common options include 
- `-r`: recursively copy directories
- `-P`: specifies remote host ssh port
- `-p`: reserves file modification and access time
- `-C`: forces `scp` to compress data as it is sent

For instance, 
`scp -r tiger@zerogpi.local:~/.config ~/rpi/rpi0`
