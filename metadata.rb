maintainer        "Gerhard Lazu"
maintainer_email  "gerhard@lazu.co.uk"
license           "Apache 2.0"
description       "Installs and configures nginx"
version           "2.1.0"

recipe "nginx", "Installs nginx package and sets up configuration with Debian apache style with sites-enabled/sites-available"
recipe "nginx::source", "Installs nginx from source and sets up configuration with Debian apache style with sites-enabled/sites-available"
recipe "nginx::apps", "Sets up a reverse proxy for every app, regardless whether it's Ruby, node.js. For Python, nginx uses the uwsgi module."
recipe "nginx::status", "Enables nginx status on http://nginx_status"

supports "ubuntu"
supports "debian"

depends "build-essential"
depends "apt"
