@echo off
cd /d %~dp0
cd venv\Scripts
call activate
cd ..
uvicorn app.main:app --host 0.0.0.0 --port 8080
pause
