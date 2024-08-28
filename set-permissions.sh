#!/bin/sh

# set user and group ownership
chown 101 /data/shared \
  && chgrp 91 /data/shared \
  && chown 101 /data/virtualusers \
  && chgrp 91 /data/virtualusers

# set symlink from /var/lib/ftp into /data/shared
ln -s /data/shared /var/lib/ftp

# TODO make this less hacky, this enables anonymous and virtualusers to upload here
chmod 777 /data/shared
