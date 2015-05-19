class nagios-server::install {
	package { "nagios3" :
		ensure => present,
	}

	package { "nagios-nrpe-plugin" :
		ensure => present,
		require => Package["nagios3"]
	}

	exec { "set-group":
		command => "/bin/chown root:puppet /etc/nagios3/conf.d",
		require => Package["nagios3"],
		refreshonly => true,
		subscribe => Package['nagios3']
	}

	exec { "set-perms":
		command => "/bin/chmod 775 /etc/nagios3/conf.d",
		require => Package["nagios3"],
		refreshonly => true,
		subscribe => Package['nagios3']
	}
}
	
