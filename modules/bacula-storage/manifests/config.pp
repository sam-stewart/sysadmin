class bacula-storage::config {
	file { "/etc/bacula/bacula-sd.conf":
		ensure => present,
		source => "puppet:///modules/bacula-storage/bacula-sd.conf",
		owner => "bacula",
		group => "bacula",
		mode => 644,
		require => Class["bacula-storage::install"],
		notify => Class["bacula-storage::service"]
	}
}
