import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "Do you want to upload your local data to Google Drive? All files in cloud not present in local foder will be deleted.")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh upload")

# xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")