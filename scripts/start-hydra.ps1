#!/usr/bin/env pwsh
# Shebang line for Powershell v7.0.0-preview.4

$hydraProcess = Get-Process -Name "hydra" -ErrorAction SilentlyContinue
if ($hydraProcess) {
    # try gracefully first
  $hydraProcess.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$hydraProcess.HasExited) {
    $hydraProcess | Stop-Process -Force
  }
} else {
	$env:CORS_DEBUG=1;
    Start-Process -FilePath ".\internal\hydra\hydra.exe" -ArgumentList "serve", "all", "--config .\configs\hydra-config.yaml", "--dangerous-force-http"
}