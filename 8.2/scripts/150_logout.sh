#!/bin/bash

[ `/usr/bin/whoami` == lfs  ] || exit 2

echo "Logout lfs user, and return to root shell."

