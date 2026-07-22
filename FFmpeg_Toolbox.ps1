Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==============================================================================
# --- 0. PRÜFUNG DER SYSTEMWERKZEUGE ---
# ==============================================================================
$ffmpegReady = Get-Command "ffmpeg" -ErrorAction SilentlyContinue
if (!$ffmpegReady) {
    $msgBoxTitle = "FFmpeg nicht gefunden!"
    $msgBoxText  = "FFmpeg wurde auf diesem System nicht gefunden.`n`nSoll FFmpeg jetzt automatisch über 'winget' installiert werden?"
    if ([System.Windows.Forms.MessageBox]::Show($msgBoxText, $msgBoxTitle, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question) -eq [System.Windows.Forms.DialogResult]::Yes) {
        $installForm = New-Object System.Windows.Forms.Form
        $installForm.Text = "Installiere FFmpeg..."
        $installForm.Size = New-Object System.Drawing.Size(400, 120)
        $installForm.StartPosition = "CenterScreen"
        $installForm.FormBorderStyle = "FixedDialog"
        $installForm.ControlBox = $false
        $installLabel = New-Object System.Windows.Forms.Label
        $installLabel.Location = New-Object System.Drawing.Point(20, 30)
        $installLabel.Size = New-Object System.Drawing.Size(360, 40)
        $installLabel.Text = "FFmpeg wird über winget installiert. Bitte warten..."
        $installForm.Controls.Add($installLabel)
        $installForm.Show(); [System.Windows.Forms.Application]::DoEvents()
        winget install --id Gyan.FFmpeg -e --accept-source-agreements --accept-package-agreements --silent | Out-Null
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        $installForm.Close()
    } else { exit }
}

$mkvmergeReady = Get-Command "mkvmerge" -ErrorAction SilentlyContinue
$standardPath = "C:\Program Files\MKVToolNix"

if (!$mkvmergeReady -and (Test-Path (Join-Path $standardPath "mkvmerge.exe"))) {
    $env:Path += ";$standardPath"
    $mkvmergeReady = $true
}

if (!$mkvmergeReady) {
    $msgBoxTitle = "MKVToolNix erforderlich!"
    $msgBoxText  = "Für die Center-Boost-Aktion wird MKVToolNix benötigt, um Fehler beim Spur-Kopieren zu vermeiden.`n`nSoll MKVToolNix jetzt automatisch über 'winget' nachinstalliert werden?"
    if ([System.Windows.Forms.MessageBox]::Show($msgBoxText, $msgBoxTitle, [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question) -eq [System.Windows.Forms.DialogResult]::Yes) {
        $installForm = New-Object System.Windows.Forms.Form
        $installForm.Text = "Installiere MKVToolNix..."
        $installForm.Size = New-Object System.Drawing.Size(400, 120)
        $installForm.StartPosition = "CenterScreen"
        $installForm.FormBorderStyle = "FixedDialog"
        $installForm.ControlBox = $false
        $installLabel = New-Object System.Windows.Forms.Label
        $installLabel.Location = New-Object System.Drawing.Point(20, 30)
        $installLabel.Size = New-Object System.Drawing.Size(360, 40)
        $installLabel.Text = "MKVToolNix wird über winget installiert. Bitte warten..."
        $installForm.Controls.Add($installLabel)
        $installForm.Show(); [System.Windows.Forms.Application]::DoEvents()
        winget install --id Bunkus.MKVToolNix -e --accept-source-agreements --accept-package-agreements --silent | Out-Null
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User") + ";$standardPath"
        $installForm.Close()
    } else { exit }
}

# --- HAUPTFENSTER ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "FFmpeg Audio/Video Toolbox"
$form.Size = New-Object System.Drawing.Size(540, 530)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$labelDropdown = New-Object System.Windows.Forms.Label
$labelDropdown.Location = New-Object System.Drawing.Point(20, 15)
$labelDropdown.Size = New-Object System.Drawing.Size(480, 20)
$labelDropdown.Text = "1. Bitte wählen Sie die gewünschte Aktion aus:"
$form.Controls.Add($labelDropdown)

$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = New-Object System.Drawing.Point(20, 38)
$comboBox.Size = New-Object System.Drawing.Size(480, 25)
$comboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

$options = New-Object System.Collections.ArrayList
$options.Add("1. Deutsch 5.1 Center-Boost [Format-Erhalt]") | Out-Null
$options.Add("2. H.264 Konvertierung via OpenCL [GPU - Universell]") | Out-Null
$options.Add("3. H.265 Konvertierung via NVIDIA NVENC [GPU - Benötigt Treiber 610+]") | Out-Null
$options.Add("4. H.265 Konvertierung via libx265 [CPU - Beste Qualität]") | Out-Null
$comboBox.Items.AddRange($options)
$comboBox.SelectedIndex = 0
$form.Controls.Add($comboBox)

$labelQuality = New-Object System.Windows.Forms.Label
$labelQuality.Location = New-Object System.Drawing.Point(20, 75)
$labelQuality.Size = New-Object System.Drawing.Size(480, 20)
$labelQuality.Text = "2. Video-Qualität festlegen [Gilt für Video-Aktionen]:"
$form.Controls.Add($labelQuality)

$comboBoxQuality = New-Object System.Windows.Forms.ComboBox
$comboBoxQuality.Location = New-Object System.Drawing.Point(20, 98)
$comboBoxQuality.Size = New-Object System.Drawing.Size(480, 25)
$comboBoxQuality.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

$qualityOptions = New-Object System.Collections.ArrayList
$qualityOptions.Add("Standard [6 Mbps / CRF 22 - Empfohlen]") | Out-Null
$qualityOptions.Add("Hoch [12 Mbps / CRF 18 - Maximale Qualität]") | Out-Null
$qualityOptions.Add("Niedrig [3.5 Mbps / CRF 26 - Kleinere Datei]") | Out-Null
$comboBoxQuality.Items.AddRange($qualityOptions)
$comboBoxQuality.SelectedIndex = 0
$form.Controls.Add($comboBoxQuality)
$labelFolder = New-Object System.Windows.Forms.Label
$labelFolder.Location = New-Object System.Drawing.Point(20, 135)
$labelFolder.Size = New-Object System.Drawing.Size(480, 20)
$labelFolder.Text = "3. Zu verarbeitende MKV-Dateien auswählen [Mehrfachauswahl möglich]:"
$form.Controls.Add($labelFolder)

$textBoxFolder = New-Object System.Windows.Forms.TextBox
$textBoxFolder.Location = New-Object System.Drawing.Point(20, 158)
$textBoxFolder.Size = New-Object System.Drawing.Size(360, 25)
$textBoxFolder.ReadOnly = $true
$form.Controls.Add($textBoxFolder)

$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Location = New-Object System.Drawing.Point(390, 156)
$buttonBrowse.Size = New-Object System.Drawing.Size(110, 25)
$buttonBrowse.Text = "Dateien wählen..."
$form.Controls.Add($buttonBrowse)

$labelStatus = New-Object System.Windows.Forms.Label
$labelStatus.Location = New-Object System.Drawing.Point(20, 200)
$labelStatus.Size = New-Object System.Drawing.Size(480, 20)
$labelStatus.Text = "Status: Bitte Dateien auswählen"
$form.Controls.Add($labelStatus)

$textBoxLog = New-Object System.Windows.Forms.TextBox
$textBoxLog.Location = New-Object System.Drawing.Point(20, 225)
$textBoxLog.Size = New-Object System.Drawing.Size(480, 150)
$textBoxLog.MultiLine = $true
$textBoxLog.ScrollBars = "Vertical"
$textBoxLog.ReadOnly = $true
$form.Controls.Add($textBoxLog)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(20, 390)
$progressBar.Size = New-Object System.Drawing.Size(480, 25)
$progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Blocks
$progressBar.Minimum = 0
$progressBar.Value = 0
$form.Controls.Add($progressBar)

$buttonStart = New-Object System.Windows.Forms.Button
$buttonStart.Location = New-Object System.Drawing.Point(90, 435)
$buttonStart.Size = New-Object System.Drawing.Size(160, 40)
$buttonStart.Text = "Aktion ausführen"
$buttonStart.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$buttonStart.Enabled = $false
$form.Controls.Add($buttonStart)

$buttonCancel = New-Object System.Windows.Forms.Button
$buttonCancel.Location = New-Object System.Drawing.Point(270, 435)
$buttonCancel.Size = New-Object System.Drawing.Size(160, 40)
$buttonCancel.Text = "Vorgang abbrechen"
$buttonCancel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$buttonCancel.Enabled = $false
$form.Controls.Add($buttonCancel)

$global:SelectedFiles = @()
$global:AbortRequested = $false
$global:ActiveJobProcess = $null

$buttonBrowse.Add_Click({
    $fileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $fileBrowser.Filter = "MKV Videodateien (*.mkv)|*.mkv"
    $fileBrowser.Multiselect = $true
    if ($fileBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $global:SelectedFiles = $fileBrowser.FileNames
        $textBoxFolder.Text = [System.IO.Path]::GetDirectoryName($global:SelectedFiles)
        $labelStatus.Text = "Status: Bereit zum Starten"
        $buttonStart.Enabled = $true
        $textBoxLog.Clear()
        $textBoxLog.AppendText("Ausgewählte Dateien: $($global:SelectedFiles.Count)`r`n`r`n")
        foreach ($f in $global:SelectedFiles) { $textBoxLog.AppendText("- $([System.IO.Path]::GetFileName($f))`r`n") }
    }
})

$buttonCancel.Add_Click({
    $global:AbortRequested = $true
    $buttonCancel.Enabled = $false
    $textBoxLog.AppendText("`r`n[!] ABBRUCH ERZWUNGEN! Beende alle Instanzen...`r`n")
    if ($global:ActiveJobProcess -ne $null) {
        try {
            $global:ActiveJobProcess.Kill()
            $global:ActiveJobProcess.WaitForExit()
        } catch {}
    }
    Stop-Process -Name "ffmpeg" -Force -ErrorAction SilentlyContinue
    Stop-Process -Name "mkvmerge" -Force -ErrorAction SilentlyContinue
})
$buttonStart.Add_Click({
    $buttonStart.Enabled = $false; $buttonBrowse.Enabled = $false; $comboBox.Enabled = $false; $comboBoxQuality.Enabled = $false
    $buttonCancel.Enabled = $true
    $global:AbortRequested = $false
    
    $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
    $progressBar.MarqueeAnimationSpeed = 30
    
    $outFile = $null
    $tempAudio = $null

    function Write-GuiLog($text) {
        $textBoxLog.AppendText("$text`r`n")
        $textBoxLog.SelectionStart = $textBoxLog.TextLength
        $textBoxLog.ScrollToCaret()
        [System.Windows.Forms.Application]::DoEvents()
    }

    function Invoke-SilencedProcess($exePath, $argumentsString) {
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = $exePath
        $psi.Arguments = $argumentsString
        $psi.UseShellExecute = $false
        $psi.CreateNoWindow = $true
        $psi.WindowStyle = "Hidden"

        $proc = New-Object System.Diagnostics.Process
        $proc.StartInfo = $psi
        
        if ($global:AbortRequested) { return }
        if ($proc.Start()) {
            $global:ActiveJobProcess = $proc
            while (!$proc.HasExited) {
                [System.Windows.Forms.Application]::DoEvents()
                Start-Sleep -Milliseconds 100
                if ($global:AbortRequested) { break }
            }
            $global:ActiveJobProcess = $null
        }
    }

    $totalFiles = $global:SelectedFiles.Count
    $qIndex = $comboBoxQuality.SelectedIndex

    if ($qIndex -eq 1) { $targetBitrate = "12M"; $crfValue = 18 }
    elseif ($qIndex -eq 2) { $targetBitrate = "3500K"; $crfValue = 26 }
    else { $targetBitrate = "6M"; $crfValue = 22 }

    $currentFileIndex = 0
    $baseFolder = [System.IO.Path]::GetDirectoryName($global:SelectedFiles)

    # Präzise Ermittlung des Windows-Temp-Pfades für den OpenCL-Müllschutz
    $rawTempPath = [System.IO.Path]::GetTempPath()
    $safeTempPath = $rawTempPath.Replace('\', '\\')

    foreach ($filePath in $global:SelectedFiles) {
        if ($global:AbortRequested) { break }
        $currentFileIndex++
        $fileName = [System.IO.Path]::GetFileName($filePath)
        $labelStatus.Text = "Status: Verarbeite Datei $currentFileIndex von $totalFiles..."

        if ($comboBox.SelectedIndex -eq 0) {
            $outputDir = Join-Path $baseFolder "converted_CenterBoost"
            if (!(Test-Path $outputDir)) { New-Item -ItemType Directory -Path $outputDir | Out-Null }
            $outFile = Join-Path $outputDir $fileName
            $tempAudio = Join-Path $outputDir "temp_boosted.eac3"

            Write-GuiLog "[$currentFileIndex/$totalFiles] Analysiere Tonspuren: $fileName..."
            $ffprobeCmd = "ffprobe -v error -select_streams a -show_entries stream=index,codec_name:stream_tags=language -of csv=p=0 `"$filePath`""
            $audioStreams = Invoke-Expression $ffprobeCmd 2>$null
            
            $targetStreamIndex = 0; $codecOut = "eac3"; $bitrateArgs = @("-b:a", "768k")
            $loopIndex = 0
            foreach ($stream in $audioStreams) {
                if ($stream -match ",(deu|ger)") {
                    $targetStreamIndex = $loopIndex
                    $codecName = ($stream -split ",").ToString().Trim()
                    if ($codecName -match "dts") { $codecOut = "dts"; $bitrateArgs = @("-b:a", "1536k") }
                    elseif ($codecName -eq "ac3") { $codecOut = "ac3"; $bitrateArgs = @("-b:a", "640k") }
                    break
                }
                $loopIndex++
            }

            Write-GuiLog "-> Booste deutsche Tonspur isoliert..."
            if (Test-Path $tempAudio) { Remove-Item $tempAudio -Force }
            
            $argsList = "-y -i `"$filePath`" -map 0:a:$targetStreamIndex -af `"pan=5.1|FL=FL|FR=FR|FC=1.4*FC|LFE=LFE|BL=BL|BR=BR`" -c:a $codecOut $($bitrateArgs -join ' ') -dialnorm -28 `"$tempAudio`""
            Invoke-SilencedProcess "ffmpeg" $argsList

            if (Test-Path $tempAudio -and !$global:AbortRequested) {
                Write-GuiLog "-> Muxe Spuren fehlerfrei mit mkvmerge zusammen..."
                $mkvArgs = "-o `"$outFile`" -A `"$filePath`" --track-name `"0:Deutsch [Center-Boost]`" --language `"0:ger`" --default-track-flag `"0:yes`" --forced-display-flag `"0:yes`" `"$tempAudio`""
                Invoke-SilencedProcess "mkvmerge" $mkvArgs
                if (Test-Path $tempAudio) { Remove-Item $tempAudio -Force }
                Write-GuiLog "Erfolgreich gespeichert in 'converted_CenterBoost'!"
            }
        } else {
            $outputDirName = if ($comboBox.SelectedIndex -eq 1) { "converted_h264" } elseif ($comboBox.SelectedIndex -eq 2) { "converted_h265" } else { "converted_h265" }
            $outputDir = Join-Path $baseFolder $outputDirName
            if (!(Test-Path $outputDir)) { New-Item -ItemType Directory -Path $outputDir | Out-Null }
            $outFile = Join-Path $outputDir $fileName

            if ($comboBox.SelectedIndex -eq 1) {
                Write-GuiLog "[$currentFileIndex/$totalFiles] Encodiere Video via GPU (OpenCL Beschleunigung)..."
                # ANPASSUNG: Cache-Verzeichnis sauber in den System-Temp-Ordner umgeleitet
                $argsList = "-y -i `"$filePath`" -map 0 -c:v libx264 -x264opts `"opencl=1:opencl_cache_dir=$safeTempPath`" -b:v $targetBitrate -maxrate 25M -bufsize 20M -pix_fmt yuv420p -c:a copy -c:s copy `"$outFile`""
                Invoke-SilencedProcess "ffmpeg" $argsList
            }
            elseif ($comboBox.SelectedIndex -eq 2) {
                Write-GuiLog "[$currentFileIndex/$totalFiles] Encodiere Video via NVIDIA H.265 NVENC (GPU)..."
                $argsList = "-y -i `"$filePath`" -map 0 -c:v hevc_nvenc -b:v $targetBitrate -maxrate 25M -bufsize 20M -c:a copy -c:s copy `"$outFile`""
                Invoke-SilencedProcess "ffmpeg" $argsList
            }
            else {
                Write-GuiLog "[$currentFileIndex/$totalFiles] Encodiere Video via libx265 (CPU)..."
                $argsList = "-y -i `"$filePath`" -map 0 -c:v libx265 -crf $crfValue -c:a copy -c:s copy `"$outFile`""
                Invoke-SilencedProcess "ffmpeg" $argsList
            }

            if ((!(Test-Path -LiteralPath $outFile) -or (Get-Item -LiteralPath $outFile).Length -eq 0) -and !$global:AbortRequested) {
                Write-GuiLog "FEHLER: Konvertierung fehlgeschlagen!"
            } else { if (!$global:AbortRequested) { Write-GuiLog "Erfolgreich gespeichert in '$outputDirName'!" } }
        }
    }
    
    $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Blocks
    
    if ($global:AbortRequested) {
        $labelStatus.Text = "Status: Abgebrochen"
        Write-GuiLog "`r`n--- VORGANG VOM NUTZER ABGEBROCHEN ---"
        try {
            if ($outFile -and (Test-Path $outFile)) { Remove-Item $outFile -Force }
            if ($tempAudio -and (Test-Path $tempAudio)) { Remove-Item $tempAudio -Force }
        } catch {}
        $progressBar.Value = 0
    } else {
        $progressBar.Value = $progressBar.Maximum
        $labelStatus.Text = "Status: Fertig!"
        Write-GuiLog "--- Alle Konvertierungen abgeschlossen! ---"
    }
    $buttonStart.Enabled = $true; $buttonBrowse.Enabled = $true; $comboBox.Enabled = $true; $comboBoxQuality.Enabled = $true
    $buttonCancel.Enabled = $false
})

# GUI anzeigen
$form.ShowDialog() | Out-Null