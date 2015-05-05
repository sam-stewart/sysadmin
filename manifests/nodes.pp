node 'db' {
	include vim
	include sudo
	include mysql
	include apt-cron
	include nrpe
	include ntp
}

node 'app' {
	include vim
	include sudo
	include apt-cron
	include nrpe
	include ntp
}

node 'storage' {
	include vim
	include sudo
	include apt-cron
	include nrpe
	include ntp
}

node 'mgmt' {
	include vim
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
