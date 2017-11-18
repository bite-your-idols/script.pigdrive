import xbmc
import xbmcaddon
import xbmcgui
import xbmcplugin
import os
import sys
import os.path
import urlparse
 
count = len(sys.argv) - 1
 
if count > 0:
	# xbmcgui.Dialog().ok("Status",sys.argv[0] +" called with " + str(count)+" args", "["+", ".join(sys.argv[1:])+"]")
	command = ""+", ".join(sys.argv[1:])+""
	# xbmcgui.Dialog().ok("PiGDrive",  "["+", ".join(sys.argv[1:])+"]")
	
else:
	# xbmcgui.Dialog().ok("Status","no arguments specified")
	command = "FOOO"


# xbmcgui.Dialog().ok("PiGDrive", "GO")
# miramos si hay alguna accion
# args = urlparse.parse_qs(sys.argv[2][1:])
# args = .join(sys.argv[1:])
# args = sys.argv[1:]
# xbmcgui.Dialog().ok("PiGDrive", .join(sys.argv[1:]))
# command = args['com'][0] if 'com' in args else 'EXEC_ADDON'
# xbmcgui.Dialog().ok("PiGDrive",  command)
# command = "FOOO"

if command == 'SETUP':
	xbmcgui.Dialog().ok("PiGDrive", "To install Google Drive you need to connect to your RPi using ssh, exec this command and follow the instructions: 'sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh setup'")

elif command == 'UPLOAD':
	xbmcgui.Dialog().ok("PiGDrive", "Do you want to upload your local data to Google Drive? All files in cloud not present in local folder will be deleted.")
	os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh upload")

elif command == 'DOWNLOAD':
	xbmcgui.Dialog().ok("PiGDrive", "Do you want to download your cloud local data to local storage? All files in local storage not present in cloud will be deleted.")
	os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh download")
 
elif command == 'SYNC':
	xbmcgui.Dialog().ok("PiGDrive", "This will download your cloud files, execute active actions and then, upload the local folder to the cloud.")
	os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh sync")

elif command == 'TORRENTS':
	xbmcgui.Dialog().ok("PiGDrive", "Do you want to move your torrent files to Transmission watchfolder?")
	os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh torrents")
 
elif command == 'PHOTOS':
	xbmcgui.Dialog().ok("PiGDrive", "Do you want to download/backup your Google Photos to local storage?")
	os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh photos")


# GET SETTINGS 
#  kodi-send --action="RunScript(script.pigdrive, SETTINGS)"

elif command == 'SETTINGS':
	autostart = xbmcaddon.Addon(id='script.pigdrive').getSetting('autostart')
	cloudPath = xbmcaddon.Addon(id='script.pigdrive').getSetting('cloudpath')
	localPath = xbmcaddon.Addon(id='script.pigdrive').getSetting('localpath')
	torrentPath = xbmcaddon.Addon(id='script.pigdrive').getSetting('torrentpath')
	torrentCatcher = xbmcaddon.Addon(id='script.pigdrive').getSetting('torrentCatcher')
	photoscloudpath = xbmcaddon.Addon(id='script.pigdrive').getSetting('photoscloudpath')
	photoslocalpath = xbmcaddon.Addon(id='script.pigdrive').getSetting('photoslocalpath')
	photosbackup = xbmcaddon.Addon(id='script.pigdrive').getSetting('photosbackup')

	# msg="autostart:'"+autostart+"'\ncloudPath:'"+cloudPath+"'\nlocalPath:'"+localPath+"'\ntorrentPath:'"+torrentPath+"'\ntorrentCatcher:'"+torrentCatcher+"'\nphotoscloudpath:'"+photoscloudpath+"'\nphotoslocalpath:'"+photoslocalpath+"'\nphotosbackup:'"+photosbackup+"'"
	msg=autostart+"\n"+cloudPath+"\n"+localPath+"\n"+torrentPath+"\n"+torrentCatcher+"\n"+photoscloudpath+"\n"+photoslocalpath+"\n"+photosbackup
	f = open( '/storage/.kodi/userdata/addon_data/script.pigdrive/settings.txt', 'w' )

	f.write( msg)
	f.close()

# elif command == 'SETTINGS_AUTOSTART':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('autostart')
# 	xbmcgui.Dialog().ok("Settings", msg)

# elif command == 'SETTINGS_CLOUDPATH':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('cloudPath')
# 	xbmcgui.Dialog().ok("Settings", msg)

# elif command == 'SETTINGS_LOCALPATH':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('localPath')
# 	xbmcgui.Dialog().ok("Settings", msg)
# 	print(msg)

# elif command == 'SETTINGS_TORRENTPATH':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('torrentPath')
# 	xbmcgui.Dialog().ok("Settings", msg)

# elif command == 'SETTINGS_TORRENTCATCHER':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('torrentCatcher')
# 	xbmcgui.Dialog().ok("Settings", msg)

# elif command == 'SETTINGS_PHOTOSCLOUDPATH':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('photoscloudpath')
# 	xbmcgui.Dialog().ok("Settings", msg)

# elif command == 'SETTINGS_PHOTOSLOCALPATH':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('photoslocalpath')
# 	xbmcgui.Dialog().ok("Settings", msg)

# elif command == 'SETTINGS_PHOTOSBACKUP':
# 	msg= xbmcaddon.Addon(id='script.pigdrive').getSetting('photosbackup')
# 	xbmcgui.Dialog().ok("Settings", msg)


# SINO ES NADA DE ESO LANZAMOS EL ADDON
else:
	xbmcaddon.Addon(id='script.pigdrive').openSettings()
