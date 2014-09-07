lxc
===

LXC base installation

This is the lxc module.

License
-------


Contact
-------

References
----------
- https://linuxcontainers.org/
- https://help.ubuntu.com/lts/serverguide/lxc.html


Support
-------

Please log tickets and issues at our [Projects site](http://projects.example.com)


= Usage =

lxc-create -n base -t fedora

= TODO =

- Configure the Distribution Manager to be an rsync repo
- Support: rsync -av mirrors.kernel.org::fedora/releases/20/Fedora/$basearch/os/LiveOS .
  rsync -av mirrors.kernel.org::fedora/releases/20/Fedora/x86_64/os/LiveOS .
    the 'fedora/' would be: /home/ks/repo/linux/

= Troubleshooting =

==== ====
rsync -av 10.1.233.3::/home/ks/repo/linux/releases/20/Fedora/x86_64/os/LiveOS .
ERROR: The remote path must start with a module name not a /
rsync error: error starting client-server protocol (code 5) at main.c(1635) [Receiver=3.1.0]

==== ====
lxc-create -n base -t fedora
Host CPE ID from /etc/os-release: cpe:/o:fedoraproject:fedora:20
Checking cache download in /var/cache/lxc/fedora/x86_64/20/rootfs ... 
Downloading fedora minimal ...
curl: (6) Could not resolve host: mirrors.fedoraproject.org
Failed to get a mirror on try 1
Trying again...
curl: (6) Could not resolve host: mirrors.fedoraproject.org
Failed to get a mirror on try 2
Trying again...
curl: (6) Could not resolve host: mirrors.fedoraproject.org
Failed to get a mirror on try 3
^C
[root@localhost lxc]# Interrupted, so cleaning up
lxc-destroy: Error: base creation was not completed
Container is not defined
exiting...
^C

