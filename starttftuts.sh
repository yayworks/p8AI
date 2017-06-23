
#!/bin/bash
#source /opt/DL/openblas/bin/openblas-activate
#source /opt/DL/tensorflow/bin/tensorflow-activate
#source /opt/DL/digits/bin/digits-activate

#/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages', '/root', '/root/anaconda3/envs/tensorflow/lib/python36.zip', '/root/anaconda3/envs/tensorflow/lib/python3.6', '/root/anaconda3/envs/tensorflow/lib/python3.6/lib-dynload', '/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/prettytensor-0.7.2-py3.6.egg', '/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/enum34-1.1.6-py3.6.egg', '/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/setuptools-27.2.0-py3.6.egg
export PYTHONPATH=/root/anaconda3/envs/tensorflow/lib/python3.6:/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/:/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/prettytensor-0.7.2-py3.6.egg:/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/enum34-1.1.6-py3.6.egg:/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/setuptools-27.2.0-py3.6.egg

source /root/anaconda3/bin/activate tensorflow
cd /opt/DL/Tensorflow-Tutorials

/root/anaconda3/bin/jupyter  notebook --ip=0.0.0.0 --port=$1 --allow-root  &
