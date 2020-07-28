FROM jenkins/jnlp-slave

USER 0
ARG JENKINSUID=1000
ARG JENKINSGID=1000
ARG DOCKERGID=998

#.net
RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https apt-utils \
    && apt-get update \
    && apt-get install -y dotnet-sdk-3.1 aspnetcore-runtime-3.1

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

# Setup users and groups
RUN addgroup --gid ${DOCKERGID} docker
RUN usermod -aG docker jenkins

USER 1000

RUN IMAGE_VERSION=1

ENTRYPOINT tail -f /dev/null