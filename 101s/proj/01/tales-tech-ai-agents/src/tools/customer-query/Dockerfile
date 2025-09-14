# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY ["KTSalesAgent.CustomerQueryServer/KTSalesAgent.CustomerQueryServer.csproj", "KTSalesAgent.CustomerQueryServer/"]
RUN dotnet restore "KTSalesAgent.CustomerQueryServer/KTSalesAgent.CustomerQueryServer.csproj"

# Copy the rest of the source code
COPY . .
WORKDIR /app/KTSalesAgent.CustomerQueryServer
# Build and publish the app
RUN dotnet publish "KTSalesAgent.CustomerQueryServer.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "KTSalesAgent.CustomerQueryServer.dll"]