FROM instrumentisto/pure-ftpd:noxtech

RUN mkdir -p /etc/pure-ftpd \
    && mv /etc/pure-ftpd.conf /etc/pure-ftpd/pure-ftpd.conf

RUN mkdir -p /data/shared \
    && mkdir -p /data/virtualusers \
    && adduser -D -u 101 -g 91 -h /data/virtualusers -s /sbin/nologin virtualusers
#    && echo hi

ENV FTP_PASSIVE_PORTS="30000 30009" \
    FTP_MAX_CLIENTS_NO=50 \
    FTP_MAX_CLIENTS_PER_IP=8 \
    FTP_MAX_IDLE_TIME=15 \
    PER_USER_LIMITS=3:20 \
    PURE_PASSWDFILE=/etc/pure-ftpd/pureftpd.passwd \
    PURE_DBFILE=/etc/pure-ftpd/pureftpd.pdb

COPY start.sh / \
    set-permissions.sh /
RUN chmod +x start.sh \
    && chmod +x set-permissions.sh \
# update properties
    && sed -i "s/^#\sPureDB\s*\/etc\/pureftpd.pdb/PureDB \/etc\/pure-ftpd\/pureftpd.pdb/" "/etc/pure-ftpd/pure-ftpd.conf" \
    && sed -i "s/^MinUID.*/MinUID 90/" "/etc/pure-ftpd/pure-ftpd.conf" \
# setup pureftpd user db
    && touch /etc/pure-ftpd/pureftpd.passwd \
    && pure-pw mkdb

VOLUME ["/data", "/etc/pure-ftpd"]

ENTRYPOINT ["/init"]

CMD ["/start.sh"]
