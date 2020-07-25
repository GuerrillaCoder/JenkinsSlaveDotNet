FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

# Docker
RUN apt-get update \
    && apt-get install software-properties-common apt-transport-https ca-certificates gnupg-agent -y \ 
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" \
    && apt-get update \
    && apt-get install docker-ce-cli -y

# Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs 

ENTRYPOINT tail -f /dev/null