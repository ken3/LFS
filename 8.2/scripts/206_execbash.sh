
# To remove the ��I have no name!�� prompt, start a new shell. Since a full
# Glibc was installed in Chapter 5 and the /etc/passwd and /etc/group files
# have been created, user name and group name resolution will now work:
exec /tools/bin/bash --login +h $*

