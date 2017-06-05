
#!/bin/bash
#source /opt/DL/openblas/bin/openblas-activate
#source /opt/DL/tensorflow/bin/tensorflow-activate
#source /opt/DL/digits/bin/digits-activate
source /root/anaconda3/bin/activate tensorflow
cd /opt/DL/Tensorflow-Tutorials

jupyter notebook --ip=0.0.0.0 --port=$1 --allow-root &
