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

# Installation 

* This will read the PKG_LIST from the defaults.yaml.
puppet apply --verbose /etc/puppet/modules/lxc/tests/install_base.pp

* This has the list in puppet manifest.
puppet apply --verbose /etc/puppet/modules/lxc/tests/install_base.pp

# Usage

lxc-create -n base -t fedora

lxc-start --logfile /tmp/lxc.log -l WARN -n base

  /var/lib/lxc/base/rootfs


lxc-destroy -n base

Remove the cache
  rm -rf /var/cache/lxc/fedora/x86_64

# TODO 

* Configure the Distribution Manager to be an rsync repo
* Support: rsync -av mirrors.kernel.org::fedora/releases/20/Fedora/$basearch/os/LiveOS .
  rsync -av mirrors.kernel.org::fedora/releases/20/Fedora/x86_64/os/LiveOS .
    the 'fedora/' would be: /home/ks/repo/linux/

# Troubleshooting

#### ERROR: The remote path must start with a module name not a /
rsync -av 10.1.233.3::/home/ks/repo/linux/releases/20/Fedora/x86_64/os/LiveOS .
ERROR: The remote path must start with a module name not a /
rsync error: error starting client-server protocol (code 5) at main.c(1635) [Receiver=3.1.0]

#### curl: (6) Could not resolve host: mirrors.fedoraproject.org
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




#### Cannot retrieve metalink for repository: fedora/20. Please verify its path and try again
Cannot retrieve metalink for repository: fedora/20. Please verify its path and try again
Failed to download the rootfs, aborting.
Failed to download 'fedora base'
failed to install fedora
lxc_container: container creation template for base failed
lxc_container: Error creating container base


#### lxc-start: mac address 'DDD create_hwaddr()' conversion failed : Invalid argument
lxc-start -n base
lxc-start: mac address 'DDD create_hwaddr()' conversion failed : Invalid argument
lxc-start: failed to setup hw address for 'eth0'
lxc-start: failed to setup netdev
lxc-start: failed to setup the network for 'base'
lxc-start: failed to setup the container
lxc-start: invalid sequence number 1. expected 2
lxc-start: failed to spawn 'base'
lxc-start: The container failed to start.
lxc-start: Additional information can be obtained by setting the --logfile and --log-priority options.

