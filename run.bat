@echo off
echo ========================================================
echo Starting Autonomous Software Engineering Agent
echo ========================================================

start "FastAPI Backend" cmd /k "venv\Scripts\uvicorn.exe backend.main:app --host 127.0.0.1 --port 8000 --reload"
timeout /t 3 /nobreak >nul
start "Streamlit Frontend" cmd /k "venv\Scripts\streamlit.exe run frontend/app.py --server.port 8501"

echo.
echo FastAPI Backend running at:  http://127.0.0.1:8000
echo Streamlit Frontend running: http://localhost:8501
echo ========================================================
pause
