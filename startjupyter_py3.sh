
#!/bin/bash

source /root/anaconda3/bin/activate tensorflow

jupyter notebook --ip=0.0.0.0 --port=$1
