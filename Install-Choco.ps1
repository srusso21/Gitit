Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install Dashlane                  -y
choco install Firefox                   -y
choco install 7zip                      -y
choco install rdcman                    -y
choco install rsat                      -y
choco install rufus                     -y
choco install sysinternals              -y
choco install github-desktop -y