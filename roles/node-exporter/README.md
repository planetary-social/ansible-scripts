# Node Exporter role

Installs [the node_exporter from
prometheus](https://github.com/prometheus/node_exporter) onto the target host at
the default port 9100. It assumes the target is an ubuntu service, with systemd
and UFW for a firewall. The role uses systemd to ensure node-exporter stays
running and extends the UFW rules to allow traffic on port 9100.

# Variables

| variable              | example     | purpose                                            |
|:----------------------|:------------|:---------------------------------------------------|
| node_exporter_version | 1.6.0       | version of node_exporter to use, defaults to 1.6.0 |
| home_dir              | /home/admin | homdir of target, where files will be installed    |


