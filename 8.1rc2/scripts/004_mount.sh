#!/bin/bash

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"     != "" ] || exit 2
[ "$ROOTDEV" != "" ] || exit 2

mount $ROOTDEV $LFS

