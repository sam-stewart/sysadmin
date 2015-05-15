class bacula-director::config {
	file { "/etc/bacula/bacula-dir.conf":
		ensure => present,
		source => "puppet:///modules/bacula-director/bacula-dir.conf",
		mode => 0640,
		owner => "bacula",
		group => "bacula",
		require => Class["bacula-director::install"],
		notify => Class["bacula-director::service"]
	}

	file { "/etc/bacula/bconsole.conf":
		ensure => present,
		source => "puppet:///modules/bacula-director/bconsole.conf",
		mode => 0640,
		owner => "bacula",
		group => "bacula",
		require => Class["bacula-director::install"],
		notify => Class["bacula-director::service"]
	}
}
