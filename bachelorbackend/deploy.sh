echo "Bygger app..."
dotnet publish -r linux-x64 --self-contained false


echo "Overfører build til server"
scp -r A:/RiderProjects/bachelorbackend/bachelorbackend/bin/Debug/net6.0/linux-x64/* root@140.82.33.21:/root/bachelor

echo "Fuldendt!"