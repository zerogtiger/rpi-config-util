If you ever get this message
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:<sha256 hash>
Please contact your system administrator.
Add correct host key in <USER HOME DIRECTORY>/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in <USER HOME DIRECTORY>/.ssh/known_hosts:28
Host key for <ip address / ssh alias> has changed and you have requested strict checking.
Host key verification failed.
```
and you are sure the host is safe, edit `~/.ssh/known_hosts` and remove the items that start with the `<ip address / ssh alias>` and try again. 

