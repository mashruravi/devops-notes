#! /bin/sh

### BEGIN INIT INFO
# Provides:		welcome
# Required-Start:	$all
# Required-Stop:
# Short-Description:	Display welcome message
### END INIT INFO

do_start () {
  echo 'Welcome to the machine!'
}

case "$1" in
  start)
    do_start
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    # No-op
    ;;
  status)
    echo 'We good!'
    exit $?
    ;;
  *)
    echo "Usage: $0 start|status"
    exit 3
    ;;
esac


