# Base image
FROM ubuntu:24.04@sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061

ENV HETRIX_AGENT_PARAMS=''

# Copy start.sh script
COPY start.sh ./start.sh

# Install packages from ubuntu software repository
# wget - needed for downloading the agent
# iproute2 - needed for ip command
# cron - needed for scheduling agent cron job
# locales - UTF-8 en_US setup
# net-tools for ifconfig lookup network stats
# After remove apt list folder, using apt-clean to clean
# Make a hetrixtool download folder
# Then download agent from hetrixtools repo
# Next, copy file as the install command will delete the original file
# Last, make start.sh exectuion
RUN set -xe; \
    apt-get update; \
    apt-get install -y wget iproute2 cron locales net-tools; \
    rm -rf /var/lib/apt/lists/*; \
    apt-get clean; \
    mkdir -p /etc/hetrixtools_dl; \
    wget https://raw.githubusercontent.com/hetrixtools/agent/master/hetrixtools_install.sh -P /etc/hetrixtools_dl; \
    cp etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chmod --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chown --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chmod +x ./start.sh

ENTRYPOINT  ["/bin/bash", "./start.sh"]
