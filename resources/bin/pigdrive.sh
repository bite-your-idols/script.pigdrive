#!/bin/bash
#documentation: https://github.com/odeke-em/drive
echo '::PiGDrive:: -> sync on ' $(date) &> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
#defining variables
ACTION=$1
DRIVE_FILE="/storage/.kodi/addons/script.pigdrive/resources/bin/drive"
SETTINGS_FILE="/storage/.kodi/userdata/addon_data/script.pigdrive/settings.xml"
USER_SETTINGS=$(cat $SETTINGS_FILE)
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

#al loro con el orden alfabetico de las settings si metemos alguna nueva
AUTOSTART=$(echo $USER_SETTINGS | sed -e 's~.*id="autostart" value="\(.*\)" /> <setting id="cloudpath.*~\1~')
CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="cloudpath" value="\(.*\)" /> <setting id="localpath.*~\1~')
LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="localpath" value="\(.*\)" /> <setting id="photosbackup.*~\1~')
PHOTOS_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="photosbackup" value="\(.*\)" /> <setting id="photoscloudpath.*~\1~')
PHOTOS_CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoscloudpath" value="\(.*\)" /> <setting id="photoslocalpath.*~\1~')
PHOTOS_LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="photoslocalpath" value="\(.*\)" /> <setting id="torrentcatcher.*~\1~')
TORRENT_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentcatcher" value="\(.*\)" /> <setting id="torrentpath.*~\1~')
# si es false la anterior esto deberia quedarse vacio, porque al ser false no se metido en el user settings
TORRENT_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentpath" value="\(.*\)/" /> </settings>.*~\1~')


echo "Action -> "$ACTION >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Autostart -> "$AUTOSTART >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Cloud Folder -> "$CLOUD_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Local Folder -> "$LOCAL_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Torrent Catcher -> "$TORRENT_CATCHER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Torrent Watchfolder -> "$TORRENT_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Photos Cloud Folder -> "$PHOTOS_CLOUD_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Photos Local Folder -> "$PHOTOS_LOCAL_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Photos Catcher -> "$PHOTOS_CATCHER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log


function getTorrents {
	# echo "movemos los torrents"
	#entramos a la carpeta de destino, por si no es la raiz, para mover los torrent a la carpeta del transmission
	cd $LOCAL_FOLDER/$CLOUD_FOLDER
	mv *.torrent "$TORRENT_FOLDER"
	cd $LOCAL_FOLDER
}

function getPhotos {
	# opcion 1 -> bajamos todo y lo pasamos a la carpeta
 	# echo "las acciones del backup de gPhotos"
 	# $DRIVE_FILE pull --no-clobber --exclude-ops delete -quiet -depth -1 "$PHOTOS_CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
 	# $echo $DRIVE_FILE pull --no-clobber --exclude-ops delete  -depth -1 "$PHOTOS_CLOUD_FOLDER"
	# despues de bajar la carpeta fotos la movemos al directio local deseado
	# mkdir "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"
	# cp -rf "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"/* "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"
	# rm -rf "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"

	# opcion 2 -> comprobar las fotos que no estan y bajarlas
	# ls -R "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"
	# $echo $DRIVE_FILE list --no-prompt -depth -1 "$PHOTOS_CLOUD_FOLDER"
	mkdir "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"

	# if [[ -L "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"  && -d "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER"  ]]
	# then
	#     echo "symlink exists"
	# else
	# 	ln -s "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" 
	# fi

	if [ ! -L "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" ]; then
	    ln -s "$PHOTOS_LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" "$LOCAL_FOLDER$PHOTOS_CLOUD_FOLDER" 
	fi

	$echo $DRIVE_FILE pull --no-clobber --exclude-ops delete -quiet -depth -1 "$PHOTOS_CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

}

#entramos en la carpeta donde tenemos el drive
cd $LOCAL_FOLDER

case $ACTION in
	"setup")
		# PiGDrive installation setup
		echo "Setup" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
		chmod a+x $DRIVE_FILE
		$DRIVE_FILE init "$LOCAL_FOLDER"

		#copy the link and paste in browser
		#click "allow"
		#copy given code and paste in console

		#meter el auto start en el arranque de kodi -> probar esto, si es necesario esperar a kodi o no
		# echo '(	sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh) &' >> /storage/.config/autostart.sh
		echo '( sleep 1m && sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh ) &' >> /storage/.config/autostart.sh

		$DRIVE_FILE quota
		$DRIVE_FILE quota >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
	;;

	"upload")  
    	# forzamos el push desde settings 
    	echo "Upload" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	$DRIVE_FILE push -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	kodi-send --action=Notification"(PiGDrive,Local pushed to Drive,2000,/storage/.kodi/addons/script.pigdrive/icon.png)"
	;;

	"download")  
    	# forzamos el pull desde settings 
    	echo "Download" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	$DRIVE_FILE pull -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	kodi-send --action=Notification"(PiGDrive,Drive pulled to local,2000,/storage/.kodi/addons/script.pigdrive/icon.png)"
	;;

	"torrents")  
		echo "Torrents" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
	 	# forzamos coger los torrent desde settings 
		getTorrents
	;;
	
	"photos")  
    	# forzamos descargar photos desde settings 
    	echo "Photos" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	getPhotos
    	kodi-send --action=Notification"(PiGDrive,Goolge Photos download complete,2000,/storage/.kodi/addons/script.pigdrive/icon.png)"
	;;
	

	*)  
		if [ $AUTOSTART == 'true' ] || [ $ACTION == "sync" ]; then
			# lo que se ejecuta por defecto al arrancar kodi o al activar torrent
			echo "Sync" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
			
			$DRIVE_FILE pull -files --no-clobber --exclude-ops delete -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

			# checkeamos que tiene marcado torrentcatcher en true
			if [ $TORRENT_CATCHER == 'true' ]; then
				echo "Torrent" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
				getTorrents
			fi 
			
			# checkeamos que tiene marcado google photos en true
			if [ $PHOTOS_CATCHER == 'true' ]; then
				echo "Google Photos" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
				getPhotos
			fi 

			#subimos a drive lo que queda aqui, 
			$DRIVE_FILE push -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

		fi
  	;;
esac

echo "Finished" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

# EJEMPLOS

# comparar la diferencia entre archivos/carpetas
# $echo $DRIVE_FILE diff "$FOLDER"

# listar archivos en un directorio de la nube
# $echo $DRIVE_FILE list "$FOLDER"

# information about your drive, such as the account type, bytes used/free, and the total amount of storage available.
# $echo $DRIVE_FILE quota

# bajar de la nube una carpeta
# $DRIVE_FILE pull --no-clobber --exclude-ops delete -quiet "$CLOUD_FOLDER"
