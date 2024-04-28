Get-ChildItem -Path .\Source\*.md -Recurse | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$latestFile = (Get-ChildItem -Path .\Source\*.md -Recurse | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName
Write-Host "##teamcity[setParameter name='env.LATEST_MD_FILE' value='$latestFile']"