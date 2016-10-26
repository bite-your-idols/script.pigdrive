import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "Do you want to download your Google Drive folder data to local storage? Local files not present in cloud will be deleted.")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh download")

# xbmcgui.Dialog().ok("PiGDrive", "Lorm ipsum...")