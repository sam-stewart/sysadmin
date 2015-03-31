node 'db' {
	include vim
	include sudo
	include mysql
	include apt-cron
}

node 'app' {
	include vim
	include sudo
	include hosts_file
	include apt-cron
}

node 'storage' {
	include vim
	include sudo
	include apt-cron
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
