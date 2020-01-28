# Set up environment variables for the cura-build-environment docker image.

# chocolatey doesn't seem to add NSIS to PATH, so we add it here.
$newPath = "$env:Path"
$newPath = "$newPath" + ";C:\Program Files (x86)\wixtoolset"
$newPath = "$newPath" + ";C:\Program Files (x86)\NSIS"
$newPath = "$newPath" + ";C:\Program Files (x86)\Poedit\GettextTools\bin"
[Environment]::SetEnvironmentVariable("Path", "$newPath", [System.EnvironmentVariableTarget]::Machine)
