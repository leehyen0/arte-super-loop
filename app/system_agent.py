import threading, time
import GPUtil, psutil

def monitor_resources():
    while True:
        gpus = GPUtil.getGPUs()
        if gpus:
            gpu = gpus[0]
            print(f"[GPU] {gpu.name} | ?¬ìš©ë¥? {gpu.load*100:.1f}% | ë©”ëª¨ë¦? {gpu.memoryUsed}/{gpu.memoryTotal}MB")
        cpu = psutil.cpu_percent()
        ram = psutil.virtual_memory().percent
        print(f"[SYSTEM] CPU: {cpu}% | RAM: {ram}%")
        time.sleep(10)

def start_monitor():
    t = threading.Thread(target=monitor_resources, daemon=True)
    t.start()
