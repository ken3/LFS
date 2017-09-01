
# Linux From Scratch Version 8.1rc2
# Chapter 7. System Configuration

. buildenv
[ `whoami` == root ] || exit 2
[ -d /scripts ]      || exit 2

# 7.6.4. Configuring the System Clock
cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock
UTC=1
# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=
# End /etc/sysconfig/clock
EOF

# 7.6.5. Configuring the Linux Console
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console
KEYMAP="jp106"
FONT=""
# End /etc/sysconfig/console
EOF

# 7.7. The Bash Shell Startup Files
cat > /etc/profile << "EOF"
# Begin /etc/profile
export LANG=C
# End /etc/profile
EOF

# 7.8. Creating the /etc/inputrc File
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>
# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off
# Enable 8bit input
set meta-flag On
set input-meta On
# Turns off 8th bit stripping
set convert-meta Off
# Keep the 8th bit for display
set output-meta On
# none, visible or audible
set bell-style none
# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word
# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert
# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line
# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line
# End /etc/inputrc
EOF

# 7.9. Creating the /etc/shells File
cat > /etc/shells << "EOF"
# Begin /etc/shells
/bin/sh
/bin/bash
# End /etc/shells
EOF

# 8.2. Creating the /etc/fstab File
cat > /etc/fstab << "EOF"
# Begin /etc/fstab
# file system mount-point type options dump fsck
# order
<ROOTDEV>     /           ext4     defaults            1 1
<SWAPDEV>     swap        swap     pri=1               0 0
tmpfs         /tmp        tmpfs    defaults            0 0
tmpfs         /run        tmpfs    defaults            0 0
proc          /proc       proc     nosuid,noexec,nodev 0 0
sysfs         /sys        sysfs    nosuid,noexec,nodev 0 0
devtmpfs      /dev        devtmpfs mode=0755,nosuid    0 0
devpts        /dev/pts    devpts   gid=5,mode=620      0 0
# End /etc/fstab
EOF

# Replace <...> to real device name
ROOTDEVICE=${ROOTDEV//\//\\\/}
SWAPDEVICE=${SWAPDEV//\//\\\/}
COMMAND="-e s/<ROOTDEV>/$ROOTDEVICE/"
if [ "$SWAPDEV" == "" ]
then
    COMMAND="$COMMAND -e /<SWAPDEV>/d"
else
    COMMAND="$COMMAND -e s/<SWAPDEV>/$SWAPDEVICE/"
fi
sed -i $COMMAND /etc/fstab

