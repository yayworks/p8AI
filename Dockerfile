FROM ipoddaribm/powerai-examples

ADD ./NAE/help.html /etc/NAE/help.html

ADD ./install.tar /usr/local

WORKDIR /home/nimbix
RUN /bin/bash -c "/usr/local/install.sh"

COPY ./.bashrc /etc/skel/.bashrc

#add NIMBIX application
COPY AppDef.json /etc/NAE/AppDef.json

