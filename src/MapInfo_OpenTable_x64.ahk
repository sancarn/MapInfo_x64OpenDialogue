#Include OnWin.AHK
#SingleInstance, Force
;If the script doesn't run on startup, make it run on startup.
IfNotExist, %A_Startup%\%A_ScriptName%.lnk
	FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%A_ScriptName%.lnk, %A_ScriptDir%

#InstallMouseHook
#InstallKeybdHook

;When Open table window exists, open call Callback_MapInfoOpenDlg()
OnWin("Exist","Open ahk_class #32770 ahk_exe MapInfoPro.exe",Func("Callback_MapInfoOpenDlg"))
return

Callback_MapInfoOpenDlg(this){
	;Caller:
	;OnWin("Exist","Open ahk_class #32770 ahk_exe MapInfoPro.exe",Func("Callback_MapInfoOpenDlg"))
	
	;Wait for Open window to open fully (required to hide it)
	WinWait, Open ahk_class #32770 ahk_exe MapInfoPro.exe
	
	;Hide window
	WinHide, Open ahk_class #32770 ahk_exe MapInfoPro.exe
	
	;Launch an x64 file selector dialog
	FileSelectFile, sFilePath, , , Open - (64-Bit), MapInfo (*.tab)  
	
	;If the file path is blank - cancel was pressed - close MapInfo open dialog.
	if (sFilePath = "") {
		WinClose, Open ahk_class #32770 ahk_exe MapInfoPro.exe
		Exit
	}
	
	;Control List of Open ahk_class #32770 ahk_exe MapInfoPro.exe
	;		Static1
	;		ComboBox1
	;		Static2
	;		ComboBox2
	;		Button1
	;		Button2
	;		SysListView321
	;		Static3
	;		ToolbarWindow321
	;		ToolbarWindow322
	;		ListBox1
	;		SHELLDLL_DefView1
	;		SysListView322
	;		SysHeader321
	;		Static4
	;		Edit1
	;		ComboBoxEx321
	;		ComboBox3
	;		Edit2
	;		Static5
	;		ComboBox4
	;		Static6
	;		Static7
	;		Static8
	;		ComboBox5
	;		Button3
	;		Button4
	;		Button5
	;		Button6
	;		Button7
	;		ScrollBar1
	;		#327701
	;		Button8
	;		Button9
	;		Static9
	;		ToolbarWindow323
	
	;Set the text of the control to the filepath
	ControlSetText, Edit2, %sFilePath%, Open ahk_class #32770 ahk_exe MapInfoPro.exe
	
	;Set the combobox to select .TAB file
	ControlSetText, ComboBox4, MapInfo (*.tab), Open ahk_class #32770 ahk_exe MapInfoPro.exe
	
	;We use 2 commands here since sometimes one or the other doesn't work (i.e. maximising our chances of success!)
	;BLOCK: {
	;Click the 'Open' control
	ControlClick, Button5, Open ahk_class #32770 ahk_exe MapInfoPro.exe
	
	;Send {Enter} to the filepath control
	ControlSend, Edit2, {Enter}, Open ahk_class #32770 ahk_exe MapInfoPro.exe
	;}
	
	;Wait for MapInfo base window to be active
	winClass := "HwndWrapper[MapInfoPro.exe;;c6f9102e-10f6-429b-954a-aaf510cee869]"
	WinWait, ahk_class %winClass% ahk_exe MapInfoPro.exe
	
	;Exit thread
	Exit
	
	/*  Cleaner BUT Incompatible with Mapbasic scripts that happen to use 'open' as a window title.
	;'------------------------------------
	
	cmd = Open Table sFilePath Interactive
	cmd := StrReplace(cmd,"sFilePath",sFilePath)
	
	;Run cmd in MapInfo
	MI := GetMI()
	MI.Do(cmd)
	
	;If mapwindow is active then open in active mapper else create new mapper
	
	cmd := "Add Map Window FrontWindow() Auto Layer " MI.Eval("pathToTableName$(""" . sFilePath . """)")
	MI.Do(cmd)
	*/ 
}