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

echo "Configuring this system as a Basic Yaybench POWER8/GPU Lab..."

##Set up login-based access to the system
RUN sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN sudo service ssh restart

cd /home/nimbix
RUN mkdir wetty

cd wetty

##Programmatically create self-signed certificates
RUN /usr/bin/yb-gencert yay



