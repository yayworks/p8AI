
#!/bin/bash
#source /opt/DL/openblas/bin/openblas-activate
#source /opt/DL/tensorflow/bin/tensorflow-activate
#source /opt/DL/digits/bin/digits-activate

export PYTHONPATH=/root/anaconda3/envs/tensorflow/lib/python3.6/site-packages/
source /root/anaconda3/bin/activate tensorflow
cd /var/www/data/admin/files

/root/anaconda3/bin/jupyter  notebook --ip=0.0.0.0 --port=$1 --allow-root  &
