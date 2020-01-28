#
# This image contains all necessary programs to build a cura-build-environment.
# The main compilers included are:
#  - VS 2015 (suitable for Python 3.5)
#  - Windows SDK 8.1
#  - MinGW64 8
#  - NSIS
#  - WIX
#
FROM mcr.microsoft.com/windows/servercore:1809-amd64

LABEL windows_version="1809" \
    architecture="amd64" \
    vs_version="2015" \
    windows_sdk_version="8.1"

# Install chocolatey
RUN powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# Enable global confirmation
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    choco feature enable -n=allowGlobalConfirmation

# Install visual studio
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    choco install -y vcredist140; \
    choco install -y vcbuildtools --execution-timeout 18000 -ia "/Full"

# Install other build tools
#  - perl, svn, and nasm are needed by OpenSSL for Python
#  - MinGW64 8.1.0 posix seh.
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    choco install -y 7zip; \
    choco install -y cmake --installargs 'ADD_CMAKE_TO_PATH=System'; \
    choco install -y git --params '/GitOnlyOnPath /NoAutoCrlf /SChannel'; \
    choco install -y nsis; \
    choco install -y strawberryperl; \
    choco install -y tortoisesvn; \
    choco install -y nasm; \
    choco install -y mingw; \
    choco install -y doxygen.install; \
    choco install -y poedit

COPY *.ps1 C:/

# Get WiX Toolset 3.11.2
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    "%CURA_BUILD_ENV_WORK_DIR%"\\src\\docker\\windows\\base-vs2015\\install_wixtoolset.ps1

# Set up environment variables.
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    "%CURA_BUILD_ENV_WORK_DIR%"\\src\\docker\\windows\\base-vs2015\\setup_envvars.ps1

# Cleanup
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    Remove-Item -Force C:\\*.ps1
