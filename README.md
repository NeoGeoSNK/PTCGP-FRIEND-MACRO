# Important

Updated to support add/delete friends from given text file (English version only).

#

![Interface](https://github.com/NeoGeoSNK/PTCGP-FRIEND-MACRO/blob/2bbd98f6692760766989a91ade69c3c7795cd55c/Capture.PNG)

# A friend macro for Pokémon TCG Pocket game by nyu

The code was heavily based on the open-source macro "PtcgP-FriendMacro-GaloXDoido" created by [GaloXDoido](https://github.com/GaloXDoido/PtcgP-FriendMacro-GaloXDoido). & "Banana Macro PtcgP," created by [banana-juseyo](https://github.com/banana-juseyo/Banana-Macro-PtcgP).

#
__ATTENTION!!__

- This script __REQUIRES AutoHotKey v2.0__. You MUST install the updated AutoHotKey 2.0 version to use this script.
- The maximum pending friend request is 30, limited by the game itself.

#
**__How can I get it working?__**

Step 1: Install the necessary programs
- [AutoHotKey v2.0](https://www.autohotkey.com/download/ahk-v2.exe) (It needs to be version 2.0. The macro will not run if you are using earlier versions of AHK.)
- [Global MuMu Player](https://adl.easebar.com/d/g/mumu/c/mumuglobal?type=pc&direct=1)
- [tesseract-ocr](https://github.com/tesseract-ocr/tesseract/releases/download/5.5.0/tesseract-ocr-w64-setup-5.5.0.20241111.exe) (Depended by delete friend feature)
  You need add the tesseract-ocr install location to the **Path** Environment Variables of your system (e.g. C:\Program Files\Tesseract-OCR).

Step 2: Set-Up MuMu Player
- Install
- Recommended Settings **(Bold = Must have)**
  - CPU: 2
  - RAM: 2
  - Less resource usage
  - Forced use of discrete graphics
  - **Custom: 540 x 960 220 dpi**
  - **Screen brightness: 50**
  - **Screen style: Common**
  - FPS: 60
  - **Do not turn on the FPS display**
  - Close system sound
  - **Uncheck: Keep running in the background**
  - **Check: Enable Root Permissions**
  - Exit directly

Step 3: Install the PTCGP game
- Do not move the app from where it is placed on the home screen.
- Manually open the game.

Step 4: Windows settings
- **This macro was made to run with windows on 100% scale.** > Press windows key > Type "display settings" > Look for the scale setting and change it to 100% for all your monitors.
- all windows color filters off
- HDR off

Step 5: 
- Download this Bot zip on the releases tab. [PTCGP-FRIEND-MACRO
](https://github.com/NeoGeoSNK/PTCGP-FRIEND-MACRO/releases)
- Extract it by Right clicking the zip > extract

Step 6: 
- Open **useradd.txt**, input the friend codes you want to add.
- Open **userdel.txt**, input the friend codes you want to delete.

Step 7: 
- Run __FriendMacro.ahk__
- **On first run, the script need download msedge.dll from (https://github.com/banana-juseyo/Banana-Macro-PtcgP). It's too large to include in project itself.**
- **On first run after pressing start, if prompted for super user access in each instance, select to allow forever.**

Step 8: Click on the Cogwheel button (⚙) and input your script settings
- Name of Mumu instance
![Name of Mumu instance](https://github.com/NeoGeoSNK/PTCGP-FRIEND-MACRO/blob/48eb4d57166c75853268699c957507a1e0c49e34/asset/image/instance.PNG)
  **Choose and input your instance name**
- Delay in between actions
- Acceptance time in minutes
- Wait time between the end of acceptance phase and the beginning of deletion phase in minutes
- Language: Only English supported  
- Click Save button to reload app

Step 9: Choose a button to start the macro:

- Button (💕): Begins by adding friends

- Button (🗑️): Start deleting friends
  
 **Allow adb to run and through the firewall if it asks you**


# FAQ

__Q: Does it work on resolutions other than 1920x1080?__

A: It has not been tested on any other resolutions, but the Windows scaling __must be set to 100%__ for it to work correctly.

__Q: Can it be used with multiple instances?__

A: It hasn't been officially tested, but it is possible to copy multiple folders and run them. Some users have reported minor issues, but overall it works well.

__Q: "Error while update" appears when starting the macro.__

A: This can happen due to issues during the automatic update process. Re-download the macro file and try again.


# Modification and Redistribution

This project, as well as the original project it is based on, is licensed under GPL-3.0, allowing modifications and redistribution, provided that proper credit is given to both the original author, __banana-juseyo__, and __GaloXDoido__.

# Credits

Technical Contributions:
 - __"GaloXDoido"__ for the original code on which this macro is based
    [Repository](https://github.com/GaloXDoido/PtcgP-FriendMacro-GaloXDoido)
 - __"banana-juseyo"__ for the original code on which this macro is based
    [Repository](https://github.com/banana-juseyo/Banana-Macro-PtcgP)
 - __"thqby"__ for WebView2 control in AutoHotkey
    [Repository](https://github.com/thqby/ahk2_lib)
 - __"TheArkive"__ for JXON_ahk2
    [Repository](https://github.com/TheArkive/JXON_ahk2)
 - __"Tesseract"__ for OCR Engine
    [Repository](https://github.com/tesseract-ocr/tesseract)
