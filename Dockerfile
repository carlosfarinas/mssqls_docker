# build from the Ubuntu 18.04 image
FROM ubuntu:20.04
 
# create the mssql user
RUN useradd -u 10001 mssql
 
# installing SQL Server
RUN apt-get update
RUN apt-get install -y wget software-properties-common apt-transport-https
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
RUN apt-get update && apt-get install -y mssql-server


RUN apt-get -y install curl
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev

#RUN apt-get update && ACCEPT_EULA=Y apt-get install mssql-tools unixodbc-dev
 
# creating directories
RUN mkdir /var/opt/sqlserver
RUN mkdir /var/opt/sqlserver/data
RUN mkdir /var/opt/sqlserver/log
RUN mkdir /var/opt/sqlserver/backup
 
# set permissions on directories
RUN chown -R mssql:mssql /var/opt/sqlserver
RUN chown -R mssql:mssql /var/opt/mssql
 
# switching to the mssql user
USER mssql
 
# starting SQL Server
CMD /opt/mssql/bin/sqlservr
