Get-ChildItem -Filter *.png | ForEach-Object { Write-Host "Validated $($_.Name)" }
