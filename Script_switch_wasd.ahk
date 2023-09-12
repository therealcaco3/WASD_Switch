~Alt::
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

	o := {bgColor:"Black", textColor:"0x00ff00", transN:200, fontSize:14}
	for k, v in objOptions {
		o[k] := v
	}
	
	Gui, @STT_:Destroy
	Gui, @STT_:+AlwaysOnTop -Caption -SysMenu +ToolWindow +E0x20 +HWNDhGUI
	Gui, @STT_:Font, % "s" o.fontSize " cConsolas" ; 修改字體部分
	Gui, @STT_:Color, % o.bgColor
	Gui, @STT_:Add, Text, % "c" o.textColor, %Text%
	Gui, @STT_:Show, x%X% y%Y% NA
	WinSet, Transparent, % o.transN, ahk_id %hGUI%
}

^!F12::  ; Ctrl + Alt + F12 用於關閉腳本
    ExitApp
return