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
| 2            | No           | Multi-user mode, with text-based console, without network connection |
| 3            | No           | Multi-user mode, with text-based console, with network connection |
| 4            | No           | Undefined                                                    |
| 5            | No           | Multi-user mode, with graphical desktop environment, with network connection |



The first thing `init` does, is read the default runlevel the system needs to be in after booting from the `/etc/inittab` file.

You can see the current runlevel of a system using `runlevel`.



## Sources

- [ComputerNetworkingNotes - Difference between SysVinit, Upstart and Systemd (Accessed 29 April 2020)](https://www.computernetworkingnotes.com/linux-tutorials/differences-between-sysvinit-upstart-and-systemd.html)

