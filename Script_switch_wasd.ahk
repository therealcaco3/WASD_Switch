; 同時按住Ctrl的情況下雙擊Alt鍵以觸發功能切換。
^Alt::
	if IsDoubleClick() {
		RemapKeys := !RemapKeys
		if RemapKeys
			ShowTransText("WASD")
		else
			ShowTransText()
	}
return

#If RemapKeys
  w::Up
  a::Left
  s::Down
  d::Right
  q::Home
  z::End
  e::PgUp
  c::PgDn
  x::Delete
#If

IsDoubleClick() {
	static doubleClickTime := DllCall("GetDoubleClickTime")
	KeyWait, % LTrim(A_ThisHotkey, "~")
	return (A_ThisHotKey = A_PriorHotKey) && (A_TimeSincePriorHotkey <= doubleClickTime)
}

; ShowTransText("Hello")
; ShowTransText("Hello", 10, 10, {bgColor:"0x1482DE", textColor:"White"})
ShowTransText(Text := "", X := 0, Y := 0, objOptions := "") {
	if (Text = "") {
		Gui, @STT_:Destroy
		return	
	}

	o := {bgColor:"Black", textColor:"0x00ff00", transN:200, fontSize:28}
	for k, v in objOptions {
		o[k] := v
	}
	
	Gui, @STT_:Destroy
	Gui, @STT_:+AlwaysOnTop -Caption -SysMenu +ToolWindow +E0x30 +HWNDhGUI
	; 設定邊距
	Gui, @STT_:Margin, 5, 3
	; 修改字體部分
	Gui, @STT_:Font, % "s" o.fontSize, Consolas
	Gui, @STT_:Color, % o.bgColor
	Gui, @STT_:Add, Text, % "c" o.textColor, %Text%
	Gui, @STT_:Show, x%X% y%Y% NA
	WinSet, Transparent, % o.transN, ahk_id %hGUI%
}

; 暫時停用/啟用腳本的快捷鍵：Ctrl + Alt + F11
^!F11::
    Suspend, Toggle
    if (Suspend)
        Tooltip Script 已暫停
    else
        Tooltip
return

; 關閉腳本的快捷鍵：Ctrl + Alt + F12
^!F12::
    ExitApp
return
