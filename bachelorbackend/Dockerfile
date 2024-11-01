FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["bachelorbackend/bachelorbackend.csproj", "bachelorbackend/"]
RUN dotnet restore "bachelorbackend/bachelorbackend.csproj"
COPY . .
WORKDIR "/src/bachelorbackend"
RUN dotnet build "bachelorbackend.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "bachelorbackend.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "bachelorbackend.dll"]
