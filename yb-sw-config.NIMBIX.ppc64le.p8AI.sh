#!/bin/bash
#################################################################################################
#                                                                                               #
# yb--sw-config.NIMBIX.ppc64le.p8AI.sh - Software installs & configuration for PowerAI GPU Lab  #
#                                                                                               #
# Copyright (C) 2017 Yayworks, Inc. - All Rights Reserved                                       #
#                                                                                               #
# Last revised 06/03/2017                                                                       #
#                                                                                               #
#################################################################################################
        display_usage() {
                echo "Run this script as ssh_user from /home/ssh_user directory"
                echo "Install nodejs SDK in /usr/local/node"
                }
#### NOTE: This file is to be used for Docker image creation
#### After the instantiation of Docker image, yw-config....sh needs to be run for env coonfig
#################################################################################################

sudo /opt/ibm/xlC/13.1.5/bin/xlc_configure <<EOF
1
EOF
#
sudo /opt/ibm/xlf/15.1.5/bin/xlf_configure <<EOF
1
EOF

wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-ppc64le.sh

(
bash Anaconda3-4.4.0-Linux-ppc64le.sh  <<EOF

yes

yes
EOF

) > com.out

rm com.out

conda create -n tensorflow python=3.5 <<EOF
y
EOF

source activate tensorflow

conda install -c conda-forge tensorflow <<EOF
y
EOF


exit 0


