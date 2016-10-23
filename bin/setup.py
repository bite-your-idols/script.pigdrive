import os
# import os.path
import xbmcgui

xbmcgui.Dialog().ok("PiGDrive", "To install Google drive you need to connect pi using ssh, exec this command and follow the instructions: 'sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh setup'")

# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

# os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh setup &> /storage/.kodi/userdata/addon_data/script.pigdrive/pigdrive.log")

# xbmcgui.Dialog().ok("PiGDrive", "Lorem ipsum...")