class nagios-server::config {
	
	### GENERIC DEFINITIONS ###
	
	nagios_host { 'generic-host':
		target => '/etc/nagios3/conf.d/ppt_generichosts.cfg',
		notifications_enabled => '1',
		event_handler_enabled => '1',
		flap_detection_enabled => '1',
		failure_prediction_enabled => '1',
		process_perf_data => '1',
		retain_status_information => '1',
		retain_nonstatus_information => '1',
		check_command => 'check-host-alive',
		check_period => '24x7',
		max_check_attempts => '3',
		notification_interval => '30',
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
		register => '0',
		notify => Exec['fix-file-permissions'],
	}

	nagios_service { 'generic-service':
		target => '/etc/nagios3/conf.d/ppt_genericservices.cfg',
		active_checks_enabled => '1',
		passive_checks_enabled => '1',
		parallelize_check => '1',
		obsess_over_service => '1',
		check_freshness => '0',
		notifications_enabled => '1',
		event_handler_enabled => '1',
		flap_detection_enabled => '1',
		failure_prediction_enabled => '1',
		process_perf_data => '1',
		retain_status_information => '1',
		retain_nonstatus_information => '1',
		is_volatile => '0',
		check_period => '24x7',
		normal_check_interval => '5',
		retry_check_interval => '1',
		max_check_attempts => '3',
		notification_period => '24x7',
		notification_options => 'w,u,c,r,f',
		notification_interval => '30',
		contact_groups => 'sysadmins',
		register => '0',
		notify => Exec['fix-file-permissions'],
	}

	nagios_contact { 'generic-contact-sysadmin':
		target => '/etc/nagios3/conf.d/ppt_genericcontacts.cfg',
		service_notifications_enabled => '1',
		host_notifications_enabled => '1',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r,f',
		host_notification_options => 'd,u,r,f,s',
		service_notification_commands => 'notify-service-by-email, notify-service-by-whatsapp',
		host_notification_commands => 'notify-host-by-email, notify-host-by-whatsapp',
		notify => Exec['fix-file-permissions'],
		register => '0',
	}	

	nagios_hostgroup { 'generic-hostgroup':
		target => '/etc/nagios3/conf.d/ppt_generichostgroups.cfg',
		register => 0,
		notify => Exec['fix-file-permissions'],
	}

	#### END GENERIC DEFINITIONS ####

	#### CONTACT AND CONTACT GROUP DEFINITIONS ####

	nagios_contact { 'fostt2':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Thomas Foster',
		email => '11fostth@gmail.com',
		pager => '64273756740',
		use => 'generic-contact-sysadmin',
	}

	nagios_contact { 'stewasc3':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Samuel Stewart',
		email => 'stewasc3@student.op.ac.nz',
		pager => '64275651111',
		use => 'generic-contact-sysadmin'
	}

	nagios_contactgroup { 'sysadmins':
		target => '/etc/nagios3/conf.d/ppt_contactgroups.cfg',
		alias => 'System Administrators',
		members => 'fostt2, stewasc3',
		notify => Exec['fix-file-permissions'],
	}

	#### END CONTACT AND CONTACT GROUP DEFINITIONS ####

	#### HOST AND HOST GROUP DEFINITIONS ####

	nagios_host { 'db.sqrawler.com':
                 target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
                 alias => 'db',
                 address => '10.25.1.46',
		 use => generic-host
	}

	nagios_host { 'storage.sqrawler.com':
                 target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
                 alias => 'storage',
                 address => '10.25.1.42',
		 use => generic-host
	}

	nagios_host { 'app.sqrawler.com':
                 target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
                 alias => 'app',
                 address => '10.25.1.44',
		 use => generic-host
	}

	nagios_host { 'mgmt.sqrawler.com':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'mgmt',
		address => '127.0.0.1',
		use => generic-host
	}

	nagios_host { 'ad.sqrawler.com':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'ad',
		address => '10.25.1.45',
		use => generic-host
	}

	nagios_hostgroup { 'db-servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Database Servers',
		members => 'db.sqrawler.com',
		use => generic-hostgroup
	}

	nagios_hostgroup { 'windows-servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Windows Servers',
		members => 'ad.sqrawler.com',
		use => generic-hostgroup
	}

	nagios_hostgroup { 'debian-servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Debian Servers',
		members => 'mgmt.sqrawler.com, app.sqrawler.com, storage.sqrawler.com, db.sqrawler.com',
		use => generic-hostgroup
	}

	nagios_hostgroup { 'ssh-servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'SSH Servers',
		members => 'app.sqrawler.com, db.sqrawler.com, mgmt.sqrawler.com, storage.sqrawler.com',
		use => generic-hostgroup
	}

	nagios_hostgroup { 'http-servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'HTTP Servers',
		members => 'mgmt.sqrawler.com, app.sqrawler.com',
		use => generic-hostgroup
	}

	#### END HOST AND HOST GROUP DEFINITIONS ####

	#### REMOTE ACCESSIBLE SERVICE DEFINITIONS ####
	
	nagios_service { 'OwnCloud HTTP':
		service_description => 'Own Cloud',
		check_command => 'check_http_owncloud',
		host_name => 'app.sqrawler.com',
		target => '/etc/nagios3/conf.d/ppt_owncloud_service.cfg',
		use => generic-service,
		notify => Exec['fix-file-permissions'],
	}

	nagios_service { 'SSH':
		service_description => 'SSH',
		check_command => 'check_ssh',
		hostgroup_name => 'ssh-servers',
		target => '/etc/nagios3/conf.d/ppt_ssh_service.cfg',
		use => generic-service,
	}

	nagios_service { 'HTTP':
		service_description => 'HTTP',
		check_command => 'check_http',
		hostgroup_name => 'http-servers',
		target => '/etc/nagios3/conf.d/ppt_http_service.cfg',
		use => generic-service,
	}

	nagios_service { 'MySQL':
              service_description => 'MySQL DB',
              hostgroup_name => 'db-servers',
              target => '/etc/nagios3/conf.d/ppt_mysql_service.cfg',
              check_command => 'check_mysql_cmdlinecred!$USER3$!$USER4$',
	      use => generic-service
	}

	#### END REMOTE ACCESSIBLE SERVICE DEFINITIONS ####

	#### NRPE SERVICE DEFINITIONS ####
	# NOTE: mgmt also hasruns nrpe-server, so checks only need to be defined once.
	# (no localhost disk and nrpe disk check for example)

	nagios_service { 'DiskSpace':
		service_description => 'Disk Space',
		hostgroup_name => 'debian-servers',
		target => '/etc/nagios3/conf.d/ppt_diskspace_service.cfg',
		check_command => 'check_nrpe_1arg!check_hd',
		use => generic-service
	}

	nagios_service { 'Puppet Agent':
		service_description => 'Puppet Agent',
		hostgroup_name => 'debian-servers',
		target => '/etc/nagios3/conf.d/ppt_puppetagent_service.cfg',
		check_command => 'check_nrpe_1arg!check_puppet_agent',
		use => generic-service,
	}

	nagios_service { 'Puppet Master':
		service_description => 'Puppet Master',
		host_name => 'mgmt.sqrawler.com',
		target => '/etc/nagios3/conf.d/ppt_puppetmaster_service.cfg',
		check_command => 'check_nrpe_1arg!check_puppet_master',
		use => generic-service,
	}

	nagios_service { 'CPU Load':
		service_description => 'CPU Load',
		hostgroup_name => 'debian-servers',
		target => '/etc/nagios3/conf.d/ppt_cpuload.cfg',
		check_command => 'check_nrpe_1arg!check_load',
		use => generic-service
	}

	nagios_service { 'Process Check':
		service_description => 'Processes',
		hostgroup_name => 'debian-servers',
		target => '/etc/nagios3/conf.d/ppt_process.cfg',
		check_command => 'check_nrpe_1arg!check_procs',
		use => generic-service,
	}

	nagios_service { 'Users Check':
		service_description => 'Users',
		hostgroup_name => 'debian-servers',
		target => '/etc/nagios3/conf.d/ppt_users.cfg',
		check_command => 'check_nrpe_1arg!check_users',
		use => generic-service,
	}

	nagios_service { 'Tom Check':
		service_description => 'Tom Finder',
		hostgroup_name => 'debian-servers',
		target => '/etc/nagios3/conf.d/ppt_tomcheck_service.cfg',
		check_command => 'check_nrpe_1arg!check_tom',
		use => generic-service,
		normal_check_interval => '1',
		notify => Exec['fix-file-permissions'],
	}
	
	#### END NRPE SERVICES DEFINITIONS ####

	#### NT SERVICE DEFINITIONS ####

	nagios_service { 'NS Client Version':
		service_description => 'NSClient++ Version',
		hostgroup_name => 'windows-servers',
		check_command => 'check_nt!CLIENTVERSION',
		target => '/etc/nagios3/conf.d/ppt_nsclient.cfg',
		use => generic-service,
	}

	nagios_service { 'Windows Uptime':
		service_description => 'Uptime',
		hostgroup_name => 'windows-servers',
		check_command => 'check_nt!UPTIME',
		target => '/etc/nagios3/conf.d/ppt_winuptime.cfg',
		use => generic-service,
	}

	nagios_service { 'Windows CPU Load':
		service_description => 'CPU Load',
		hostgroup_name => 'windows-servers',
		check_command => 'check_nt!CPULOAD!-l 5,80,90',
		target => '/etc/nagios3/conf.d/ppt_wincpuload.cfg',
		use => generic-service,
	}

	nagios_service { 'Windows Mem Usage':
		service_description => 'Memory Usage',
		hostgroup_name => 'windows-servers',
		check_command => 'check_nt!MEMUSE!-w 80 -c 90',
		target => '/etc/nagios3/conf.d/ppt_winmem.cfg',
		use => generic-service,
	}

	nagios_service { 'Windows Disk Usage':
		service_description => 'Disk Space',
		hostgroup_name => 'windows-servers',
		check_command => 'check_nt!USEDDISKSPACE!-l c -w 80 -c 90',
		target => '/etc/nagios3/conf.d/ppt_windisk.cfg',
		use => generic-service,
	}
	
	#### END NT SERVICE DEFINITIONS ####

	#### LOCAL BACULA CHECKS (NOT NRPE) ####

	# Exec to fix file permissions when puppet adds a new file to nagios config
	exec { 'fix-file-permissions' :
		refreshonly => true,
		command => "/bin/chmod -R 644 /etc/nagios3/conf.d/*",
	}	
}
