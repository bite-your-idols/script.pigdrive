import xbmcaddon
import xbmcgui
# import xbmcplugin
import os
# import os.path
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


# miramos si hay alguna accion
args = urlparse.parse_qs(sys.argv[2][1:])
command = args['com'][0] if 'com' in args else 'EXEC_ADDON'

if command == 'SETUP':
 xbmcgui.Dialog().ok("PiGDrive", "To install Google Drive you need to connect to your RPi using ssh, exec this command and follow the instructions: 'sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh setup'")

elif command == 'UPLOAD':
 xbmcgui.Dialog().ok("PiGDrive", "Do you want to upload your local data to Google Drive? All files in cloud not present in local folder will be deleted.")

 # script_file = os.path.realpath(__file__)
 # directory = os.path.dirname(script_file)

 os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh upload")

 # xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")

elif command == 'DOWNLOAD':
 xbmcgui.Dialog().ok("PiGDrive", "Do you want to download your cloud local data to local storage? All files in local storage not present in cloud will be deleted.")

 # script_file = os.path.realpath(__file__)
 # directory = os.path.dirname(script_file)

 os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh upload")

 # xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")
 
elif command == 'SYNC':
 xbmcgui.Dialog().ok("PiGDrive", "This will download your cloud files, execute active actions and then, upload the local folder to the cloud.")

 # script_file = os.path.realpath(__file__)
 # directory = os.path.dirname(script_file)

 os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh sync")

 # xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")
 
elif command == 'TORRENTS':
 xbmcgui.Dialog().ok("PiGDrive", "Do you want to move your torrent files to Transmission watchfolder?")

 # script_file = os.path.realpath(__file__)
 # directory = os.path.dirname(script_file)

 os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh torrents")

 # xbmcgui.Dialog().ok("PiGDrive", "Lorm ipsum...")
 
elif command == 'PHOTOS':
 xbmcgui.Dialog().ok("PiGDrive", "Do you want to download/backup your Google Photos to local storage?")

 # script_file = os.path.realpath(__file__)
 # directory = os.path.dirname(script_file)

 os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh photos")

 # xbmcgui.Dialog().ok("PiGDrive", "Lorm ipsum...")
 
else:
 xbmcaddon.Addon(id='script.pigdrive').openSettings()
