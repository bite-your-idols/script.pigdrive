import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "Do you want to download your Google Drive folder data to local storage?")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh download &> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log")

# xbmcgui.Dialog().ok("PiGDrive", "Lorm ipsum...")