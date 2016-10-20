import xbmcaddon
import xbmcgui
import os
import os.path
 
addon       = xbmcaddon.Addon()
addonname   = addon.getAddonInfo('name')

os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh")