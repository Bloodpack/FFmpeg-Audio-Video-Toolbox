# 🎬 FFmpeg & MKVToolNix Audio/Video Toolbox

An elegant, graphical user interface (GUI) built with PowerShell to optimize and convert audio/video files (MKV) in batches. Perfect for stabilizing audio channels and hardware-accelerated transcoding.

Eine komfortable, grafische Windows-Oberfläche für PowerShell, um Audio- und Videodateien (MKV) im Batch-Verfahren zu optimieren und zu konvertieren.

---

## 🌟 Key Features / Hauptfunktionen

* **🔊 Deutsch 5.1 Center-Boost (Format-Erhalt)**
  * Automatically detects the German audio track, regardless of its position in the container.
  * Boosts the center channel volume by a factor of **1.4** for significantly improved dialogue clarity on soundbars/TVs.
  * Preserves the original audio format (DTS stays DTS, AC3 stays AC3) at maximum bitrate.
  * **Intelligent Muxing via MKVToolNix:** Completely discards the old, quiet audio track and sets the optimized track as default. 
  * *Dolby Vision, HDR10+, and all subtitles remain 100% intact!*

* **⚡ H.264 Conversion via OpenCL [GPU]**
  * Hardware-accelerated encoding using the cross-platform OpenCL pipeline.
  * Designed specifically as an ultra-stable option for **older NVIDIA graphics cards (e.g., GTX 1070 Ti, GTX 1060)** or systems with legacy drivers (v500 series).
  * Automatically applies a 10-bit to 8-bit color downsampling filter to prevent encoding crashes on older hardware architecture.

* **🚀 H.265 Conversion via NVIDIA NVENC [GPU]**
  * High-speed hardware encoding for **modern NVIDIA graphics cards** (RTX series / drivers v610+).

* **💎 H.265 Conversion via libx265 [CPU]**
  * High-quality software encoding using the processor for maximum compression and pristine image quality.

* **🛑 Smart Anti-Freeze & Real-Time Abort**
  * The GUI is completely decoupled from the processing background tasks. It will never freeze or show "Not Responding".
  * The **"Vorgang abbrechen"** (Cancel Process) button instantly terminates all background instances and safely cleans up incomplete temporary file fragments from your disk.

---

## ⚙️ Requirements & Auto-Installer / Voraussetzungen

The compiled tool runs directly as a standalone `.exe` on Windows 10 & 11. It automatically checks for core requirements upon startup:
* **FFmpeg** (For audio and video filtering)
* **MKVToolNix** (For container parsing and structural track mapping)

*If these dependencies are missing, the tool will safely prompt you to install them automatically with one click via Microsoft's official `winget` manager.*

---

## 📦 Download & Usage / Verwendung

1. Go to the **Actions** tab of this repository.
2. Click on the latest successful workflow run.
3. Scroll down to **Artifacts** and download the compiled **`FFmpeg_Toolbox_Windows.zip`**.
4. Extract the ZIP, start the `.exe`, select your MKV files, choose your desired quality profile, and hit **"Aktion ausführen"**.

---
Developed with 🛠️, PowerShell, and .NET Diagnostics Pipelines.
