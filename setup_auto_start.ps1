 = 'C:\Users\yesan\Downloads\arte_super_loop\auto_start.bat'

# auto_start.bat 생성
Set-Content -Encoding UTF8  @'
cd /d C:\Users\yesan\Downloads\arte_super_loop
call venv\Scripts\activate
python -m uvicorn app.main:app --host 0.0.0.0 --port 8080
'@

# 작업 스케줄러에 등록
 = New-ScheduledTaskAction -Execute 
 = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action  -Trigger  -TaskName "Arte Super Loop Auto Start" -Description "부팅 시 서버 자동 실행" -Force

Write-Host "✅ 자동 실행 등록 완료! 재부팅 시 서버가 자동 실행됩니다."
