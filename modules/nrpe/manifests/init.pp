# == Class: nrpe
#
# Full description of class nrpe here.
#
# === Parameters
#
# Document parameters here.
#
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# === Examples
#
#
# === Copyright
#
# Copyright 2013 Computer Action Team, unless otherwise noted.
#
class nrpe (
  $allowed_hosts = ['10.25.1.41', 'localhost', '127.0.0.1'],
  $config        = $nrpe::params::nrpe_config,
  $include_dir   = $nrpe::params::nrpe_include_dir,
  $package_name  = $nrpe::params::nrpe_packages,
  $provider      = $nrpe::params::nrpe_provider,
  $purge         = undef,
  $recurse       = undef,
  $service_name  = $nrpe::params::nrpe_service,
) inherits nrpe::params {

  package { $package_name:
    ensure   => installed,
    provider => $provider,
  }

  service { 'nrpe_service':
    ensure    => running,
    name      => $service_name,
    enable    => true,
    require   => Package[$package_name],
    subscribe => File['nrpe_config'],
  }

  file { 'nrpe_config':
    name    => $config,
    content => template('nrpe/nrpe.cfg.erb'),
    require => File['nrpe_include_dir'],
  }

  file { 'nrpe_include_dir':
    ensure  => directory,
    name    => $include_dir,
    purge   => $purge,
    recurse => $recurse,
    require => Package[$package_name],
  }

  command {
    'check_hd':
	ensure => present,
	command => 'check_disk -w 20% -c 10% -p /'
  }

  command {
    'check_load':
	ensure => present,
	command => 'check_load -w 15,10,5 -c 30,25,20'
  }

  command {
    'check_procs':
	ensure => present,
	command => 'check_procs -w 250 -c 400' 
  }

 command {
   'check_users':
	ensure => present,
	command => 'check_users -w 3 -c 10'
  }
}
