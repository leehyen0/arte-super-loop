\ = "ArteSuperLoopAutoStart"
\ = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "cd C:\Users\yesan\Downloads\arte_super_loop; .\venv\Scripts\activate; uvicorn app.main:app --host 0.0.0.0 --port 8080"
\ = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName \ -Action \ -Trigger \ -RunLevel Highest -Force
Write-Host "??Windows ?œì‘ ???ë™ ?¤í–‰ ?±ë¡ ?„ë£Œ"
