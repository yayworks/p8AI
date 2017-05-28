
#!/bin/bash
source /opt/DL/openblas/bin/openblas-activate
source /opt/DL/tensorflow/bin/tensorflow-activate
source /opt/DL/digits/bin/digits-activate

jupyter notebook --ip=0.0.0.0 --port=$1
