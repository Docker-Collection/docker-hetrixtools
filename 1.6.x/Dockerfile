# Base image
FROM ubuntu:22.04@sha256:1b8d8ff4777f36f19bfe73ee4df61e3a0b789caeff29caa019539ec7c9a57f95

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