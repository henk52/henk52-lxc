package { 'lxc': ensure => present }
package { 'lxc-templates': ensure => present }
# lua is at-least needed for running lxc-top.
package { 'lua-lxc': ensure => present }
  # Installs lxc-ls
package { 'lxc-extra': ensure => present }
package { 'libvirt-daemon': ensure => present }
package { 'libvirt-daemon-driver-network': ensure => present }
package { 'libvirt-daemon-config-network': ensure => present }
package { 'libvirt-daemon-config-nwfilter': ensure => present }

service { 'libvirtd':
  enable => true,
  ensure => running,
  require => [ 
               Package[ 'libvirt-daemon' ],
               Package[ 'libvirt-daemon' ],
               Package[ 'libvirt-daemon-driver-network' ],
               Package[ 'libvirt-daemon-config-network' ],
               Package[ 'libvirt-daemon-config-nwfilter' ],
                     ],
}

file_line { 'replace_lxcbr0':
  path  => '/etc/lxc/default.conf',
  line  => 'lxc.network.link = virbr0',
  match => '^lxc.network.link =',
  require => Package[ 'lxc' ],
}
