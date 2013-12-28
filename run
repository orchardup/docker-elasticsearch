#!/bin/sh
#
# /etc/init.d/elasticsearch -- startup script for Elasticsearch
#
# Written by Miquel van Smoorenburg <miquels@cistron.nl>.
# Modified for Debian GNU/Linux by Ian Murdock <imurdock@gnu.ai.mit.edu>.
# Modified for Tomcat by Stefan Gybas <sgybas@debian.org>.
# Modified for Tomcat6 by Thierry Carrez <thierry.carrez@ubuntu.com>.
# Additional improvements by Jason Brittain <jason.brittain@mulesoft.com>.
# Modified by Nicolas Huray for ElasticSearch <nicolas.huray@gmail.com>.
#
### BEGIN INIT INFO
# Provides:          elasticsearch
# Required-Start:    $network $remote_fs $named
# Required-Stop:     $network $remote_fs $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts elasticsearch
# Description:       Starts elasticsearch using start-stop-daemon
### END INIT INFO

PATH=/bin:/usr/bin:/sbin:/usr/sbin
NAME=elasticsearch
DESC="ElasticSearch Server"
DEFAULT=/etc/default/$NAME

if [ `id -u` -ne 0 ]; then
    echo "You need root privileges to run this script"
    exit 1
fi


. /lib/lsb/init-functions

if [ -r /etc/default/rcS ]; then
    . /etc/default/rcS
fi


# The following variables can be overwritten in $DEFAULT

# Run ElasticSearch as this user ID and group ID
ES_USER=elasticsearch
ES_GROUP=elasticsearch

# The first existing directory is used for JAVA_HOME (if JAVA_HOME is not defined in $DEFAULT)
JDK_DIRS="/usr/lib/jvm/java-7-oracle /usr/lib/jvm/java-7-openjdk /usr/lib/jvm/java-7-openjdk-amd64/ /usr/lib/jvm/java-7-openjdk-armhf /usr/lib/jvm/java-7-openjdk-i386/ /usr/lib/jvm/java-6-sun /usr/lib/jvm/java-6-openjdk /usr/lib/jvm/java-6-openjdk-amd64 /usr/lib/jvm/java-6-openjdk-armhf /usr/lib/jvm/java-6-openjdk-i386 /usr/lib/jvm/default-java"

# Look for the right JVM to use
for jdir in $JDK_DIRS; do
    if [ -r "$jdir/bin/java" -a -z "${JAVA_HOME}" ]; then
        JAVA_HOME="$jdir"
    fi
done
export JAVA_HOME

# Directory where the ElasticSearch binary distribution resides
ES_HOME=/usr/share/$NAME

# Heap Size (defaults to 256m min, 1g max)
#ES_HEAP_SIZE=2g

# Heap new generation
#ES_HEAP_NEWSIZE=

# max direct memory
#ES_DIRECT_SIZE=

# Additional Java OPTS
#ES_JAVA_OPTS=

# ElasticSearch log directory
LOG_DIR=/var/log/$NAME

# ElasticSearch data directory
DATA_DIR=/var/lib/$NAME

# ElasticSearch work directory
WORK_DIR=/tmp/$NAME

# ElasticSearch configuration directory
CONF_DIR=/etc/$NAME

# ElasticSearch configuration file (elasticsearch.yml)
CONF_FILE=$CONF_DIR/elasticsearch.yml

# Maximum number of VMA (Virtual Memory Areas) a process can own
MAX_MAP_COUNT=65535

# End of variables that can be overwritten in $DEFAULT

# overwrite settings from default file
if [ -f "$DEFAULT" ]; then
    . "$DEFAULT"
fi

# Define other required variables
PID_FILE=/var/run/$NAME.pid
DAEMON=$ES_HOME/bin/elasticsearch
DAEMON_OPTS="-p $PID_FILE -Des.default.config=$CONF_FILE -Des.default.path.home=$ES_HOME -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR"

export ES_HEAP_SIZE
export ES_HEAP_NEWSIZE
export ES_DIRECT_SIZE
export ES_JAVA_OPTS

# Check DAEMON exists
test -x $DAEMON || exit 0

checkJava() {
    if [ -x "$JAVA_HOME/bin/java" ]; then
        JAVA="$JAVA_HOME/bin/java"
    else
        JAVA=`which java`
    fi

    if [ ! -x "$JAVA" ]; then
        echo "Could not find any executable java binary. Please install java in your PATH or set JAVA_HOME"
        exit 1
    fi
}

checkJava

log_daemon_msg "Starting $DESC"

pid=`pidofproc -p $PID_FILE elasticsearch`
if [ -n "$pid" ] ; then
    log_begin_msg "Already running."
    log_end_msg 0
    exit 0
fi

# Prepare environment
mkdir -p "$LOG_DIR" "$DATA_DIR" "$WORK_DIR" && chown "$ES_USER":"$ES_GROUP" "$LOG_DIR" "$DATA_DIR" "$WORK_DIR"
touch "$PID_FILE" && chown "$ES_USER":"$ES_GROUP" "$PID_FILE"

if [ -n "$MAX_MAP_COUNT" ]; then
    sysctl -q -w vm.max_map_count=$MAX_MAP_COUNT
fi

# Start Daemon
exec sudo -u $ES_USER $DAEMON -f $DAEMON_OPTS
