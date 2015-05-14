class bacula-file::install {
	package { 'bacula-fd':
		ensure => present,
	}
}
