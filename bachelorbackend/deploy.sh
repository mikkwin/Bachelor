echo "Bygger app..."
dotnet publish -r linux-x64 --self-contained false


echo "Overfører build til server"
scp -r C:/Users/poizo/RiderProjects/bachelorbackend_temp/bachelorbackend/bin/Debug/net6.0/linux-x64/* root@140.82.33.21:/root/bachelor
#scp -r C:/Users/poizo/RiderProjects/bachelorbackend_temp/bachelorbackend/bachelor.db root@140.82.33.21:/root/bachelor
#scp -r C:/Users/poizo/RiderProjects/bachelorbackend_temp/bachelorbackend/bachelor.db root@140.82.33.21:/root/bachelor/publish


echo "Fuldendt!"