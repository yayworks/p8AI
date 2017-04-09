FROM ipoddaribm/powerai-examples

ADD ./NAE/help.html /etc/NAE/help.html

ADD ./install.tar /usr/local

COPY ./.bashrc /etc/skel/.bashrc

#add NIMBIX application
COPY AppDef.json /etc/NAE/AppDef.json
COPY ./jupyterhub_config.py /usr/local/jupyterhub_config.py

WORKDIR /home/nimbix
USER nimbix

RUN /usr/local/install_test.sh


