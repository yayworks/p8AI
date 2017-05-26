FROM ipoddaribm/powerai-examples

ADD ./NAE/help.html /etc/NAE/help.html

WORKDIR /root
ADD startjupyter.sh /root/.startjupyter.sh 
ADD startdigits.sh  /root/.startdigits.sh
ADD starttensorboard.sh /root/.starttensorboard.sh 
ADD conf.d/* /etc/supervisor/conf.d/

ADD ./install.tar /usr/local

COPY ./.bashrc /etc/skel/.bashrc

#add NIMBIX application
COPY AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

COPY ./jupyterhub_config.py /usr/local/jupyterhub_config.py


WORKDIR /home/nimbix
RUN /usr/bin/wget https://s3.amazonaws.com/yb-lab-cfg/ibm-6.9.1.0-node-v6.9.1-linux-ppc64le.bin
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

#WORKDIR /home/nimbix
#RUN mkdir wetty

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
#RUN sudo /opt/ibm/xlC/13.1.5/bin/xlc_configure <<EOF
#1
#EOF

RUN sudo apt-get install -y xlf.15.1.5

#RUN sudo /opt/ibm/xlf/15.1.5/bin/xlf_configure <<EOF
#1
#EOF

RUN apt-get update
RUN apt-get install -y apache2 mariadb-server libapache2-mod-php7.0

RUN apt-get install -y php7.0-gd php7.0-json php7.0-mysql php7.0-curl php7.0-mbstring

RUN apt-get install -y php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip

RUN a2enmod rewrite headers env dir mime setenvif ssl

#echo "Creating a userid for cur_user and initializing the lab environment"

#sudo /usr/bin/yb-adduser $base_dir $cur_user $session_dur
#sudo /usr/bin/yb-initenv $base_dir $cur_user $lab_type
#sudo /usr/bin/yb-initlab $cur_user 

#echo "Start TensorBoard and Jupyter Notebook "

#sudo /usr/bin/yb-procdel python

#cur_user_home=/${base_dir}/${cur_user}
#sudo cp /root/starttensorboard.sh ${cur_user_home}/.starttensorboard.sh
#sudo cp /root/startdigits.sh ${cur_user_home}/.startdigits.sh
#sudo cp /root/startjupyter.sh ${cur_user_home}/.startjupyter.sh
#sudo chown -R ${cur_user}.${cur_user} $cur_user_home
##cmd="${cur_user_home}/starttensorboard.sh &"
#sudo -S -u $cur_user -i /bin/bash -l -c "${cur_user_home}/.starttensorboard.sh 8888 &"
#sudo -S -u $cur_user -i /bin/bash -l -c "${cur_user_home}/.startdigits.sh 8889 &"
#sudo -S -u $cur_user -i /bin/bash -l -c "${cur_user_home}/.startjupyter.sh 8890 &"
WORKDIR /
RUN /usr/bin/wget https://s3.amazonaws.com/yb-lab-cfg/ybcloud_v0.92.tar.gz
RUN sudo tar xfpvz ybcloud_v0.92.tar.gz

#RUN sudo /usr/bin/yb-jpytokens
#sudo /usr/bin/yb-replinfile $yc_config_file $pubDNS $repl_tag 
#sudo /usr/bin/yb-replinfile $yc_apache2_conf_file $pubDNS $repl_tag 
#RUN sudo systemctl restart mysql
#RUN sudo systemctl restart apache2



