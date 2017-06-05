#!/bin/bash
#################################################################################################
#                                                                                               #
# yb-nimbix-config.NIMBIX.ppc64le.p8AI.sh - Software installs & configuration for PowerAI GPU Lab  #
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

wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-ppc64le.sh

(
bash Anaconda3-4.4.0-Linux-ppc64le.sh  <<EOF

yes

yes
EOF

) > com.out

rm com.out

source /home/nimbix/.bashrc

###This didn't work
/home/nimbix/anaconda3/bin/conda create -n tensorflow python=3.6 <<EOF
y
EOF

source /home/nimbix/anaconda3/bin/activate tensorflow

/home/nimbix/anaconda3/bin/conda install -c conda-forge tensorflow <<EOF
y
EOF

echo 'export PYTHONPATH=/home/nimbix/anaconda3/envs/tensorflow/lib/python3.6/site-packages/' >> /home/nimbix/.bashrc

source /home/nimbix/.bashrc


exit 0


