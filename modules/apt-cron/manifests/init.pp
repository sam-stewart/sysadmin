class apt-cron {
	cron { aptupdate:
		command => "apt-get update",
		user => root,
		hour => 2,
		minute => 0
	}
}
