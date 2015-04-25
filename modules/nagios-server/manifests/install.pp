class nagios-server::install {
	package { "nagios3" :
		ensure => present,
	}

	package { "nagios-nrpe-plugin" :
		ensure => present,
	}
}
	
