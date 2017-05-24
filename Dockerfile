FROM ipoddaribm/powerai-examples

ADD ./NAE/help.html /etc/NAE/help.html

ADD ./install.tar /usr/local

COPY ./.bashrc /etc/skel/.bashrc

#add NIMBIX application
COPY AppDef.json /etc/NAE/AppDef.json
COPY ./jupyterhub_config.py /usr/local/jupyterhub_config.py



RUN /usr/bin/wget  https://s3.amazonaws.com/yb-lab-cfg/admin/yb-admin.NIMBIX.ppc64le.tar
##Untar user management executables into /usr/bin directory
RUN tar xvf yb-admin.NIMBIX.ppc64le.tar -C /usr/bin
RUN apt-get install -y tcl
RUN apt-get install -y git



