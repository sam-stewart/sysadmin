class nagios-server {
	include nagios-server::install, nagios-server::service, nagios-server::config

	file { '/etc/nagios3/htpasswd.users':
		ensure => present,
		source => "puppet:///modules/nagios-server/htpasswd.users",
		owner => 'root',
		group => 'root',
		mode => '0644',
		require => Class['nagios-server::install']
	}
}
