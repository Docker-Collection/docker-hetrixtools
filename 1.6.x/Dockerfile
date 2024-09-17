# Base image
FROM ubuntu:24.04@sha256:dfc10878be8d8fc9c61cbff33166cb1d1fe44391539243703c72766894fa834a

ENV HETRIX_AGENT_PARAMS=''

# Copy start.sh script
COPY start.sh ./start.sh

# Install packages from ubuntu software repository
# wget - needed for downloading the agent
# cron - needed for scheduling agent cron job
# iproute2 - needed for ip command
# locales - UTF-8 en_US setup
# After remove apt-get clean, create directory to download agent to
# Then download agent from hetrixtools repo
# Next, copy file as the install command will delete the original file
# Last, make start.sh exectuion
RUN set -xe; \
    apt-get update; \
    apt-get install -y wget iproute2 cron locales; \
    rm -rf /var/lib/apt/lists/*; \
    apt-get clean; \
    mkdir -p /etc/hetrixtools_dl; \
    wget https://raw.githubusercontent.com/hetrixtools/agent/1.6.x/hetrixtools_install.sh -P /etc/hetrixtools_dl; \
    cp etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chmod --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chown --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chmod +x ./start.sh

ENTRYPOINT  ["/bin/bash", "./start.sh"]