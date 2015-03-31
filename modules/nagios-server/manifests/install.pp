class nagios-server::install {
	package { "nagios3" :
		ensure => present,
	}
}
	
