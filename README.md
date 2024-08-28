# anonymous-pure-ftp

Dockerized Pure FTP with anonymous access.

Anonymous users will see the contents of whatever is within `/data/shared` and can upload.

Other users created will work as usual, and anonymous users won't have access to the contents.

## Saving the user database

If starting for the first time:

1. bind a volume from a non-existent directory on the host to the container (e.g. /tmp/pure-ftpd)
2. exec into the container then copy the contents of /etc/pure-ftpd/ to the temporary directory
3. rebind the volume from the now populated directory on the host to the container at /etc/pure-ftpd/

## Creating users

### Super user
To create a "super user" who can CRUD files across the shared and virtualusers:

```
host      $ docker exec -it CONTAINER_ID /bin/bash
container $ pure-pw useradd <username> -u 101 -g 91 -D /data -m
```

### Standard user
To create a "standard user" who can only CRUD files into their own folder:

```
host      $ docker exec -it CONTAINER_ID /bin/bash
container $ export username=<username> \
              && pure-pw useradd $username -u 101 -g 91 -d /data/virtualusers/$username -m \
              && mkdir -p /data/virtualusers/$username \
              && chown 101 /data/virtualusers/$username \
              && chgrp 91 /data/virtualusers/$username
```

## Notes

I've also added a set-permissions.sh script to the container to set the appropriate permissions on the /data/shared and /data/virtualusers directories.

This is so that when a host folder is bind mounted to the container, it overwrites the host permissions and ownership.
