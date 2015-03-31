class nagios-server {
	include nagios-server::install, nagios-server::config, nagios-server::service

	file { '/etc/nagios3/htpasswd.users':
		ensure => present,
		source => "puppet:///modules/nagios-server/htpasswd.users",
		owner => 'root',
		group => 'root',
		mode => '0640',
		require => Class['nagios-server::install']
	}
}
