$basePath = "C:\Users\yesan\Downloads\arte_super_loop"

Write-Host "📂 arte_super_loop 폴더 생성 중..."
New-Item -ItemType Directory -Force -Path $basePath
New-Item -ItemType Directory -Force -Path "$basePath\app"
New-Item -ItemType Directory -Force -Path "$basePath\scripts"
New-Item -ItemType Directory -Force -Path "$basePath\model"

# ---------------------------
# main.py
# ---------------------------
@"
from fastapi import FastAPI
from app.predictor import run_inference
from app.auto_loop import start_auto_loop

app = FastAPI()

@app.get("/api/fake")
def fake_api(x: float = 1.0):
    return {"result": run_inference([x])}

@app.on_event("startup")
async def startup_event():
    start_auto_loop()
"@ | Set-Content "$basePath\app\main.py"

# predictor.py
@"
import onnxruntime as ort
import numpy as np
import os
from app.utils import ensure_model

ensure_model()

session = None
if os.path.exists("model/model.onnx") and os.path.getsize("model/model.onnx") > 0:
    try:
        session = ort.InferenceSession(
            "model/model.onnx",
            providers=["CUDAExecutionProvider", "CPUExecutionProvider"]
        )
    except:
        print("⚠️ GPU 초기화 실패 → CPU 모드로 실행")

def run_inference(x):
    if session is None:
        return [v * 42 for v in x]
    return session.run(None, {"input": np.array(x, dtype=np.float32)})[0]
"@ | Set-Content "$basePath\app\predictor.py"

# utils.py
@"
import os

def ensure_model():
    if not os.path.exists("model"):
        os.makedirs("model")

    model_path = "model/model.onnx"
    if not os.path.exists(model_path) or os.path.getsize(model_path) == 0:
        print("⚠️ 모델이 없어 기본 더미 모델 생성")
        with open(model_path, "wb") as f:
            f.write(b"")
"@ | Set-Content "$basePath\app\utils.py"

# system_agent.py
@"
import threading, time
import GPUtil, psutil

def monitor_resources():
    while True:
        gpus = GPUtil.getGPUs()
        if gpus:
            gpu = gpus[0]
            print(f"[GPU] {gpu.name} | 사용률: {gpu.load*100:.1f}% | 메모리: {gpu.memoryUsed}/{gpu.memoryTotal}MB")
        cpu = psutil.cpu_percent()
        ram = psutil.virtual_memory().percent
        print(f"[SYSTEM] CPU: {cpu}% | RAM: {ram}%")
        time.sleep(10)

def start_monitor():
    t = threading.Thread(target=monitor_resources, daemon=True)
    t.start()
"@ | Set-Content "$basePath\app\system_agent.py"

# auto_loop.py
@"
import threading, time, subprocess
from app.system_agent import start_monitor

def auto_restart():
    while True:
        time.sleep(5)
        result = subprocess.run("netstat -ano | findstr :8080", shell=True, capture_output=True)
        if b"LISTENING" not in result.stdout:
            print("⚠️ 서버 다운 → 자동 재시작")
            subprocess.Popen("uvicorn app.main:app --host 0.0.0.0 --port 8080", shell=True)

def start_auto_loop():
    start_monitor()
    t = threading.Thread(target=auto_restart, daemon=True)
    t.start()
"@ | Set-Content "$basePath\app\auto_loop.py"

# deploy_local.ps1
@"
Write-Host "✅ 환경 설정 시작..."
python -m venv venv
.\venv\Scripts\activate
pip install --upgrade pip
pip install fastapi uvicorn onnxruntime-gpu numpy psutil GPUtil pycryptodome
Write-Host "✅ 설치 완료! uvicorn app.main:app --host 0.0.0.0 --port 8080 실행 가능"
"@ | Set-Content "$basePath\scripts\deploy_local.ps1"

# register_autostart.ps1
@"
\$taskName = "ArteSuperLoopAutoStart"
\$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "cd $basePath; .\venv\Scripts\activate; uvicorn app.main:app --host 0.0.0.0 --port 8080"
\$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName \$taskName -Action \$action -Trigger \$trigger -RunLevel Highest -Force
Write-Host "✅ Windows 시작 시 자동 실행 등록 완료"
"@ | Set-Content "$basePath\scripts\register_autostart.ps1"

Write-Host "🎉 모든 파일 생성 완료!"
