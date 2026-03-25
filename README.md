# 🐦 Flappy Bird (8086 Assembly)

## 📌 Overview

This project is a **Flappy Bird game implemented in 8086 Assembly language**.
It runs in a DOS environment and demonstrates low-level programming concepts such as:

* Direct memory manipulation
* Interrupt handling
* Basic game loop and animation
* Keyboard input handling

---

## ⚙️ Requirements

To run this game, you need the following tools installed:

* **NASM** – Assembler for compiling the assembly code
* **DOSBox** – To emulate a DOS environment
* **Notepad++** – (Optional) Code editor for modifying the source code

---

## 📥 Installation

To simplify setup, you can download all required tools (including DOSBox) from the following repository:

👉 https://github.com/ASD0x41/Assembly-Programming-Package

This package contains:

* NASM
* DOSBox
* Supporting files for assembly programming

---

## 🚀 How to Run the Game

### Step 1: Extract Files

* Download and extract the package
* Place the game source file (e.g., `game.asm`) inside the working directory

---

### Step 2: Open DOSBox

* Launch DOSBox
* Mount your working directory:

```
mount c c:\your-folder-path
c:
```

---

### Step 3: Assemble the Code

```
nasm game.asm -f bin -o game.com
```

---

### Step 4: Run the Game

```
game.com
```

---

## 🎮 Controls

* **Key Press** → Move the bird upward
* **No Input** → Bird falls due to gravity

---

## 🧠 Features

* Real-time animation using screen memory
* Obstacle generation (pillars)
* Gravity simulation
* Keyboard interaction

---

## 📂 Project Structure

```
/project-folder
│── game.asm
│── README.md
```

---

## ⚠️ Notes

* Make sure file paths are correct when mounting in DOSBox
* Use DOS-compatible file names (avoid spaces if possible)
* The game runs in **real-mode 8086 environment**

---

## 👨‍💻 Author

Developed as part of an Assembly Language project.

---

## ⭐ Support

If you like this project, consider giving it a ⭐ on GitHub!
