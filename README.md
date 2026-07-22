# 🎬 FFmpeg & MKVToolNix Audio/Video Toolbox

An elegant, graphical user interface (GUI) built with PowerShell to optimize and convert audio/video files (MKV) in batches. Perfect for stabilizing audio channels and hardware-accelerated transcoding.

Eine komfortable, grafische Windows-Oberfläche für PowerShell, um Audio- und Videodateien (MKV) im Batch-Verfahren zu optimieren und zu konvertieren.

---

## ⚠️ WICHTIGER WARNHINWEIS & HAFTUNGSAUSSCHLUSS / DISCLAIMER

### 🚨 Deutsch:
* **Führen Sie diesen Code oder die daraus resultierende Anwendung nicht aus, wenn Sie die Funktionsweise des Skripts nicht vollständig verstehen!** 
* Das Skript interagiert direkt mit Ihren Mediendateien und Systemprozessen. Unbedachte Modifikationen am Code können zu unerwartetem Verhalten oder Datenverlust führen.
* **Haftungsausschluss:** Die Bereitstellung erfolgt absolut ohne Mängelgewähr. Der Autor übernimmt keinerlei Haftung oder Verantwortung für etwaige Schäden, Systemabstürze, Datenverlust oder fehlerhaft konvertierte Medien, die durch die Nutzung dieses Tools entstehen. Die Nutzung erfolgt vollständig auf eigene Gefahr und eigenes Risiko.

### 🚨 English:
* **Do not execute this code or the compiled application unless you fully understand its mechanics and logic!**
* This script directly interacts with your media files and system processes. Unintended code modifications may cause unexpected behavior or data loss.
* **Disclaimer:** This tool is provided "as is", without warranty of any kind. The author assumes no liability or responsibility for any damages, data loss, system instability, or corrupted media resulting from the use or misuse of this software. You are using this tool entirely at your own risk.

---

## 🌟 Key Features / Hauptfunktionen

* **🔊 Deutsch 5.1 Center-Boost [Format-Erhalt]**
  * Findet vollautomatisch die deutsche Tonspur, egal an welcher Position sie liegt.
  * Erhöht die Lautstärke des Center-Kanals um den Faktor **1.4** für deutlich bessere Sprachverständlichkeit bei Soundbars/Fernsehern.
  * Behält das Original-Format (DTS bleibt DTS, AC3 bleibt AC3) bei maximaler Bitrate bei.
  * **Muxing via MKVToolNix:** Verwirft die alte Tonspur und setzt die optimierte Spur als Standard. Dolby Vision, HDR10+ und Untertitel bleiben zu 100% intakt.

* **⚡ H.264 Konvertierung via OpenCL [GPU]**
  * Hardwarebeschleunigtes Encodieren über die universelle OpenCL-Pipeline.
  * Ideal als ultra-stabile Option für **ältere Grafikkarten (z.B. GTX 1070 Ti, GTX 1060)** mit älteren v500 Treibern. 
  * Rechnet 10-Bit HDR Videos automatisch in treiberkonformes 8-Bit um, um Abstürze zu vermeiden.

* **🚀 H.265 Konvertierung via NVIDIA NVENC [GPU]**
  * Blitzschnelle Hardware-Konvertierung für **moderne NVIDIA-Grafikkarten** (RTX-Serie / Treiber ab v610+).

* **💎 H.265 Konvertierung via libx265 [CPU]**
  * Hochqualitative Software-Konvertierung über den Prozessor für minimale Dateigrößen und beste Bildqualität.

* **🛑 Flüssige GUI & Sofort-Abbruch**
  * Die Oberfläche friert während der Verarbeitung niemals ein („Keine Rückmeldung“ ist ausgeschlossen).
  * Der **„Vorgang abbrechen“**-Button beendet alle Hintergrundprozesse sofort und löscht angefangene Datei-Fragmente sauber von der Festplatte.

---

## ⚙️ Requirements & Auto-Installer / Voraussetzungen

Das Tool läuft ohne Installation direkt als eigenständige `.exe` unter Windows 10 & 11. Es prüft beim Start vollautomatisch das Vorhandensein der Systemwerkzeuge:
* **FFmpeg** (Für die Audio- und Videobearbeitung)
* **MKVToolNix** (Für das fehlerfreie Zusammensetzen der Container)

*Sollten die Komponenten fehlen, bietet das Tool an, diese mit einem Klick automatisch über den offiziellen Microsoft Paketmanager `winget` einzurichten.*

---

## 📦 Download & Usage / Verwendung

1. Klicke oben auf den Reiter **Releases** auf der rechten Seite dieses Repositories.
2. Lade dir die neueste fertig compilierte **`FFmpeg_Toolbox_vX.X.X.exe`** herunter.
3. Wähle deine MKV-Dateien, lege die Qualitätsstufe fest und klicke auf **„Aktion ausführen“**.

---
Developed with 🛠️, PowerShell, and .NET Diagnostics Pipelines.
