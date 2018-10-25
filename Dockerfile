FROM debian:stable

RUN apt-get update && apt-get install -y \
    vpnc \
    openssh-client \
    rsync \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /
RUN mkdir /root/.ssh \
 && chmod 700 /root/.ssh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["ssh"]
