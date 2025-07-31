from fastapi import FastAPI
from app import device_control

app = FastAPI()
app.include_router(device_control.router, prefix="/device")

@app.get("/")
def root():
    return {"status": "running"}
