# Microsoft Linux SQL 2017
Image contains the MSSQL 2017 Linux (Ubuntu 16.04) Server, with sql tools (sqlcmd, bcp)

# Requirements

Requires the following environment flags

`ACCEPT_EULA=Y`

`SA_PASSWORD=<your_strong_password>`

`MSSQL_PID=<your_product_id | edition_name> (default: Developer)`

A strong system administrator (SA) password: At least 8 characters including uppercase, lowercase letters, base-10 digits and/or non-alphanumeric symbols.

# How to run container from image

`$ docker run --name container_name -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=strongpassword' -p 1433:1433 -d vkitpro/microsoft-linux-sql2017:latest`

# Connecting to container
`$ docker exec -it container_name /bin/bash`

Connect to Microsoft SQL Server You can connect to the SQL Server using the sqlcmd tool inside of the container by using the following command on the host:

`docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>`
# Enabling SQL Agent
`sudo docker exec -it container_name /opt/mssql/bin/mssql-conf set sqlagent.enabled true`
# Setting up memory limit for the SQL to use
`sudo docker exec -it container_name /opt/mssql/bin/mssql-conf set memory.memorylimitmb 28000`
# Resetting the password
`sudo docker exec -it container_name /opt/mssql-tools/bin/sqlcmd \
   -S localhost -U SA -P '<YourStrong!Passw0rd>' \
   -Q 'ALTER LOGIN SA WITH PASSWORD="<YourNewStrong!Passw0rd>"'`
