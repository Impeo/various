#!/bin/sh

# tiny start sctipt that allows for tomcat to be started out of different directory

# default values
export NLS_LANG=GERMAN_GERMANY.WE8DEC
export LC_COLLATE=de_DE.ISO8859-1
export LC_CTYPE=de_DE.ISO8859-1
export LC_MESSAGES=C
export LC_MONETARY=de_DE.ISO8859-1
export LC_NUMERIC=de_DE.ISO8859-1
export LC_TIME=de_DE.ISO8859-1

JAVA_OPTS="-server"
JAVA_OPTS="$JAVA_OPTS -d64"
JAVA_OPTS="$JAVA_OPTS -Xbatch"
JAVA_OPTS="$JAVA_OPTS -Xloggc:/tmp/javagc.log"
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=ISO-8859-15"
JAVA_OPTS="$JAVA_OPTS -Duser.language=de"
JAVA_OPTS="$JAVA_OPTS -Duser.country=DE"
JAVA_OPTS="$JAVA_OPTS -Djava.awt.headless=true"
JAVA_OPTS="$JAVA_OPTS -Xms1G"
JAVA_OPTS="$JAVA_OPTS -Xmx2G"
JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=160m"
JAVA_OPTS="$JAVA_OPTS -XX:+UseParallelGC"
JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails"
export JAVA_OPTS

# start tomcat with this CATALINA_BASE
export CATALINA_BASE=$HOME/server
export CATALINA_PID=$CATALINA_BASE/temp/catalina.pid

# adjust to server
export JAVA_HOME="/opt/java/current"
export TOMCAT_HOME="/opt/tomcat7"

$TOMCAT_HOME/bin/catalina.sh $*
