#!/bin/bash
#documentation: https://github.com/odeke-em/drive

DRIVE_PATH="/storage/.kodi/addons/script.pigdrive/bin/drive"
CLOUD_FOLDER="Raspberry Pi/storage/gdrive/share"
TORRENT_FOLDER="/var/media/SERIES_2T/Watchlist/- INCOMING"
#FOLDER=Raspberry\ Pi/storage/gdrive/share
cd $DRIVE_PATH

#ln -s /storage/gdrive/share "/storage/gdrive/Raspberry Pi/storage/gdrive/share"


#iniciar el porceso, hay que copiar la URL que devuelve enel navegador y pegar la respuesta
#/storage/gdrive/drive init /storage/gdrive/

#bajar de la nube una carpeta
$DRIVE_PATH pull --exclude-ops delete -quiet "$CLOUD_FOLDER"

#subir un archivo de pi a la nube
# /storage/gdrive/drive push --no-clobber --exclude-ops update,delete -destination "$CLOUD_FOLDER" foo.txt
# subiruna carpeta
# $DRIVE push --no-clobber --exclude-ops update,delete -quiet -destination "$FOLDER" "$FOLDER"
$DRIVE_PATH push --exclude-ops delete -quiet "$CLOUD_FOLDER"

cd share
mv *.torrent "$TORRENT_FOLDER"

# comparar la diferencia entre archivos/carpetas
# $DRIVE diff "$FOLDER"

# lkstar archivos en un directorio de la nube
#$DRIVE list "$FOLDER"

#information about your drive, such as the account type, bytes used/free, and the total amount of storage available.
#$DRIVE quota
