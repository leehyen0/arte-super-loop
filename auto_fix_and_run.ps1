cd C:\Users\yesan\Downloads\arte_super_loop
call venv\Scripts\activate
pip install --upgrade pip
pip install fastapi uvicorn onnxruntime-gpu numpy psutil GPUtil pycryptodome pyautogui pynput opencv-python pytesseract pillow
python -m uvicorn app.main:app --host 0.0.0.0 --port 8080
