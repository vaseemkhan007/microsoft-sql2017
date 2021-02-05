# Base OS layer: Latest Ubuntu 16.04 LTS

FROM vkitpro/ubuntu16.04

LABEL maintainer="Vaseem Khan"

# apt-get and system utilities
RUN apt-get update && apt-get install -y ca-certificates --no-install-recommends apt-utils \
	curl apt-transport-https debconf-utils \
	unixodbc-dev -y \
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list > /etc/apt/sources.list.d/mssql-release.list
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/msprod.list

# install SQL Server
RUN apt-get update
RUn apt-get install -y mssql-server 

# install SQL Server drivers and tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql mssql-tools 
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8


# Default SQL Server TCP/Port.
EXPOSE 1433

# Run SQL Server process.
CMD [ "/opt/mssql/bin/sqlservr" ]
