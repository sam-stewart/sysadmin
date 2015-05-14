class bacula-file::config {
	file { "/etc/bacula/bacula-fd.conf":
		ensure => present,
		source => "puppet:///modules/bacula-file/bacula-fd.conf",
		owner => "root", 
		group => "root", 
		mode => 0644,
		require => Class["bacula-file::install"],
		notify => Class["bacula-file::service"]
	}
}
