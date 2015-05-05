class exim
{
	file { "/etc/exim4/update-exim4.conf.conf":
		ensure => present,
		source => "puppet:///modules/exim/update-exim4.conf.conf",
		mode => 0644,
		owner => "root",
		group => "root",
	}
}
