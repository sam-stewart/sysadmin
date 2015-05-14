class bacula-director::install {
	package { 'bacula-server':
		ensure => present,
	}

	package { 'bacula-console':
		ensure => present,
	}
}
