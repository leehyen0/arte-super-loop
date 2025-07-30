import os

def ensure_model():
    if not os.path.exists("model"):
        os.makedirs("model")

    model_path = "model/model.onnx"
    if not os.path.exists(model_path) or os.path.getsize(model_path) == 0:
        print("⚠️ 모델이 없어서 기본 모델 생성")
        with open(model_path, "wb") as f:
            f.write(b"")
