#!/bin/bash
#documentation: https://github.com/odeke-em/drive
echo '::PiGDrive:: -> sync on ' $(date) &> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
#defining variables
ACTION=$1
DRIVE_FILE="/storage/.kodi/addons/script.pigdrive/bin/drive"
SETTINGS_FILE="/storage/.kodi/userdata/addon_data/script.pigdrive/settings.xml"
USER_SETTINGS=$(cat $SETTINGS_FILE)
# <settings>
#     <setting id="autostart" value="true" />
#     <setting id="cloudpath" value="" />
#     <setting id="localpath" value="/storage/downloads/" />
#     <setting id="torrentcatcher" value="true" />
#     <setting id="torrentpath" value="/path/to/my/watchlist/" />
# </settings>
AUTOSTART=$(echo $USER_SETTINGS | sed -e 's~.*id="autostart" value="\(.*\)" /> <setting id="cloudpath.*~\1~')
CLOUD_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="cloudpath" value="\(.*\)" /> <setting id="localpath.*~\1~')
LOCAL_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="localpath" value="\(.*\)" /> <setting id="torrentcatcher.*~\1~')
TORRENT_CATCHER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentcatcher" value="\(.*\)" /> <setting id="torrentpath.*~\1~')
TORRENT_FOLDER=$(echo $USER_SETTINGS | sed -e 's~.*id="torrentpath" value="\(.*\)/" /> </settings>.*~\1~')

echo "Action -> "$ACTION >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Autostart -> "$AUTOSTART >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Cloud Folder -> "$CLOUD_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Local Folder -> "$LOCAL_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Torrent Catcher -> "$TORRENT_CATCHER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
echo "Torrent Watchfolder -> "$TORRENT_FOLDER >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

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

		#meter el auto start en el arranque de kodi
		echo '(	sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh sync ) &' >> /storage/.config/autostart.sh

		echo $DRIVE quota
		echo $DRIVE quota >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
	;;

	"upload")  
    	# forzamos el push desde settings 
    	echo "Upload" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	$DRIVE_FILE push -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	kodi-send --action=Notification"(PiGDrive,Local pushed to Drive,2000,/storage/.kodi/addons/script.gamestarter/icon.png)"
	;;

	"download")  
    	# forzamos el pull desde settings 
    	echo "Download" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	$DRIVE_FILE pull -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
    	kodi-send --action=Notification"(PiGDrive,Drive pulled to local,2000,/storage/.kodi/addons/script.gamestarter/icon.png)"
	;;

	# "torrents")  
	# 	# forzamos coger los torrent desde settings 
	# ;;

	*)  
		if [ $AUTOSTART == 'true' ] || [ $ACTION == "sync" ]; then
			# lo que se ejecuta por defecto al arrancar kodi o al activar torrent
			echo "Sync" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
			
			$DRIVE_FILE pull -files --no-clobber --exclude-ops delete -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

			# checkeamos que tiene marcado torrentcatcher en true
			if [ $TORRENT_CATCHER == 'true' ]; then
				echo "Torrent" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log
				#entramos a la carpeta de destino, por si no es la raiz, para mover los torrent a la carpeta del transmission
				# echo "movemos los torrents"
				cd $LOCAL_FOLDER/$CLOUD_FOLDER
				mv *.torrent "$TORRENT_FOLDER"
				cd $LOCAL_FOLDER
			fi 

			#subimos a drive lo que queda aqui, 
			$DRIVE_FILE push -files -quiet -depth 2 "$CLOUD_FOLDER" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

		fi
  	;;
esac

echo "Finished" >> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log

# COSITAS

# comparar la diferencia entre archivos/carpetas
# $DRIVE diff "$FOLDER"

# lkstar archivos en un directorio de la nube
# $DRIVE list "$FOLDER"

# information about your drive, such as the account type, bytes used/free, and the total amount of storage available.
# $DRIVE quota

# bajar de la nube una carpeta
# $DRIVE_FILE pull --no-clobber --exclude-ops delete -quiet "$CLOUD_FOLDER"
