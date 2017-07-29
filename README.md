# PiGDrive
Google Drive as a kodi addon for Raspberry Pi using https://github.com/odeke-em/drive

## Installation:
- Download addon from [releases page](https://github.com/bite-your-idols/script.pigdrive/releases), copy to your Raspberry Pi 2/3 running Kodi. Go to addons and install from zip.

- Go to addon settings, write path to Drive folder you want to sync (root by default), the folder you want to sync in your pi and then select "Drive installation". You will need to complete this installation step using ssh in order to allow Gdrive to access your account. You must exec this command: 

> sh /storage/.kodi/addons/script.pigdrive/resources/bin/pigdrive.sh setup

- An activation url will prompt, you need to copy it and paste into your PC browser. Then click allow and copy the key code that will appear in the browser. Finally you just paste that key code into console and press enter.

- If everything went ok, you will get a resume of your cloud data. You can now close the console and go back to Kodi.
