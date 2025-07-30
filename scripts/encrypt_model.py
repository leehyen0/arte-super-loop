from Crypto.Cipher import AES
import os

KEY = os.environ.get("MODEL_KEY", "this_is_a_32byte_secret_key_!")

def encrypt_model(model_path, enc_path):
    with open(model_path, "rb") as f:
        data = f.read()
    cipher = AES.new(KEY.encode(), AES.MODE_EAX)
    ciphertext, tag = cipher.encrypt_and_digest(data)
    with open(enc_path, "wb") as f:
        f.write(cipher.nonce + ciphertext)

if __name__ == "__main__":
    encrypt_model("model/model.onnx", "model/model.onnx.enc")
    print("✅ 모델 암호화 완료")
