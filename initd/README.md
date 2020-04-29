# initd

`init` is the first process run by the scheduler after booting. It has a process ID of 1, and a parent process ID of 0 (referring to the kernel scheduler).

![PID and PPID of init process](images/init_ps.png)

This process is then responsible for starting all the other services and processes in the system.





## Sources

- [ComputerNetworkingNotes - Difference between SysVinit, Upstart and Systemd (Accessed 29 April 2020)](https://www.computernetworkingnotes.com/linux-tutorials/differences-between-sysvinit-upstart-and-systemd.html)

