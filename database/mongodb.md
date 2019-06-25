# MongoDB

## Install MongoDB 3.6 on Ubuntu 16.04

```shell
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo apt-get update
sudo apt-get install mongodb-org
```

## Install MongoDB Tools

MongoDB Tools contains the following MongoDB tools: mongoimport bsondump, mongodump, mongoexport, mongofiles, mongorestore, mongostat, and mongotop.

```shell
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo apt-get update
sudo apt-get install mongodb-org-tools
```

## Using `mongoexport`

> **Important:** Avoid using `mongoimport` and `mongoexport` for full instance production backups. They do not reliably preserve all rich BSON data types, because JSON can only represent a subset of the types supported by BSON. Use `mongodump` and `mongorestore` as described in MongoDB Backup Methods for this kind of functionality.

Example command:

```shell
mongoexport -h <hostname>:<port> -u <username> --db=<your_db> --collection=<your_collection> --out=<output.csv> -q '{storeId:12}' --authenticationDatabase=<your_db> --type csv --fields order,'customer.id','customer.e mail',storeId  -p <password>
```

_Note:_

- If your account, `<username>` and `<password>`, is granted for a specifice database, `<your_db>`, then `--authenticationDatabase` should be `--authenticationDatabase=<your_db>`.

## Create user

### Write

With [MongoDB 3.6](https://docs.mongodb.com/v3.6/reference/method/db.createUser/)

```javascript
use admin
db.createUser({
    user: "user-write",
    pwd: "user-write-password",
    customData: {
        createdBy: "minh.gdd"
    },
    roles: [
        {
            role: "readWrite",
            db: "dbname"
        }
    ]
})
```


### Read-only

```javascript
use admin
db.createUser({
    user: "user-read",
    pwd: "user-read-password",
    customData: {
        createdBy: "minh.gdd"
    },
    roles: [
        {
            role: "read",
            db: "dbname"
        }
    ]
})
```