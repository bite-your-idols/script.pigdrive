import xbmcaddon
# import xbmcgui
# import xbmcplugin
# import os
# import os.path
 
# addon       = xbmcaddon.Addon()
# addonname   = addon.getAddonInfo('name')
# addonid 	= addon.getAddonInfo('id')
# script_file = os.path.realpath(__file__)
# directory = os.path.dirname(script_file)

# cloudPath = xbmcplugin.getSetting(int(sys.argv[1]),'cloudpath')
# torrentPath = xbmcplugin.getSetting(int(sys.argv[1]),'torrentpath')
# localPath = xbmcplugin.getSetting(int(sys.argv[1]),'localpath')
# torrentCatcher = xbmcplugin.getSetting(int(sys.argv[1]),'torrentCatcher')

xbmcaddon.Addon(id='script.pigdrive').openSettings()