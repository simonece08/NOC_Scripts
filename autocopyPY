#!/usr/bin/env python3
import sys
import select
import termios
import tty
import time
import pyautogui
import pyperclip
import threading

# Define labels for each tab
tab_labels = ["LSS Check", "PON Check", "OLT / LL", "BNG"]

# Store original terminal settings
original_termios = termios.tcgetattr(sys.stdin)

# Function to detect keypress (non-blocking)
stop_script = False
def listen_for_escape():
    global stop_script
    tty.setcbreak(sys.stdin.fileno())
    try:
        while not stop_script:
            if select.select([sys.stdin], [], [], 0.1)[0]:  # Non-blocking key check
                key = sys.stdin.read(1)
                if key == "\x1b":  # Escape key
                    print("\nEscape key pressed! Stopping script.")
                    stop_script = True
                    break
    finally:
        termios.tcsetattr(sys.stdin, termios.TCSADRAIN, original_termios)  # Restore terminal settings

# Start a separate thread to listen for Esc key
esc_thread = threading.Thread(target=listen_for_escape, daemon=True)
esc_thread.start()

def get_chrome_tabs(num_tabs=4, delay=0.3):
    urls = []

    for i in range(num_tabs):
        if stop_script:
            break

        # Select address bar
        pyautogui.hotkey("ctrl", "l")
        time.sleep(delay)

        # Copy URL
        pyautogui.hotkey("ctrl", "c")
        time.sleep(delay)

        # Get copied URL from clipboard
        url = pyperclip.paste().strip()
        if url:
            label = tab_labels[i] if i < len(tab_labels) else f"Tab {i+1}"
            urls.append(f"{label}: {url}")

        # Move to next tab
        pyautogui.hotkey("ctrl", "tab")
        time.sleep(delay)

    return urls

# Run script
print("Switch to Chrome now. The script will start in 2 seconds...")
time.sleep(2)  # Give time to switch to Chrome

# Get URLs and format output
urls = get_chrome_tabs(len(tab_labels))

# Restore terminal settings before exit
termios.tcsetattr(sys.stdin, termios.TCSADRAIN, original_termios)

# Copy formatted result to clipboard
formatted_output = "\n".join(urls)
pyperclip.copy(formatted_output)

print("Copied to clipboard!\n")
print(formatted_output)  # Display output in console
