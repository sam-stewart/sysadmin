node 'db' {
	include vim
	include bacula-file
	include sudo
	include mysql
	include apt-cron
	include nrpe
	include ntp
}

node 'app' {
	include vim
	include bacula-file
	include sudo
	include apt-cron
	include nrpe
	include ntp
}

node 'storage' {
	include vim
	include bacula-storage
	include bacula-file
	include sudo
	include apt-cron
	include nrpe
	include ntp
}

node 'mgmt' {
	include vim
	include bacula-file
	include bacula-director
	include sudo
	include nrpe
	include nagios-server
	include apt-cron
	include ntp
	include exim
}

node 'ad' {
	include hosts_file
}
