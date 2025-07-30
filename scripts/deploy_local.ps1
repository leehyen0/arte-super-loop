Write-Host "???˜ê²½ ?¤ì • ?œìž‘..."
python -m venv venv
.\venv\Scripts\activate
pip install --upgrade pip
pip install fastapi uvicorn onnxruntime-gpu numpy psutil GPUtil pycryptodome
Write-Host "???¤ì¹˜ ?„ë£Œ! uvicorn app.main:app --host 0.0.0.0 --port 8080 ?¤í–‰ ê°€??
