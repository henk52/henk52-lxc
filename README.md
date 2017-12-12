lxc
===

LXC base installation

This is the lxc module.

sudo dnf install puppetlabs-stdlib
sudo ln -s /usr/share/puppet/modules/stdlib /etc/puppet/modules/stdlib
sudo puppet apply just_lxc.pp


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

lxc-create -n base_f20_x86_64 -t fedora
cat /var/lib/lxc/base_f20_x86_64/tmp_root_pass


lxc-start --logfile /tmp/lxc.log -l WARN -n base_f20_x86_64

  /var/lib/lxc/base/rootfs

lxc-stop -n base_f20_x86_64
lxc-destroy -n base_f20_x86_64

Remove the cache
  rm -rf /var/cache/lxc/fedora/x86_64/20
  rm -rf /var/lib/lxc/base_f20_x86_64


# On the local distribution manager/server
Run this manifest:
package { 'rsync': ensure => present }

file { '/etc/rsyncd.conf':
  ensure => present,
  content => "# /etc/rsyncd: configuration file for rsync daemon mode

# See rsyncd.conf man page for more options.

# configuration example:

# uid = nobody
# gid = nobody
# use chroot = yes
# max connections = 4
# pid file = /var/run/rsyncd.pid
# exclude = lost+found/
# transfer logging = yes
# timeout = 900
# ignore nonreadable = yes
# dont compress   = *.gz *.tgz *.zip *.z *.Z *.rpm *.deb *.bz2

# [ftp]
#        path = /home/ftp
#        comment = ftp export area
[fedora]
  path = /var/ks/mirrors/f20
",
  require => Package['rsync'],
  notify => Service['rsyncd'],
}

service { 'rsyncd':
  ensure => running,
  enable => true,
  require => File['/etc/rsyncd.conf'],
}


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
Fix:
On the web server create a file 'mirrorlist' in the document root.
I must contain at least two lines with http mirrors.
Line 2-6 starting with http will be picked.
So if you only have two servers then just repeat it twice.

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



#### One of the configured repositories failed (Fedora 20 - x86_64)
Workaround:
  rm /var/lib/lxc/base_f20_x86_64/rootfs/etc/yum.repos.d/fedora*

Storing root password in '/var/lib/lxc/base_f20_x86_64/tmp_root_pass'
Expiring password for user root.
passwd: Success
installing fedora-release package


 One of the configured repositories failed (Fedora 20 - x86_64),
 and yum doesn't have enough cached data to continue. At this point the only
 safe thing yum can do is fail. There are a few ways to work "fix" this:

     1. Contact the upstream for the repository and get them to fix the problem.

     2. Reconfigure the baseurl/etc. for the repository, to point to a working
        upstream. This is most often useful if you are using a newer
        distribution release than is supported by the repository (and the
        packages for the previous distribution release still work).

     3. Disable the repository, so yum won't use it by default. Yum will then
        just ignore the repository until you permanently enable it again or use
        --enablerepo for temporary usage:

            yum-config-manager --disable fedora

     4. Configure the failing repository to be skipped, if it is unavailable.
        Note that yum will try to contact the repo. when it runs most commands,
        so will have to try and fail each time (and thus. yum will be be much
        slower). If it is a very temporary problem though, this is often a nice
        compromise:

            yum-config-manager --save --setopt=fedora.skip_if_unavailable=true

Cannot retrieve metalink for repository: fedora/20/x86_64. Please verify its path and try again
DDD configure_fedora_systemd()

Container rootfs and config have been created.
Edit the config file to check/enable networking setup.

The temporary root password is stored in:

        '/var/lib/lxc/base_f20_x86_64/tmp_root_pass'


The root password is set up as expired and will require it to be changed
at first login, which you should do as soon as possible.  If you lose the
root password or wish to change it without starting the container, you
can change it from the host by running the following command (which will
also reset the expired flag):

        chroot /var/lib/lxc/base_f20_x86_64/rootfs passwd


