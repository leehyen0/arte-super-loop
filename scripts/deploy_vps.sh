#!/bin/bash
set -e
apt update && apt install -y python3-pip gcc g++ libssl-dev
pip install fastapi uvicorn[standard] onnxruntime-gpu pycryptodome nuitka

cd app
python3 -m nuitka --onefile core.py
rm -f core.py
cd ..

export MODEL_KEY="this_is_a_32byte_secret_key_!"
nohup uvicorn app.main:app --host 0.0.0.0 --port 8000 > arte.log 2>&1 &
