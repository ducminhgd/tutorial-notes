# Create Connection to Microsoft SQL Server

## Install packages

```shell
sudo apt-get install -y unixodbc
sudo apt-get install -y unixodbc-dev
sudo apt-get install -y freetds-dev
sudo apt-get install -y freetds-bin
sudo apt-get install -y tdsodbc
```

## Edit configuration files

Add new server information into `/etc/freetds/freetds.conf` file

```shell
# /etc/freetds/freetds.conf
...
[MSSQLDev]
        host = 192.168.56.101
        port = 1433
        tds version = 7.0
```

Add `/etc/odbc.ini` file

```shell
# /etc/odbc.ini
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so
```
