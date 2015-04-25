node 'db' {
	include vim
	include sudo
	include mysql
	include apt-cron
	include nrpe
}

node 'app' {
	include vim
	include sudo
	include apt-cron
	include nrpe
}

node 'storage' {
	include vim
	include sudo
	include apt-cron
	include nrpe
}

node 'mgmt' {
	include vim
	include sudo
	include nagios-server
	include apt-cron
}

node 'ad' {
	include hosts_file
}
