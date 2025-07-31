import pyautogui
from fastapi import APIRouter
import pytesseract
from PIL import ImageGrab

router = APIRouter()

@router.post("/keyboard")
def keyboard_input(text: str):
    pyautogui.typewrite(text, interval=0.05)
    return {"status": "typed", "text": text}

@router.post("/press")
def press_key(key: str):
    pyautogui.press(key)
    return {"status": "pressed", "key": key}

@router.post("/mouse_click")
def mouse_click(x: int, y: int, button: str = "left"):
    pyautogui.click(x, y, button=button)
    return {"status": "clicked", "x": x, "y": y}

@router.post("/mouse_move")
def mouse_move(x: int, y: int):
    pyautogui.moveTo(x, y, duration=0.3)
    return {"status": "moved", "x": x, "y": y}

@router.post("/screenshot_ocr")
def screenshot_ocr():
    img = ImageGrab.grab()
    text = pytesseract.image_to_string(img, lang="eng+kor")
    return {"status": "captured", "text": text}
