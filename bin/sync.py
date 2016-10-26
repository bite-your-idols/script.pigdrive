import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "This will download your cloud files, execute activate actions and then, upload the local folder to the cloud.")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh sync")

# xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")