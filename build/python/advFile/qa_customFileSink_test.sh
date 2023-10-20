#!/usr/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/roland23/gr-advFile/python/advFile
export GR_CONF_CONTROLPORT_ON=False
export PATH="/home/roland23/gr-advFile/build/python/advFile":"$PATH"
export LD_LIBRARY_PATH="":$LD_LIBRARY_PATH
export PYTHONPATH=/home/roland23/gr-advFile/build/test_modules:$PYTHONPATH
/usr/bin/python3 /home/roland23/gr-advFile/python/advFile/qa_customFileSink.py 
