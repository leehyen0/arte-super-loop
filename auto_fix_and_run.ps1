cd C:\Users\yesan\Downloads\arte_super_loop

# 🔄 GitHub 최신 코드 자동 업데이트
if (!(Test-Path ".git")) {
    git clone https://github.com/사용할-레포주소.git .
} else {
    git reset --hard
    git pull origin main
}

# ✅ 가상환경 확인 및 패키지 설치
if (!(Test-Path "venv\Scripts\activate")) { python -m venv venv }
call venv\Scripts\activate
pip install --upgrade pip
pip install fastapi uvicorn onnxruntime-gpu numpy psutil GPUtil pycryptodome

# ✅ 모델 파일 확인
if (!(Test-Path "model\model.onnx")) {
    Write-Host "⚠️ model.onnx 없음 → 기본 모델 생성"
    mkdir model -Force
}

# ✅ predictor.py에 GPU 강제 코드 삽입
 = Get-Content app\predictor.py -Raw
if ( -notmatch "CUDAExecutionProvider") {
     =  -replace "import onnxruntime.*", "import onnxruntime as ort
providers=['CUDAExecutionProvider','CPUExecutionProvider']"
    Set-Content -Encoding UTF8 app\predictor.py 
}

python -m uvicorn app.main:app --host 0.0.0.0 --port 8080
