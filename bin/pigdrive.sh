#!/bin/bash
#documentation: https://github.com/odeke-em/drive

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

echo "Action -> "$ACTION
echo "Autostart ->"$AUTOSTART
echo "Cloud Folder ->"$CLOUD_FOLDER
echo "Local Folder ->"$LOCAL_FOLDER
echo "Torrent Catcher ->"$TORRENT_CATCHER
echo "Torrent Watchfolder ->"$TORRENT_FOLDER

case $ACTION in
	"setup") 
		# PiGDrive installation setup
		chmod a+x $DRIVE_FILE
		cd $LOCAL_FOLDER
		$DRIVE_FILE init "$LOCAL_FOLDER"

		#copy the link and paste in browser
		#click "allow"
		#copy given code and paste in console

		#meter el auto start en el arranque de kodi
		echo '(	sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh auto ) &' >> /storage/.config/autostart.sh
	;;

	"upload")  
    	# forzamos el push desde settings 
    	kodi-send --action=Notification"(PiGDrive,Up-to-date,2000,/storage/.kodi/addons/script.gamestarter/icon.png)"
	;;

	"download")  
    	# forzamos el pull desde settings 
    	kodi-send --action=Notification"(PiGDrive,Up-to-date,2000,/storage/.kodi/addons/script.gamestarter/icon.png)"
	;;

	# "torrents")  
	# 	# forzamos coger los torrent desde settings 
	# ;;

	*)  
		# lo que se ejecuta por defecto al arrancar kodi

		#entramos en la carpeta donde tenemos el drive
		cd $LOCAL_FOLDER

		$DRIVE_FILE pull -files -quiet -depth 2 "$CLOUD_FOLDER"

		# listamos los archivos que hay en la carpeta
		#LISTADO_ARCHIVOS=$($DRIVE_FILE ls -files $CLOUD_FOLDER)

		#si hemos puesto la raiz de drive hay que detectar que mete por defecto MI unidad
		# if [ $CLOUD_FOLDER = ""] 
		# then
		# 	SPLITTER="/Mi unidad/" #habria que hacer algo generico para todos los idiomas
		# else
		# 	SPLITTER=$CLOUD_FOLDER"/"
		# fi

		# echo $SPLITTER

		# recorremos el listado de archivos y los vamos bajando de uno en uno, esto es porque en root no deja bajar todos de golpe
		# for str in ${LISTADO_ARCHIVOS//"$SPLITTER"} ; do 
		#    echo "Bajamos -> $str"
		#    $DRIVE_FILE pull -quiet "$CLOUD_FOLDER$str"
		#    # aqui habria que borrarlos uno a uno para luego al subirlos eliminar los torrents
		# done

		# checkeamos que tiene marcado torrentcatcher en true
		if [ $TORRENT_CATCHER = 'true' ]; then
			#entramos a la carpeta de destino, por si no es la raiz, para mover los torrent a la carpeta del transmission
			# echo "movemos los torrents"
			cd $LOCAL_FOLDER/$CLOUD_FOLDER
			mv *.torrent "$TORRENT_FOLDER"
			cd $LOCAL_FOLDER
		fi 

		#subimos a drive lo que queda aqui, 
		$DRIVE_FILE push -files -quiet -depth 2 "$CLOUD_FOLDER" 

		# habria que borrar los torrents de drive pero con pull de cada archivo no se puede, habrai que hacer un pull de todo pero enroot no funciona...
		# for archivo in $CLOUD_FOLDER*; do
		# 	#echo "--- $archivo"
		# 	if [[ -f $archivo ]]; then
		#   		echo "Subimos -> $archivo"
		#   		 $DRIVE_FILE push -quiet "$archivo"
		#   	fi
		# done
  ;;
esac


# COSITAS

# comparar la diferencia entre archivos/carpetas
# $DRIVE diff "$FOLDER"

# lkstar archivos en un directorio de la nube
#$DRIVE list "$FOLDER"

#information about your drive, such as the account type, bytes used/free, and the total amount of storage available.
#$DRIVE quota

#bajar de la nube una carpeta
# $DRIVE_FILE pull --exclude-ops delete -quiet "$CLOUD_FOLDER"

#subir un archivo de pi a la nube
# /storage/gdrive/drive push --no-clobber --exclude-ops update,delete -destination "$CLOUD_FOLDER" foo.txt
# subiruna carpeta
# $DRIVE push --no-clobber --exclude-ops update,delete -quiet -destination "$FOLDER" "$FOLDER"

#$DRIVE_FILE push --exclude-ops delete -quiet "$CLOUD_FOLDER"