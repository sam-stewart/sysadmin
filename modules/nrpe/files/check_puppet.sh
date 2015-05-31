#! /bin/sh
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
# 
#   
#	Author:		Przemyslaw Hejman	blindroot.pl
#	Copyright: 	TouK 2013 

#	Nagios Plugin to monitor the status of Puppet installation

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# Nagios return codes
OK_STATE=0
WARNING_STATE=1
CRITICAL_STATE=2
UNKNOWN_STATE=3

get_puppetservice_state() {
	. /lib/lsb/init-functions
	DAEMON=/usr/bin/puppet
	test -x $DAEMON || exit $UNKNOWN_STATE
	NAME="$1"
	DESC="$2"
	if [ "$1" != puppetdb ]; then
		PIDFILE="/var/run/puppet/${NAME}.pid"
	else
		PIDFILE="/var/run/${NAME}.pid"
	fi
	if (type status_of_proc > /dev/null 2>&1) ; then
		if [ "$1" != puppetdb ] ; then	
        		status_of_proc -p "${PIDFILE}" "${DAEMON}" "${NAME}" 	>/dev/null 2>&1
		else
			status_of_proc -p $PIDFILE "$JAVA_BIN" "$NAME" >/dev/null 2>&1
		fi
		status="$?"	
            	if [ "$status" = 0 ] ; then
			read pid < "${PIDFILE}"
			echo "OK - $DESC is up and running! (pid=$pid)"
			exit $OK_STATE
		else
                	echo "CRITICAL - $DESC is not running!"
			exit $CRITICAL_STATE
		fi
	fi


}


print_usage()
{
echo "Usage: ./check_puppet [-maqdh]"
echo ""
echo "List of available options:"
echo ""
echo " 	-m | --master 		Display Puppet Master status "
echo "	-a | --agent 		Display Puppet Agent status "
echo " 	-q | --queue		Display Puppet Queue service status "
echo " 	-d | --puppetdb 	Display PuppetDB service status "
echo " 	-h | --help		display help message"
echo ""
exit 0
}

if [ -z "$1" ]; then
 	print_usage
  	exit $UNKNOWN_STATE
fi

while [ $# -gt 0 ]
do
	case "$1" in
	-h | --help)
	print_usage
	exit $OK_STATE
	;;
	-m | --master)
	NAME=master
	DESC="Puppet Master"
	get_puppetservice_state $NAME "$DESC"
	;;
	-a | --agent)
	NAME=agent
	DESC="Puppet Agent"
	get_puppetservice_state $NAME "$DESC"
	;;
	-q | --queue)
	NAME=queue
	DESC="Puppet Queue"
	get_puppetservice_state $NAME "$DESC"
	;;
	-d | --puppetdb)
	NAME=puppetdb
	DESC="PuppetDB"
	get_puppetservice_state $NAME "$DESC"
	;;
	*) echo "Unknown argument: $1"
	exit $UNKNOWN_STATE
	;;
	esac
shift
done
