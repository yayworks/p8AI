FROM ipoddaribm/powerai-examples

ADD ./NAE/help.html /etc/NAE/help.html

ADD ./install.tar /usr/local

COPY ./.bashrc /etc/skel/.bashrc

#add NIMBIX application
COPY AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

COPY ./jupyterhub_config.py /usr/local/jupyterhub_config.py



RUN /usr/bin/wget  https://s3.amazonaws.com/yb-lab-cfg/admin/yb-admin.NIMBIX.ppc64le.tar
##Untar user management executables into /usr/bin directory
RUN tar xvf yb-admin.NIMBIX.ppc64le.tar -C /usr/bin
RUN apt-get install -y tcl
RUN apt-get install -y git

RUN echo 'export PATH=/usr/local/node/bin:/usr/local/cuda/bin:/opt/ibm/xlC/13.1.5/bin:/opt/ibm/xlf/15.1.5/bin:$PATH' >> .bashrc
RUN echo 'export PATH=/usr/local/node/bin:/usr/local/cuda/bin:/opt/ibm/xlC/13.1.5/bin:/opt/ibm/xlf/15.1.5/bin:$PATH' >> /etc/bash.bashrc
RUN export PATH=/usr/local/node/bin:/usr/local/cuda/bin:/opt/ibm/xlC/13.1.5/bin:/opt/ibm/xlf/15.1.5/bin:$PATH

##Set up login-based access to the system
RUN sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN sudo service ssh restart

WORKDIR /home/nimbix
RUN mkdir wetty

WORKDIR /home/nimbix/wetty

##Programmatically create self-signed certificates
RUN /usr/bin/yb-gencert yay
##Install IBM XL Community Edition C/C++ & Fortran compilers

RUN wget -q http://public.dhe.ibm.com/software/server/POWER/Linux/xl-compiler/eval/ppc64le/ubuntu/public.gpg -O- | sudo apt-key add -
RUN echo "deb http://public.dhe.ibm.com/software/server/POWER/Linux/xl-compiler/eval/ppc64le/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/ibm-xl-compiler-eval.list
RUN sudo apt-get update
#
RUN sudo apt-get install -y xlc.13.1.5
#
RUN sudo /opt/ibm/xlC/13.1.5/bin/xlc_configure <<EOF
1
EOF

RUN sudo apt-get install -y xlf.15.1.5

RUN sudo /opt/ibm/xlf/15.1.5/bin/xlf_configure <<EOF
1
EOF



