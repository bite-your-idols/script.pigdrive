import xbmcaddon
import xbmcgui
import xbmcplugin
import os
import os.path
 
addon       = xbmcaddon.Addon()
addonname   = addon.getAddonInfo('name')
script_file = os.path.realpath(__file__)
directory = os.path.dirname(script_file)

cloudPath = xbmcplugin.getSetting(int(sys.argv[1]),'cloudpath')
torrentPath = xbmcplugin.getSetting(int(sys.argv[1]),'torrentpath')
localPath = xbmcplugin.getSetting(int(sys.argv[1]),'localpath')
torrentCatcher = xbmcplugin.getSetting(int(sys.argv[1]),'ask')

# if torrentCatcher == "true":
#  resultado = xbmcgui.Dialog().yesno("PiGDrive", "Copy all torrent files to "+torrentPath+"?");
#  if resultado:
#   #hacemos algo al derle a ok en el dialogo
# else:
#  if frontend=="EmulationStation":
#   os.system(directory+"/resources/bin/gamestarter.sh emulationstation")
#  else:
#   os.system(directory+"/resources/bin/gamestarter.sh retroarch")
  
os.system("sh /storage/.kodi/addons/script.pigdrive/bin/pigdrive.sh")
