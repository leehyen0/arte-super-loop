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
