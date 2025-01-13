#cloud-config
users:
  - name: {{ admin_username }}
    primary_group: {{ admin_username }}
    ssh-authorized-keys:
{% for key in do_ssh_keys %}
      - {{ key }}
{% endfor %}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash
write_files:
  - path: /etc/ssh/sshd_config
    content: |
         Port 22
         Protocol 2
         HostKey /etc/ssh/ssh_host_rsa_key
         HostKey /etc/ssh/ssh_host_dsa_key
         HostKey /etc/ssh/ssh_host_ecdsa_key
         HostKey /etc/ssh/ssh_host_ed25519_key
         SyslogFacility AUTH
         LogLevel INFO
         LoginGraceTime 120
         PermitRootLogin no
         PasswordAuthentication no
         StrictModes yes
         PubkeyAuthentication yes
         IgnoreRhosts yes
         HostbasedAuthentication no
         PermitEmptyPasswords no
         ChallengeResponseAuthentication no
         X11Forwarding yes
         X11DisplayOffset 10
         PrintMotd no
         PrintLastLog yes
         TCPKeepAlive yes
         AcceptEnv LANG LC_*
         Subsystem sftp /usr/lib/openssh/sftp-server
         UsePAM yes
         AllowUsers {{ admin_username }}