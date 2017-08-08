## Create fake shell for FTP user

* Create file `/bin/fakesh` with content as below:
```bash
#########/bin/fakesh#######

#!/bin/bash
echo -n "$ "
while read cmd ; do
    if [ "$cmd" = "exit" ]; then break; fi
    if [ "$cmd" != "" ]; then echo "The only one available command is: exit"; fi
    echo -n "$ "
done

#########################
```

* Grant read & exec permission:
```chmod +rx /bin/fakesh```

* Add `/bin/fakesh` to allowed shells for login in file `/etc/shells`

* Add param `-s /bin/fakesh` when creating user account
