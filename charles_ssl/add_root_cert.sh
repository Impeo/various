#!/bin/bash

ROOT_CERT=/Users/thorek/Desktop/charles-ssl-proxying-certificate.crt
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home
PASSWORD=changeit # seems this is the default password for the jdk

keytool -import -alias charles -file $ROOT_CERT -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass $PASSWORD