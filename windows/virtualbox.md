# Create host only networks

## Create Host only adapter

1. **File > Preferences**, click on **Network** then tab **Host-only Networks**, add a Host-only network.
2. In Guest machine settings
    - Click on **Network**, them click on an Adapter #N tab.
    - Tick **Enable network adapter** if it's not ticked.
    - Attached to: **Host-only Adapter**
    - Name: choose the name of Adapter you created in step 1.

## Ubuntu Guest

1. Create static interface follow [these steps](../ubuntu/network.md#create-an-static-network-interface)
2. Make sure that Firewall on Host machine allows connection between Host and Guest
3. Static IP of Host-only Adapter usually is `192.168.56.1`.
4. Make sure that IP address of static interface on Guest machine is `192.168.56.x`, x from 2 to 255.

# Make shared folder

1. On VirtualBox, choose `Devices` > `Insert Guest Additions CD Images`
2. On VM:
- Windows Host, Ubuntu Guest
```
$ sudo mount /dev/cdrom /media/cdrom
$ cd /media/cdrom
$ sudo ./VBoxLinuxAdditions.run
```
3. On VirtualBox
- Choose VM's  `Settings` then `Shared Folder`
- Add folder with: _Folder Path_ is host path and _Folder name_ is the name we're  gonna mount on VM.
4. On VM:
```
$ sudo mkdir -p <path/on/guest/machine/>
$ sudo mount -t vboxsf <folder_name> <path/on/guest/machine/>
```