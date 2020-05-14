# initd

`init` is the first process run by the scheduler after booting. It has a process ID of 1, and a parent process ID of 0 (referring to the kernel scheduler).

![PID and PPID of init process](images/init_ps.png)

This process is then responsible for starting all the other services and processes in the system.

The `init` system defines 7 *runlevels*. Each runlevel describe a particular state that the system can be in. Some runlevels are reserved, whereas a Linux distribution has the freedom of choosing what other runlevels mean. For example, CentOS 6 has the following runlevels:

| **Runlevel** | **Reserved** | **Description**                                              |
| ------------ | ------------ | ------------------------------------------------------------ |
| 0            | Yes          | Halt/Shutdown                                                |
| s/S/1        | Yes          | Single User Mode                                             |
| 6            | Yes          | Reboot                                                       |
| 2            | No           | Multi-user mode, with text-based console, without networking services |
| 3            | No           | Multi-user mode, with text-based console, with network connection |
| 4            | No           | Undefined                                                    |
| 5            | No           | Multi-user mode, with graphical desktop environment, with network connection |



The first thing `init` does, is read the default runlevel the system needs to be in after booting from the `/etc/inittab` file. This file will contain a line that looks like this:

```
id:5:initdefault:
```

This line tells the `init` process to put the system in runlevel 5 when it starts up.

You can see the current runlevel of a system using `runlevel` or `who -r`. These commands read the current runlevel from the `/var/run/utmp` file.

```shell
$ who -r
	run-level 5 2020-05-02 18:47
```

This tells us that the system is running on runlevel 5, and we can also see the date and time when the system was put in this runlevel.

```shell
$ runlevel
N 5
```

This tells us that the system is running on runlevel 5, and it was previously not in any recognizable runlevel (i.e. the system booted up into runlevel 5 directly).



You can change the runlevel the system is running in using the `/sbin/telinit` command.



## SysVInit Scripts

These live in the `/etc/init.d` directly, and are also known as "services".

Every script begins with an LSB (Linux Standard Base) Stanza:

```bash
### BEGIN INIT INFO
# Provides:          scriptname
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.
#					 This description can span multiple lines.
### END INIT INFO
```

* Provides - facilities provided by the script. Used to know which facilities are present (when script is run with start command), and which are no longer present (when script is run with stop command). These facilities can be required by other scripts using the names given here.
* Required-Start - facilities which must be available before this service can start.
* Required-Stop - facilities which must be available before this service can stop.
* Should-Start - facilities which, if present, should be available during start of this service.
* Should-Stop - facilities which, if present, should be available during stop of this service.
* Default-Start - which run levels should run this script by default with start argument.
* Default-Stop - which run levels should run this script by default with stop argument.
* Short-Description - single line, brief description of service.
* Description - multiline description of service.



Scripts accept a single argument which can be one of the following:

* start - start the service
* stop - stop the service
* restart - stop and restart the service if already running, otherwise start the service
* try-restart (optional) - restart the service if already running
* reload (optional) - reload configuration of the service without restarting it
* force-reload - reload configuration if service supports this, otherwise restart service if it is running
* status - print the current status of the service.



The status action should return one of the following exit status codes:

* 0 - program is running/service is OK
* 1 - program is dead and `/var/run` pid file exists
* 2 - program is dead and `/var/run` lock file exists
* 3 - program is not running
* 4 - program or service status is unknown

Other status codes (from 5 - 254) are reserved.



Example of init script body:

```shell
case "$1" in
	start)
		do_start
		;;
	stop)
		# No-op
		;;
	...
esac
```



To add your own init scripts, create one with the structure above and follow these steps:

* Put the script in the `/etc/init.d` directory
* Create links in the rc* directories using one of these methods
  * Using `chkconfig`
  * Using `update-rc.d`
  * Manually



### chkconfig

`sudo chkconfig` - see all services managed by `chkconfig` and which run levels they are auto-started on.

`sudo chkconfig --list ntpd` - get details of only the service called `ntpd`.

`sudo chkconfig ntpd on` - enable auto-start on default run levels (from LSB stanza in init script)

`sudo chkconfig ntpd off` - disable auto-start.

`sudo chkconfig --level 3 ntpd on` - enable auto-start only at run level 3 (ignore LSB stanza metadata).

`sudo chkconfig --level 3 ntpd off` - disable auto-start only at run level 3.



### update-rc.d

`service --status-all` - list status of all services.

`sudo update-rc.d ntp defaults` - enable at default run levels.

`sudo update-rc.d -f ntp remove` - remove at default run levels.




## Sources

- [ComputerNetworkingNotes - Difference between SysVinit, Upstart and Systemd (Accessed 29 April 2020)](https://www.computernetworkingnotes.com/linux-tutorials/differences-between-sysvinit-upstart-and-systemd.html)
- Linux Kernel and System Startup (LPIC-2) by Andrew Mallet - Pluralsight
- https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/initscrcomconv.html
