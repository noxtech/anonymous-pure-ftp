# anonymous-pure-ftp

Dockerized Pure FTP with anonymous access.

Anonymous users will see the contents of whatever is created under an ftpuser called "shared", which must be created in the container using:

```
docker exec -it CONTAINER_ID /bin/bash
pure-pw useradd shared -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/shared
```

Other users created will work as usual, and anonymous users won't have access to the contents.

Anonymous users have no write privileges.
