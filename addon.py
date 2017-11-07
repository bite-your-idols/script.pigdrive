import xbmc
import xbmcaddon
import xbmcgui
import xbmcplugin
import os
import sys
import os.path
import urlparse
 
# addon       = xbmcaddon.Addon()
# addonname   = addon.getAddonInfo('name')
# addonid 	= addon.getAddonInfo('id')
# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

# cloudPath = xbmcplugin.getSetting(int(sys.argv[1]),'cloudpath')
# torrentPath = xbmcplugin.getSetting(int(sys.argv[1]),'torrentpath')
# localPath = xbmcplugin.getSetting(int(sys.argv[1]),'localpath')
# torrentCatcher = xbmcplugin.getSetting(int(sys.argv[1]),'torrentCatcher')

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
 
else:
	xbmcaddon.Addon(id='script.pigdrive').openSettings()
