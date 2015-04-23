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
                 check_period => '24x7',
                 max_check_attempts => 3,
                 check_command => 'check-host-alive',
                 notification_interval => 30,
                 notification_period => '24x7',
                 notification_options => 'd,u,r',
                 contact_groups => 'sysadmins',
	}

	nagios_service { 'MySQL':
              service_description => 'MySQL DB',
              hostgroup_name => 'db-servers',
              target => '/etc/nagios3/conf.d/ppt_mysql_service.cfg',
              check_command => 'check_mysql_cmdlinecred!$USER3$!$USER4$',
              max_check_attempts => 3,
              retry_check_interval => 1,
              normal_check_interval => 5,
              check_period => '24x7',
              notification_interval => 30,
              notification_period => '24x7',
              notification_options => 'w,u,c',
              contact_groups => 'sysadmins',
	}

	nagios_hostgroup { 'db-servers':
              target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
              alias => 'Database Servers',
              members => 'db.sqrawler.com',
	}
}
