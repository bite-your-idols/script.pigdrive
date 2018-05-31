#!/bin/bash
#documentation: https://github.com/odeke-em/drive
echo '::PiGDrive:: -> sync on ' $(date) &> /storage/.kodi/temp/pigdrive.log
#defining variables
ACTION=$1
DRIVE_FILE="/storage/.kodi/addons/script.pigdrive/resources/bin/drive"
# SETTINGS_FILE="/storage/.kodi/userdata/addon_data/script.pigdrive/settings.xml"
SETTINGS_FILE="/storage/.kodi/userdata/addon_data/script.pigdrive/settings.txt"
USER_SETTINGS=$(cat $SETTINGS_FILE)

# habria que ejecutar este script y depues abrir el archivo /storage/.kodi/addons/script.pigdrive/settings.txt para ceger las settings
kodi-send --action="RunScript(script.pigdrive, SETTINGS)" >> /storage/.kodi/temp/pigdrive.log

sleep 1

NUM=1
# echo "-----------------------------------" >> /storage/.kodi/temp/pigdrive.log
# declare -a Settings="()"
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$line" #>> /storage/.kodi/temp/pigdrive.log
    if [ $NUM == 1 ]; then
    	# Settings[$NUM]='"$line"'
    	# Settings=(${Settings[@]} $line)
    	AUTOSTART="$line"
    elif [ $NUM == 2 ]; then
    	CLOUD_FOLDER="$line"
    elif [ $NUM == 3 ]; then
    	LOCAL_FOLDER="$line"
    elif [ $NUM == 4 ]; then
    	TORRENT_FOLDER="$line"
    elif [ $NUM == 5 ]; then
    	TORRENT_CATCHER="$line"
    elif [ $NUM == 6 ]; then
    	PHOTOS_CLOUD_FOLDER="$line"
    elif [ $NUM == 7 ]; then
    	PHOTOS_LOCAL_FOLDER="$line"
    elif [ $NUM == 8 ]; then
    	PHOTOS_CATCHER="$line"
    fi
    # echo $NUM
    let "NUM++"
done < "$SETTINGS_FILE"
rm "$SETTINGS_FILE"
# echo "-----------------------------------" >> /storage/.kodi/temp/pigdrive.log

#tendria que hacer un array con cada linea y luego asignarselo a cada variable de bash.

# EJEMPLO DE SWTTINGS BYPASEADO A TXT
# autostart:'true'
# cloudPath:''
# localPath:'/storage/downloads/'
# torrentPath:'/var/media/HDD_2T/Watchlist/- INCOMING/'
# torrentCatcher:'true'
# photoscloudpath:'Google Fotos'
# photoslocalpath:'/var/media/HDD_2T/Fotos/'
# photosbackup:'true'

# AUTOSTART=${Settings[0]}
# CLOUD_FOLDER=${Settings[1]}
# LOCAL_FOLDER=${Settings[2]}
# TORRENT_FOLDER=${Settings[3]}
# TORRENT_CATCHER=${Settings[4]}
# PHOTOS_CLOUD_FOLDER=${Settings[5]}
# PHOTOS_LOCAL_FOLDER=${Settings[6]}
# PHOTOS_CATCHER=${Settings[7]}


##########################################################

## EJEMPLOS DE SETTINGS EN V1 y V2
# <settings>
#    <setting id="autostart" value="true" />
#    <setting id="cloudpath" value="" />
#    <setting id="localpath" value="/storage/downloads/" />
#    <setting id="photosbackup" value="true" />
#    <setting id="photoscloudpath" value="Google Photos" />
#    <setting id="photoslocalpath" value="/storage/pictures/" />
#    <setting id="torrentcatcher" value="true" />
#    <setting id="torrentpath" value="/var/media/MEDIA_3T/Watchlist/- INCOMING/" />
# </settings>	

# LE9/ KODI 18
# <settings version="2">
#     <setting id="autostart">true</setting>
#     <setting id="cloudpath" default="true"></setting>
#     <setting id="localpath">/storage/downloads/</setting>
#     <setting id="photosbackup">true</setting>
#     <setting id="photoscloudpath">Google Fotos</setting>
#     <setting id="photoslocalpath">/var/media/HDD_2T/Fotos/</setting>
#     <setting id="torrentcatcher">true</setting>
#     <setting id="torrentpath">/var/media/HDD_2T/Watchlist/- INCOMING/</setting>
# </settings>

#xbmcplugin.getSetting(handle, autostart)


## OPCION 1 PARA SACAR LAS SETTINGS, LA V2 lo jode
# 	AUTOSTART=$(echo $USER_SETTINGS | sed -e 's~.*id="autostart" value="\(.*\)" /> <setting id="cloudpath.*~\1~')
# 	CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="cloudpath" value="\(.*\)" /> <setting id="localpath.*~\1~')
# 	LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="localpath" value="\(.*\)" /> <setting id="photosbackup.*~\1~')
# 	PHOTOS_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="photosbackup" value="\(.*\)" /> <setting id="photoscloudpath.*~\1~')
# 	PHOTOS_CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoscloudpath" value="\(.*\)" /> <setting id="photoslocalpath.*~\1~')
# 	PHOTOS_LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoslocalpath" value="\(.*\)" /> <setting id="torrentcatcher.*~\1~')
# 	TORRENT_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentcatcher" value="\(.*\)" /> <setting id="torrentpath.*~\1~')
# 	# si es false la anterior esto deberia quedarse vacio, porque al ser false no se metido en el user settings
# 	TORRENT_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentpath" value="\(.*\)/" /> </settings>.*~\1~')


## OPCION 2 PARA SACAR LAS SETTINGS Y QUE LA V2 NO LO JODA
# tenemos que sacar del USER_SETTINGS la primera linea y ver si es version="2"
# SETTINGS_VERSION=$(echo $USER_SETTINGS | sed -e 's~.*<settings\(.*\)ersion="2">.*~\1~')
# echo $SETTINGS_VERSION >> /storage/.kodi/temp/pigdrive.log

#al loro con el orden alfabetico de las settings si metemos alguna nueva
# if [ $SETTINGS_VERSION == 'v' ]; then
# 	echo "Settings V2" >> /storage/.kodi/temp/pigdrive.log
# 	AUTOSTART=$(echo $USER_SETTINGS | sed -e 's~.*id="autostart">"\(.*\)"<setting> <setting id="cloudpath.*~\1~')
# 	#esta tiene su miga porque si es default es true y sino mete la ruta...
# 	CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="cloudpath" value="\(.*\)"<setting> <setting id="localpath.*~\1~')
# 	LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="localpath">\(.*\)"<setting> <setting id="photosbackup.*~\1~')
# 	PHOTOS_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="photosbackup">\(.*\)"<setting> <setting id="photoscloudpath.*~\1~')
# 	PHOTOS_CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoscloudpath">\(.*\)<setting> <setting id="photoslocalpath.*~\1~')
# 	PHOTOS_LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoslocalpath">\(.*\)<setting> <setting id="torrentcatcher.*~\1~')
# 	TORRENT_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentcatcher">\(.*\)<setting> <setting id="torrentpath.*~\1~')
# 	# si es false la anterior esto deberia quedarse vacio, porque al ser false no se metido en el user settings
# 	TORRENT_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentpath">\(.*\)/<setting> <settings>.*~\1~')
# else
# 	echo "Settings V1" >> /storage/.kodi/temp/pigdrive.log
# 	AUTOSTART=$(echo $USER_SETTINGS | sed -e 's~.*id="autostart" value="\(.*\)" /> <setting id="cloudpath.*~\1~')
# 	CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="cloudpath" value="\(.*\)" /> <setting id="localpath.*~\1~')
# 	LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="localpath" value="\(.*\)" /> <setting id="photosbackup.*~\1~')
# 	PHOTOS_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="photosbackup" value="\(.*\)" /> <setting id="photoscloudpath.*~\1~')
# 	PHOTOS_CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoscloudpath" value="\(.*\)" /> <setting id="photoslocalpath.*~\1~')
# 	PHOTOS_LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoslocalpath" value="\(.*\)" /> <setting id="torrentcatcher.*~\1~')
# 	TORRENT_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentcatcher" value="\(.*\)" /> <setting id="torrentpath.*~\1~')
# 	# si es false la anterior esto deberia quedarse vacio, porque al ser false no se metido en el user settings
# 	TORRENT_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentpath" value="\(.*\)/" /> </settings>.*~\1~')
# fi 

##########################################################

echo "" >> /storage/.kodi/temp/pigdrive.log
echo "VARIABLES -----------------------" >> /storage/.kodi/temp/pigdrive.log
echo "Action -> "$ACTION  >> /storage/.kodi/temp/pigdrive.log
echo "Autostart -> "$AUTOSTART  >> /storage/.kodi/temp/pigdrive.log
echo "Cloud Folder -> "$CLOUD_FOLDER  >> /storage/.kodi/temp/pigdrive.log
echo "Local Folder -> "$LOCAL_FOLDER  >> /storage/.kodi/temp/pigdrive.log
echo "Torrent Catcher -> "$TORRENT_CATCHER  >> /storage/.kodi/temp/pigdrive.log
echo "Torrent Watchfolder -> "$TORRENT_FOLDER  >> /storage/.kodi/temp/pigdrive.log
echo "Photos Cloud Folder -> "$PHOTOS_CLOUD_FOLDER  >> /storage/.kodi/temp/pigdrive.log
echo "Photos Local Folder -> "$PHOTOS_LOCAL_FOLDER  >> /storage/.kodi/temp/pigdrive.log
echo "Photos Catcher -> "$PHOTOS_CATCHER  >> /storage/.kodi/temp/pigdrive.log
echo "VARIABLES END -----------------------" >> /storage/.kodi/temp/pigdrive.log
echo "" >> /storage/.kodi/temp/pigdrive.log

# exit 1

function getTorrents {
	# echo "movemos los torrents"
	#entramos a la carpeta de destino, por si no es la raiz, para mover los torrent a la carpeta del transmission
	cd $LOCAL_FOLDER/$CLOUD_FOLDER
	mv *.torrent "$TORRENT_FOLDER"
	cd $LOCAL_FOLDER
}

function getPhotos {
	# opcion alternativa -> comprobar las fotos que no estan y bajarlas
	# $echo $DRIVE_FILE list --no-prompt -depth -1 "$PHOTOS_CLOUD_FOLDER"

	# no se si este mkdir esta bien...
	mkdir "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"

	# hay que arreglar esto, necesitamos hacer bien el symlink, no crea las carpetas intermedias...
	if [ ! -L "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" ]; then
	    # ln -s "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" 
	    ln -s "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" 
	fi

	# $echo $DRIVE_FILE pull --no-clobber --exclude-ops delete -quiet -depth -1 "$PHOTOS_CLOUD_FOLDER" >> /storage/.kodi/temp/pigdrive.log
	$echo $DRIVE_FILE pull --no-clobber --exclude-ops delete -depth -1 -ignore-name-clashes "$PHOTOS_CLOUD_FOLDER" >> /storage/.kodi/temp/pigdrive.log

}

#entramos en la carpeta donde tenemos el drive
cd $LOCAL_FOLDER
chmod a+x $DRIVE_FILE

case $ACTION in
	"setup")
		# PiGDrive installation setup
		echo "Setup" >> /storage/.kodi/temp/pigdrive.log
		chmod a+x $DRIVE_FILE
		$DRIVE_FILE init "$LOCAL_FOLDER"

		#copy the link and paste in browser
		#click "allow"
		#copy given code and paste in console

		#meter el auto start en el arranque de kodi -> probar esto, si es necesario esperar a kodi o no
		# echo '(	sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh) &' >> /storage/.config/autostart.sh
		echo '( sleep 1m && sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh ) &' >> /storage/.config/autostart.sh

		$DRIVE_FILE quota
		$DRIVE_FILE quota >> /storage/.kodi/temp/pigdrive.log
	;;

	"upload")  
    	# forzamos el push desde settings 
    	echo "Upload" >> /storage/.kodi/temp/pigdrive.log
    	$DRIVE_FILE push -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/temp/pigdrive.log
    	kodi-send --action=Notification"(PiGDrive,Local pushed to Drive,2000,/storage/.kodi/addons/script.pigdrive/icon.png)"
	;;

	"download")  
    	# forzamos el pull desde settings 
    	echo "Download" >> /storage/.kodi/temp/pigdrive.log
    	$DRIVE_FILE pull -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/temp/pigdrive.log
    	kodi-send --action=Notification"(PiGDrive,Drive pulled to local,2000,/storage/.kodi/addons/script.pigdrive/icon.png)"
	;;

	"torrents")  
		echo "Torrents" >> /storage/.kodi/temp/pigdrive.log
	 	# forzamos coger los torrent desde settings 
		getTorrents
	;;
	
	"photos")  
    	# forzamos descargar photos desde settings 
    	echo "Photos" >> /storage/.kodi/temp/pigdrive.log
    	getPhotos
    	kodi-send --action=Notification"(PiGDrive,Goolge Photos download complete,2000,/storage/.kodi/addons/script.pigdrive/icon.png)"
	;;
	

	*)  
		if [ $AUTOSTART == 'true' ] || [ $ACTION == "sync" ]; then
			# lo que se ejecuta por defecto al arrancar kodi o al activar torrent
			echo "Sync" >> /storage/.kodi/temp/pigdrive.log
			
			# $DRIVE_FILE pull -files --no-clobber --exclude-ops delete -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/temp/pigdrive.log
			$DRIVE_FILE pull -files --no-clobber -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/temp/pigdrive.log


			# checkeamos que tiene marcado torrentcatcher en true, no se porque no pilla esta variable...
			if [ $TORRENT_CATCHER == 'true' ]; then
				echo "Torrent" >> /storage/.kodi/temp/pigdrive.log
				getTorrents
			fi 
			
			# checkeamos que tiene marcado google photos en true
			if [ $PHOTOS_CATCHER == 'true' ]; then
				echo "Google Photos" >> /storage/.kodi/temp/pigdrive.log
				getPhotos
			fi 

			#subimos a drive lo que queda aqui, 
			$DRIVE_FILE push -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/temp/pigdrive.log

		fi
  	;;
esac

echo "Finished" >> /storage/.kodi/temp/pigdrive.log

# EJEMPLOS

# comparar la diferencia entre archivos/carpetas
# $echo $DRIVE_FILE diff "$FOLDER"

# listar archivos en un directorio de la nube
# $echo $DRIVE_FILE list "$FOLDER"

# information about your drive, such as the account type, bytes used/free, and the total amount of storage available.
# $echo $DRIVE_FILE quota

# bajar de la nube una carpeta
# $DRIVE_FILE pull --no-clobber --exclude-ops delete -quiet "$CLOUD_FOLDER"
