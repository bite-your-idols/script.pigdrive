import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "Do you want to download your Google Drive torent files and move them to Transmission' watchfolder?")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh torrents &> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log")

# xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")