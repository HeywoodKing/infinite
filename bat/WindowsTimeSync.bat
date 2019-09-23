w32tm /config /manualpeerlist:time.windows.com /syncfromflags:MANUAL

w32tm /config /update

w32tm /resync