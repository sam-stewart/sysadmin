class bacula-file::config {
	file { "/etc/bacula/bacula-fd.conf":
		ensure => present,
		owner => "bacula", 
		group => "bacula", 
		mode => 0644,
		content => template('bacula-file/bacula-fd.erb'),
		require => Class["bacula-file::install"],
		notify => Class["bacula-file::service"]
	}
}
