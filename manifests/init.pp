# == Class: lxc
#
# Full description of class lxc here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { lxc:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class lxc (
  $szAdditionalPackageListInsideLxc = hiera( 'AdditionalPackageListInsideLxc', '' )
){

$szFilesDirectory = '/etc/puppet/modules/lxc/files'

$LXCPATH = '/usr/share/lxc'
$LOCALSTATEDIR = '/var'
$LXCTEMPLATECONFIG = '/usr/share/lxc/config'

$szMirrorListAddress = '10.1.233.3'
$szRsyncAddress = '10.1.233.3'


  package { 'lxc':
    ensure => present,
  }


  package { 'lxc-templates':
    ensure => present,
  }

  # lua is at-least needed for running lxc-top.
  package { 'lua-lxc':
    ensure => present,
  }

  # Installs lxc-ls
  package { 'lxc-extra':
    ensure => present,
  }


  package { 'libvirt-daemon':
    ensure => present,
  }


  package { 'libvirt-daemon-driver-network':
    ensure => present,
  }

  package { 'libvirt-daemon-config-network':
    ensure => present,
  }

  package { 'libvirt-daemon-config-nwfilter':
    ensure => present,
  }



  service { 'libvirtd':
    enable => true,
    ensure => running,
    require => [ 
               Package [ 'libvirt-daemon' ],
               Package [ 'libvirt-daemon' ],
               Package [ 'libvirt-daemon-driver-network' ],
               Package [ 'libvirt-daemon-config-network' ],
               Package [ 'libvirt-daemon-config-nwfilter' ],
                     ],
  }


  file { "$LXCPATH/templates/lxc-fedora":
    ensure  => present,
    content => template('lxc/lxc-fedora.erb'),
    require => Package [ 'lxc-templates' ],
  }

  file { "$LXCTEMPLATECONFIG":
    ensure  => directory,
    require => Package [ 'lxc' ],
 }
             
  file { "$LXCTEMPLATECONFIG/fedora.common.conf":
    ensure  => present,
    source  => "$szFilesDirectory/fedora.common.conf",
    require =>  File [ "$LXCTEMPLATECONFIG" ],
  }
}
