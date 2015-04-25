class nagios-server::config {
	
	nagios_contact { 'fostt2':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Thomas Foster',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-email',
		host_notification_commands => 'notify-host-by-email',
		email => 'root@localhost',
	}

	nagios_contact { 'stewasc3':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Samuel Stewart',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-email',
		host_notification_commands => 'notify-host-by-email',
		email => 'root@localhost',
	}

	nagios_contactgroup { 'sysadmins':
		target => '/etc/nagios3/conf.d/ppt_contactgroups.cfg',
		alias => 'System Administrators',
		members => 'fostt2, stewasc3'
	}

	nagios_host { 'db.sqrawler.com':
                 target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
                 alias => 'db',
                 address => '10.25.1.46',
		 use => generic-host,
	}

	nagios_host { 'storage.sqrawler.com':
                 target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
                 alias => 'storage',
                 address => '10.25.1.42',
		 use => generic-host,
	}

	nagios_host { 'app.sqrawler.com':
                 target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
                 alias => 'app',
                 address => '10.25.1.44',
		 use => generic-host,
	}

	nagios_service { 'MySQL':
              service_description => 'MySQL DB',
              hostgroup_name => 'db-servers',
              target => '/etc/nagios3/conf.d/ppt_mysql_service.cfg',
              check_command => 'check_mysql_cmdlinecred!$USER3$!$USER4$',
	      use => generic-service
	}

	nagios_service { 'DiskSpace':
		service_description => 'Disk Space',
		hostgroup_name => 'debian-hosts',
		target => '/etc/nagios3/conf.d/ppt_diskspace_service.cfg',
		check_command => 'check_nrpe_1arg!check_hd',
		use => generic-service
	}

	nagios_service { 'CPU Load':
		service_description => 'CPU Load',
		hostgroup_name => 'debian-hosts',
		target => '/etc/nagios3/conf.d/ppt_cpuload.cfg',
		check_command => 'check_nrpe_1arg!check_load',
		use => generic-service
	}

	nagios_hostgroup { 'db-servers':
              target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
              alias => 'Database Servers',
              members => 'db.sqrawler.com',
	}

	nagios_hostgroup { 'debian-hosts':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Debian Hosts',
		members => 'db.sqrawler.com, app.sqrawler.com, storage.sqrawler.com'
	}
}
