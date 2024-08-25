FROM instrumentisto/pure-ftpd

RUN adduser -D -h /data/anonymous -s /sbin/nologin anonymous \
    && mkdir -p /data/anonymous/shared \
    && chown -R anonymous:anonymous /data/anonymous \
    && chmod 755 /data/anonymous \
    && ln -s /data/anonymous/shared /var/lib/ftp \
    && chown -R ftp:ftp /var/lib/ftp

ENV FTP_PASSIVE_PORTS="30000 30009"
ENV FTP_MAX_CLIENTS_NO=50
ENV FTP_MAX_CLIENTS_PER_IP=8
ENV FTP_MAX_IDLE_TIME=15

COPY start.sh /start.sh

RUN chmod +x start.sh

ENTRYPOINT ["/init"]

CMD ["/start.sh"]
