Write-Host "???κ²½ ?€μ  ?μ..."
python -m venv venv
.\venv\Scripts\activate
pip install --upgrade pip
pip install fastapi uvicorn onnxruntime-gpu numpy psutil GPUtil pycryptodome
Write-Host "???€μΉ ?λ£! uvicorn app.main:app --host 0.0.0.0 --port 8080 ?€ν κ°??
