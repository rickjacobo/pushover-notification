FROM mcr.microsoft.com/powershell:ubuntu-20.04

EXPOSE 80

ENV ENV_PUSHOVER_URL="https://api.pushover.net/1/messages.json"
ENV ENV_PUSHOVER_USER="1234567890"
ENV ENV_PUSHOVER_TOKEN="1234567890"

RUN apt update
RUN apt install vim -y
RUN mkdir /powershell
WORKDIR /powershell
COPY powershell.ps1 /powershell
COPY handler.ps1 /powershell
CMD pwsh ./handler.ps1