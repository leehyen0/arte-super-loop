Write-Host "???�경 ?�정 ?�작..."
python -m venv venv
.\venv\Scripts\activate
pip install --upgrade pip
pip install fastapi uvicorn onnxruntime-gpu numpy psutil GPUtil pycryptodome
Write-Host "???�치 ?�료! uvicorn app.main:app --host 0.0.0.0 --port 8080 ?�행 가??
