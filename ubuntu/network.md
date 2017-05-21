# Create an static network interface

1. Edit file `/etc/network/interfaces`

    ```
    # Host-only interface  
     auto eth1  
     iface eth1 inet static  
             address         192.168.56.56  
             netmask         255.255.255.0  
             network         192.168.56.0  
             broadcast       192.168.56.255
    ```

    with: eth1 is the interface that you want to set as static.  
2. Restart network: `/etc/init.d/networking restart` or `ifdown eth0 && ifup eth0`  
3. Reboot machine `reboot`  