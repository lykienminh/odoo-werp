# FROM ubuntu:20.04
FROM debian:bullseye-slim

# SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

# Set timezone to UTC
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dirmngr \
        fonts-noto-cjk \
        gnupg \
        libssl-dev \
        node-less \
        npm \
        python3-num2words \
        python3-pdfminer \
        python3-pip \
        python3-phonenumbers \
        python3-pyldap \
        python3-qrcode \
        python3-renderpm \
        python3-setuptools \
        python3-slugify \
        python3-vobject \
        python3-watchdog \
        python3-xlrd \
        python3-xlwt \
        libpq-dev \
        python3-dev \
        xz-utils
    # && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    # && echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - \
    # && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
    # && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# install latest postgresql-client
# RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
#     && GNUPGHOME="$(mktemp -d)" \
#     && export GNUPGHOME \
#     && repokey='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8' \
#     && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
#     && gpg --batch --armor --export "${repokey}" > /etc/apt/trusted.gpg.d/pgdg.gpg.asc \
#     && gpgconf --kill all \
#     && rm -rf "$GNUPGHOME" \
#     && apt-get update  \
#     && apt-get install --no-install-recommends -y postgresql-client \
#     && rm -f /etc/apt/sources.list.d/pgdg.list \
#     && rm -rf /var/lib/apt/lists/*

# Install rtlcss (on Debian buster)
RUN npm install -g rtlcss

RUN apt-get update -y

RUN apt-get install -y gcc build-essential

RUN apt-get install --no-install-recommends -y postgresql-client

# WORKDIR /app
COPY . .

RUN pip3 install -r requirements.txt

# # Install Odoo
# ENV ODOO_VERSION 15.0
# ARG ODOO_RELEASE=20221104
# ARG ODOO_SHA=0d374f0057f67fcece809b1c6acc3b8ad7b0c204
# RUN curl -o odoo.deb -sSL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
#     && echo "${ODOO_SHA} odoo.deb" | sha1sum -c - \
#     && apt-get update \
#     && apt-get -y install --no-install-recommends ./odoo.deb \
#     && rm -rf /var/lib/apt/lists/* odoo.deb

# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/

# Create the odoo user
RUN useradd --system --create-home --home-dir /opt/odoo --no-log-init odoo

# Set permissions and Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN chown odoo /etc/odoo/odoo.conf \
    && mkdir -p /mnt/extra-addons \
    && chown -R odoo /mnt/extra-addons
# VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services
EXPOSE 8069 8071 8072

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

COPY wait-for-psql.py /usr/local/bin/wait-for-psql.py

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
