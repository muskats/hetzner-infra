#cloud-config
users:
  - name: admin
    gecos: Admin User
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
    ssh_authorized_keys:
      - ${ssh_public_key}    # if templating; otherwise the module can write the file

package_update: true
package_upgrade: true
packages:
  - curl
  - ca-certificates
  - unattended-upgrades
  - ufw
  - fail2ban

write_files:
  - path: /etc/sysctl.d/99-custom.conf
    content: |
      net.ipv4.ip_forward=0
      net.ipv4.conf.all.forwarding=0
runcmd:
  - [ sh, -c, "ufw default deny incoming" ]
  - [ sh, -c, "ufw allow ssh" ]
  - [ sh, -c, "ufw --force enable" ]
  - [ sh, -c, "systemctl enable --now unattended-upgrades" ]
