import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "Do you want to upload your local data to Google Drive?")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh upload &> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log")

# xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")