class bacula-storage::install {
	package { 'bacula-sd':
		ensure => present
	}
}
