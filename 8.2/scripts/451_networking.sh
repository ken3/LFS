
# Linux From Scratch Version 8.2
# Chapter 7. System Configuration

[ `whoami` == root ] || exit 1
[ -d /scripts ]      || exit 2

# 7.4.1.2. Creating Custom Udev Rules
bash /lib/udev/init-net-rules.sh
cat /etc/udev/rules.d/70-persistent-net.rules

# 7.5.1. Creating Network Interface Configuration Files
cd /etc/sysconfig/
cat > ifconfig.eth0 << "EOF"
ONBOOT=yes
IFACE=eth0
SERVICE=ipv4-static
IP=192.168.120.100
GATEWAY=192.168.120.20
PREFIX=24
BROADCAST=192.168.120.255
EOF

# 7.5.2. Creating the /etc/resolv.conf File
cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf
#domain <Your Domain Name>
#nameserver <IP address of your primary nameserver>
#nameserver <IP address of your secondary nameserver>
# End /etc/resolv.conf
EOF

# 7.5.3. Configuring the system hostname
echo "LFS82" > /etc/hostname

# 7.5.4. Customizing the /etc/hosts File
cat > /etc/hosts << "EOF"
# Begin /etc/hosts
127.0.0.1        localhost
192.168.120.100  LFS82

192.168.120.20   pickc743    gateway
# End /etc/hosts
EOF

