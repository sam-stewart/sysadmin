class mysql::config {
	file { "/etc/mysql/my.cnf":
		ensure => present,
		source => "puppet:///modules/mysql/my.cnf",
		mode => 0444,
		owner => "mysql",
		group => "mysql",
		require => Class["mysql::install"],
		notify => Class["mysql::service"],
	}

	file { "/etc/mysql/debian-start":
		ensure => present,
		source => "puppet:///modules/mysql/debian-start",
		owner => "root",
		group => "root",
		mode => 0555,
		require => Class["mysql::install"],
		notify => Class["mysql::service"],
	}

	cron { mysqldump:
		command => "mysqldump --all-databases --add-drop-table > ~/db.backup.sql",
		user => root,
		hour => 2,
		minute => 0,
	}
}
		
