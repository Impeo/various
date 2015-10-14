## Server template for ifyna-server instances


Do all following steps as root (unless statded otherwise). Change 'ifyna-example' and 'example' to any suitable unique name. 

### Application User

* create a user for server instance

```
useradd ifyna-example --gid users --shell /bin/bash --create-home
```
  
* become user and be sure to be in home dir

```
su - ifyna-example
```

### Checkout template
    
* as user use subversion to checkout this repo in the home dir

```
svn co https://github.com/Impeo/ifyna-server/trunk server 
```

### server.xml

* as user make sure Server and Connector ports in conf/server.xml are unique (it's good practise to choose the same ending number)

```xml
  <Server port="18001" shutdown="SHUTDOWN">
  <Connector port="8001" protocol="AJP/1.3" />    
```

### ifyna.xml (Context)

* as user make sure all paths in `conf/Catalin/localhost/ifyna.xml` are according to the installation

```xml
  <Context docBase="../warfiles/ifyna-example.war"
  <Parameter name="demoDataFolder" value="/home/ifyna-example/server/demo_daten" />
  <Parameter name="public.key" value="/home/ifyna-example/server/keys/public.key"/>
  <Parameter name="licence.file" value="/home/ifyna-example/server/conf/licence.xml"/>    
```

* if you want another context as _ifyna_ rename the file `conf/Catalin/localhost/ifyna.xml` accordingly 

### vhost config

* as user copy or rename the vhost-config file from support dir to the name of the server 

```
  cd ~/server/support/etc/apache2/sites-available
  mv ifyna-example ifyna-some-name
```

* as user change server name (for both the http and https vhosts) to the correct value 

```
  ServerName example.ifyna.net
``` 

* If you changed the context to another value as _ifyna_ change this in in the vhost config accordingly

```
  ProxyPass /ifyna ajp://127.0.0.1:8001/ifyna
``` 


* as root create a symbolic link in the apache2 config dir to the (renamed vhost-config) and restart apache

```
  cd /etc/apache2/sites-enabled
  ln -s /home/ifyna-example/server/support/etc/apache2/sites-available/ifyna-example
  apache2ctl restart
```

### tomcat start script

* as user copy or rename the tomcat start-script from support dir to the name of the server

```
  cd ~/server/support/etc/init.d
  mv tomcat-ifyna-example tomcat-ifyna-some-name
```

* as user change the name of the user to the application user of this server instance

```
   su -c "~/server/bin/tomcat.sh $1" - ifyna-example
```

* as root create a symbolic link in /etc/init.d to the (renamed) tomcat start-script and enable default runlevels

```
  cd /etc/init.d
  ln -s /home/ifyna-example/server/support/etc/init.d/tomcat-ifyna-example
  update-rc.d tomcat-ifyna-example defaults
```

* start the tomcat

```
  /etc/init.d/tomcat-ifyna-example start
```

### Finish

* you should now see the application under https://example.ifyna.net/example 

