import os, subprocess, time
from utils import load_memory, save_memory

def create_core():
    code = "def compute(x):\n    return [v*42 for v in x]\n"
    with open("app/core.py", "w") as f:
        f.write(code)

def rebuild():
    print("✅ core.py 재작성 완료 (Nuitka 미사용)")

def auto_self_upgrade():
    while True:
        memory = load_memory()
        memory["last_upgrade"] = time.ctime()
        save_memory(memory)

        create_core()
        rebuild()
        time.sleep(3600)
