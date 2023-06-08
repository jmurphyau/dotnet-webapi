FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN mkdir -p /app/{source,build,publish,run}

COPY src Properties dotnet-webapi.csproj appsettings.json /app/source/
COPY scripts/*.sh /app/run/

RUN dotnet restore "/app/source/dotnet-webapi.csproj"
RUN dotnet build "/app/source/dotnet-webapi.csproj" -c Release -o /app/build
RUN dotnet publish "/app/source/dotnet-webapi.csproj" -c Release -o /app/publish /p:UseAppHost=false

WORKDIR /app/run

EXPOSE 443

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD [ "dotnet", "/app/publish/dotnet-webapi.dll" ]
