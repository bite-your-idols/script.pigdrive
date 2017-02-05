import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "Do you want to move your torrent files to Transmission watchfolder?")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh torrents")

# xbmcgui.Dialog().ok("PiGDrive", "Lorm ipsum...")
