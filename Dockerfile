# Base image
FROM ubuntu:22.04@sha256:4b1d0c4a2d2aaf63b37111f34eb9fa89fa1bf53dd6e4ca954d47caebca4005c2

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
    wget https://raw.github.com/hetrixtools/agent/master/hetrixtools_install.sh -P /etc/hetrixtools_dl; \
    cp etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chmod --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chown --reference=etc/hetrixtools_dl/hetrixtools_install.sh etc/hetrixtools_dl/hetrixtools_install_cp.sh; \
    chmod +x ./start.sh

ENTRYPOINT  ["/bin/bash", "./start.sh"]