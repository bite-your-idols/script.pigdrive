import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "Do you want to download/backup your Google Photos to local storage?")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh photos")

# xbmcgui.Dialog().ok("PiGDrive", "Lorm ipsum...")
