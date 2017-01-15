#Motivation:

A few months ago I saw a post on the PB Ideas Portal that caught my eye: https://goo.gl/ydw2ha 
This was a something that had irritated me for a long while also, though you'd never really see the problem unless you are a common user of newer windows applications which use the newer Open dialog.

Regardless... Tonight I implemented a small part of it which I figured deserves a share. The code for the implementation turned out to be really simple, though finding the right controls to modify and the right events to send to the MapInfo open dialog was relatively difficult... (Can you believe there are 35 controls in that dialog?! Even though ≈16 are only ever 'clearly' visible at any one time... (It seems most of the controls are static controls which would explain things a bit more.))

#General Information:

## Purpose:
To test the ease of use of the newer "Open Dialog" used in many windows applications.

## Current version:
Whenever an Open File dialog, with a title "Open", appears in MapInfo, whether called from the ribbon interface, keyboard shortcut or MapBasic, the window shall be hidden and a newer Open dialog shall appear in it's place. (Note: If you have 2 screens it may appear on the other screen).
The user can select a file using the new open dialog. When clicking OK the information is sent back to MapInfo (via the hidden Open file dialog)

## Limitations:
Although the newer dialog is more powerful than the base dialog in some aspects (custom sidebars and richer address bar) it's also currently only an application to get a 'feel' for using the new style of open dialog. Here are a few limitations the current build has:

* File types other than .TAB are not included. (Dialogs for "Open Workspace" etc. remain unchanged.)
* Only 1 table can be opened at a time.
* 'Preferred View' drop down list is currently inaccessible.
* 'Create copy' checkbox is currently inaccessible.
* Accessories found in the top right button/drop down of the base dialog, are currently inaccessible. (Not entirely sure what these features are used for?)
* Environments Tested:
* Tested and working in Windows 7 | MapInfo Pro 12.5.1 64-Bit.
* Please let me know if this still works in later versions Windows and MapInfo!

## License:
MIT License 

## Download:
https://github.com/sancarn/MapInfo_x64OpenDialogue/raw/master/MapInfo_OpenTable_x64.exe
Please inform me if this doesn't work for you!

## How to use:
After you have downloaded the executable, run it, and go open a table in MapInfo.

## How to 'uninstall':
The program installs itself in your startup folder when it is run. Go to "Start > All Programs > Startup" and delete the shortcut to the executable. If you wish, you can then delete the executable itself.

# Technical Information:

## Source Code:
As it goes with many open source applications, feel free to contribute to the upkeep of the application. Either message me with updates or fork the library.

## Explanations:
My initial idea to implement such a window was to make an MBX. Using strictly DLL Calls you can call the shell open dialog and retrieve the information that's required from that dialog, though it is pretty complex. Then to force the user to use the dialog Peter's RIBBONLib can be used to replace the "Open" table icons with the our icon, however the user would still be able to open tables with Ctrl+O, bypassing the new dialog box.

My second idea was to use a COM based application. Such an application could easily detect keyboard shortcuts but that fell through when I couldn't figure out how to use the RIBBONLib via COM. (In fact PBSupport told me it was impossible. Even if it was possible though, there'd still be another issue. When MapBasic applications are used they will often call the OpenFileDlg() function. This would yet again be another method that would go unseen by our over-arching application.

My third idea, and the one I settled on, was to use window events. They may not be as elegant, and there are likely better ways using .NET to achieve these goals, but they get the job done and at this point I just wanted to test it out! So I quickly through together this application and here we are.

Ultimately the code works as follows:
We register a "OnWinExist" event, to wait for the Open dialog window.
When a Open dialog window exists, it triggers the event.
The event triggers a function.
The function hides the base "Open dialog" window and opens the standard "Open dialog" window.
After the file has been selected, the information is re-inserted into the old dialog and executed from there.

This is the only way that I could think of, which would account for all the cases where the user could be asked to open a tab file. Ribbon, Keyboard shortcut and MapBasic. And that's why it uses window events and also why the old window flicks onto the screen temporarily when you try to open a file.

All of the above would be pretty easy to add in so feel free to modify the source code as you wish!

If you have updates, tell me and I'll be happy to add them!

# Future implementations

* I'm currently working to get all other default MapInfo dialog options working with the x64 Open Dialog. These features will be accessible through a menu in the bottom left hand corner of the dialog.

# Old MapInfo Legacy Open Dialog:

Items highlighted in blue are things which are not available in the current version of the dialog.

![Comparison](/MapInfo Dialog v.s. x64Dialog.png)

# The x64 Open Dialog:

![Comparison](/OpenDlgx64.png)
