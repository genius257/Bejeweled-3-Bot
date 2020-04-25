#include <WinAPISysWin.au3>
#include <WinAPIGdiDC.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPIGdi.au3>

HotKeySet("{Esc}", "MyExit")
Func MyExit()
	Exit
EndFunc

Enum $iMode_Zen, $iMode_Lightning, $iMode_length
Enum $iPlayarea_x, $iPlayarea_y, $iPlayarea_w, $iPlayarea_h, $iPlayarea_rows, $iPlayarea_cols, $iPlayarea_length

Dim $aGame[$iMode_length][$iPlayarea_length]

$aGame[$iMode_Zen][$iPlayarea_x] = 337
$aGame[$iMode_Zen][$iPlayarea_y] = 75
$aGame[$iMode_Zen][$iPlayarea_w] = 647
$aGame[$iMode_Zen][$iPlayarea_h] = 647
$aGame[$iMode_Zen][$iPlayarea_rows] = 8
$aGame[$iMode_Zen][$iPlayarea_cols] = 8

$aGame[$iMode_Lightning][$iPlayarea_x] = 337
$aGame[$iMode_Lightning][$iPlayarea_y] = 75+37
$aGame[$iMode_Lightning][$iPlayarea_w] = 647
$aGame[$iMode_Lightning][$iPlayarea_h] = 647
$aGame[$iMode_Lightning][$iPlayarea_rows] = 8
$aGame[$iMode_Lightning][$iPlayarea_cols] = 8

Global $iMode = $iMode_Lightning
;Global $iMode = $iMode_Zen

$hWnd = _WinAPI_FindWindow("MainWindow", "Bejeweled 3")
If @error <> 0 Or $hWnd = 0 Then Exit MsgBox(0, "", "could not find window")

$hBot = GUICreate("eye", 400, 400, -1, -1, 0x80000000, $WS_EX_TOOLWINDOW+$WS_EX_TOPMOST)
GUISetState(@SW_SHOW, $hBot)

$hDC = _WinAPI_GetWindowDC($hWnd)
$hMemDC = _WinAPI_CreateCompatibleDC($hDC)
;$

;_WinAPI_OffsetPoints; for making x y easy on hDC

$hBotDC = _WinAPI_GetWindowDC($hBot)

$bitBit = _WinAPI_CreateBitmap(400/8, 400/8, 1, 12)
$bitDC = _WinAPI_CreateCompatibleDC($hBotDC)
_WinAPI_SelectObject($bitDC, $bitBit)

$hBrush = _WinAPI_CreateSolidBrush(0x0)

;$tRect = _WinAPI_CreateRect(0, 0, 400/8, 400/8)

;_WinAPI_FillRect($hBotDC, $tRect, $hBrush)

;_WinAPI_PrintWindow($hWnd,

;$tRect = _WinAPI_CreateRect(337, 75, 337+647, 75+647);playarea

;$tRect = _WinAPI_CreateRect($aGame[$iMode][$iPlayarea_x], $aGame[$iMode][$iPlayarea_y], $aGame[$iMode][$iPlayarea_x]+$aGame[$iMode][$iPlayarea_w]/$aGame[$iMode][$iPlayarea_cols], $aGame[$iMode][$iPlayarea_y]+$aGame[$iMode][$iPlayarea_h]/$aGame[$iMode][$iPlayarea_rows]);playarea

$w = $aGame[$iMode][$iPlayarea_w]/$aGame[$iMode][$iPlayarea_cols]
$h = $aGame[$iMode][$iPlayarea_h]/$aGame[$iMode][$iPlayarea_rows]

;_WinAPI_SetStretchBltMode($hBotDC, $BLACKONWHITE)
_WinAPI_SetStretchBltMode($hBotDC, $COLORONCOLOR)
;_WinAPI_SetStretchBltMode($hBotDC, $HALFTONE)
;_WinAPI_SetStretchBltMode($hBotDC, $WHITEONBLACK)
;_WinAPI_SetStretchBltMode($hBotDC, $STRETCH_ANDSCANS)
_WinAPI_SetStretchBltMode($hBotDC, $STRETCH_DELETESCANS)

$aPos = WinGetPos($hWnd)
WinMove($hBot, "", $aPos[0]+$aPos[2], $aPos[1])


Global $aColors = ["Red", "Green", "Blue", "Orange", "Purple", "Yellow", "White"]
Global $aRed = [0xF51835, 0xFF83B6]
Global $aGreen = [0x00FF00, 0x04880F, 0x5BF993]
Global $aBlue = [0x0000FF, 0x39E1EA]
Global $aOrange = [0xFFF99B, 0xCD4A0F, 0xE88535]
Global $aPurple = [0xFF00FF]
Global $aYellow = [0xFFFF00]
Global $aWhite = [0xF0F7FD]

;$iRed = iToRGB(0xFF0000)
$iRed = iToRGB(0xF51835)
$iGreen = iToRGB(0x00FF00)
$iGreen = iToRGB(0x04880F)
$iGreen2 = iToRGB(0x5BF993)
$iBlue = iToRGB(0x0000FF)
;$iOrange = iToRGB(0xFF8C00)
$iOrange = iToRGB(0xFFF99B)
$iOrange2 = iToRGB(0xCD4A0F)
;E88535
$iPurple = iToRGB(0xFF00FF)
$iYellow = iToRGB(0xFFFF00)
;$iWhite = iToRGB(0xFFFFFF)
$iWhite = iToRGB(0xF0F7FD)

Global $aGrid[$aGame[$iMode][$iPlayarea_cols]][$aGame[$iMode][$iPlayarea_rows]]
;Global $tPAINTSTRUCT

While 1
	;$hBotDC2 = _WinAPI_BeginPaint($hBot, $tPAINTSTRUCT)
	For $x = 0 To 7
		For $y = 0 To 7
			;DllCall("gdi32.dll", "int", "StretchBlt", "int", $hBotDC, "int", 400/8*$x, "int", 400/8*$y, "int", 400/8, "int", 400/8, "int", _
			;		$hDC, "int", $aGame[$iMode][$iPlayarea_x]+$w*$x, "int", $aGame[$iMode][$iPlayarea_y]+$h*$y, "int", $w, "int", $h, "long", $SRCCOPY)

			;DllCall("gdi32.dll", "int", "StretchBlt", "int", $bitDC, "int", 0, "int", 0, "int", 400/8, "int", 400/8, "int", _
			;		$hDC, "int", $aGame[$iMode][$iPlayarea_x]+$w*$x, "int", $aGame[$iMode][$iPlayarea_y]+$h*$y, "int", $w, "int", $h, "long", $SRCCOPY)
			;DllCall("gdi32.dll", "int", "StretchBlt", "int", $hBotDC, "int", 400/8*$x, "int", 400/8*$y, "int", 400/8, "int", 400/8, "int", _
			;		$bitDC, "int", 0, "int", 0, "int", 400/8, "int", 400/8, "long", $SRCCOPY)

			DllCall("gdi32.dll", "int", "StretchBlt", "int", $hBotDC, "int", 400/8*$x, "int", 400/8*$y, "int", 1, "int", 1, "int", _
					$hDC, "int", $aGame[$iMode][$iPlayarea_x]+$w*$x, "int", $aGame[$iMode][$iPlayarea_y]+$h*$y, "int", $w, "int", $h, "long", $SRCCOPY)
			DllCall("gdi32.dll", "int", "StretchBlt", "int", $hBotDC, "int", 400/8*$x, "int", 400/8*$y, "int", 400/8, "int", 400/8, "int", _
					$hBotDC, "int", 400/8*$x, "int", 400/8*$y, "int", 1, "int", 1, "long", $SRCCOPY)

			$icolor = _WinAPI_GetPixel($hBotDC, 400/8*$x, 400/8*$y)
			;ConsoleWrite("0x"&Hex($icolor, 6)&@CRLF)
			$rgb = iToRGB($icolor)
			;ConsoleWrite($rgb[0]&" "&$rgb[1]&" "&$rgb[2]&@CRLF)

			$sID = "?"
			$mindiff = 59999;256*3

			For $i = 0 To UBound($aColors, 1) - 1
				For $j = 0 To UBound(Execute("$a"&$aColors[$i]), 1) - 1
					$rgb2 = iToRGB(Execute("$a"&$aColors[$i]&"[$j]"))
					$diff = Abs($rgb[0]-$rgb2[0])*256 + Abs($rgb[1]-$rgb2[1])*256 + Abs($rgb[2]-$rgb2[2])*256
					If $diff < $mindiff Then
						$sID = $aColors[$i]
						$mindiff = $diff
					EndIf
				Next
			Next

			_WinAPI_TextOut($hBotDC, 400/8*$x, 400/8*$y, $sID)
			$aGrid[$x][$y] = $sID
		Next
	Next

	$aMatch = FindFirstMatch($aGrid)
	#cs
	For $i=0 To 2
		$x = Mod($aMatch[$i], 8)
		;ConsoleWrite($x&@CRLF)
		$y = Floor($aMatch[$i]/8)
		;ConsoleWrite($y&@CRLF)
		;ConsoleWrite($aMatch[$i]&@CRLF&@CRLF)

		$tRect = _WinAPI_CreateRect(400/8*$x+(400/8/2)-5, 400/8*$y+(400/8/2)-5, 400/8*$x+(400/8/2)+5, 400/8*$y+(400/8/2)+5)

		_WinAPI_FillRect($hBotDC, $tRect, $hBrush)
	Next
	#ce

	;_WinAPI_BitBlt($hBotDC, 0, 0, 400, 400, $hBotDC2, 0, 0, $SRCCOPY)
	;_WinAPI_EndPaint($hBot, $tPAINTSTRUCT)
	Sleep(100)
WEnd

While 1
	;_WinAPI_FillRect($hDC, $tRect, $hBrush)
	Sleep(10)
WEnd

Func iToRGB($i)
	Local $a[3]

	$a[0] = BitAND(BitShift($i, 16), 0xFF)
	$a[1] = BitAND(BitShift($i, 8), 0xFF)
	$a[2] = BitAND(BitShift($i, 0), 0xFF)

	Return $a
EndFunc

Func ChangeMode($iNewMode)
	If $iNewMode >= $iMode_length Then Return SetError(1, 0, 0)
	;rebuild (redim) array of grid
	ReDim $aGrid[$aGame[$iMode][$iPlayarea_cols]][$aGame[$iMode][$iPlayarea_rows]]
	Return 1
EndFunc

Func FindFirstMatch(ByRef $aGrid)
	Local $w = UBound($aGrid, 1)
	Local $h = UBound($aGrid, 2)
	Local $x, $y, $iType
	Local $aRet[3] = [0,0,0]

	Local $gridX = $aGame[$iMode][$iPlayarea_x]
	Local $gridY = $aGame[$iMode][$iPlayarea_y]
	Local $gridColWidth = $aGame[$iMode][$iPlayarea_w]/8
	Local $gridColHeight = $aGame[$iMode][$iPlayarea_h]/8

	For $x = 0 To $w -1
		For $y = 0 To $h -1
			$iType = $aGrid[$x][$y]

			#cs
				x x
				 x
			#ce
			If Execute("$aGrid[$x-1][$y-1]") = $iType And Execute("$aGrid[$x+1][$y-1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x-1+($y-1)*8
				$aRet[2] = $x+1+($y-1)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y-1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				 x
				x
				 x
			#ce
			If Execute("$aGrid[$x+1][$y-1]") = $iType And Execute("$aGrid[$x+1][$y+1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+1+($y-1)*8
				$aRet[2] = $x+1+($y+1)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x+1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
			     x
				x x
			#ce
			If Execute("$aGrid[$x+1][$y+1]") = $iType And Execute("$aGrid[$x-1][$y+1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+1+($y+1)*8
				$aRet[2] = $x-1+($y+1)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y+1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				x
				 x
				x
			#ce
			If Execute("$aGrid[$x-1][$y+1]") = $iType And Execute("$aGrid[$x-1][$y-1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x-1+($y+1)*8
				$aRet[2] = $x-1+($y-1)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x-1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf

			#cs
				x xx
			#ce
			If (Not (Execute("$aGrid[$x+1][$y]") = $iType)) And Execute("$aGrid[$x+2][$y]") = $iType And Execute("$aGrid[$x+3][$y]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+2+($y+0)*8
				$aRet[2] = $x+3+($y+0)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x+1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				x
                x

				x
			#ce
			If (Not (Execute("$aGrid[$x][$y-1]") = $iType)) And Execute("$aGrid[$x][$y-2]") = $iType And Execute("$aGrid[$x][$y-3]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+0+($y-2)*8
				$aRet[2] = $x+0+($y-3)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y-1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				xx x
			#ce
			If (Not (Execute("$aGrid[$x-1][$y]") = $iType)) And Execute("$aGrid[$x-2][$y]") = $iType And Execute("$aGrid[$x-3][$y]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x-2+($y+0)*8
				$aRet[2] = $x-3+($y+0)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x-1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
			    x

                x
				x
			#ce
			If (Not (Execute("$aGrid[$x][$y+1]") = $iType)) And Execute("$aGrid[$x][$y+2]") = $iType And Execute("$aGrid[$x][$y+3]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+0+($y+2)*8
				$aRet[2] = $x+0+($y+3)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y+1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf

			#cs
			   x
               x
				x
			#ce
			If Execute("$aGrid[$x-1][$y-1]") = $iType And Execute("$aGrid[$x-1][$y-2]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x-1+($y-1)*8
				$aRet[2] = $x-1+($y-2)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x-1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
			  xx
				x
			#ce
			If Execute("$aGrid[$x-1][$y-1]") = $iType And Execute("$aGrid[$x-2][$y-1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x-1+($y-1)*8
				$aRet[2] = $x-2+($y-1)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y-1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
			     x
                 x
				x
			#ce
			If Execute("$aGrid[$x+1][$y-1]") = $iType And Execute("$aGrid[$x+1][$y-2]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+1+($y-1)*8
				$aRet[2] = $x+1+($y-2)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x+1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
			     xx
				x
			#ce
			If Execute("$aGrid[$x+1][$y-1]") = $iType And Execute("$aGrid[$x+2][$y-1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+1+($y-1)*8
				$aRet[2] = $x+2+($y-1)*8

				;$tRect = _WinAPI_CreateRect($gridX+$gridColWidth*$x+$gridColWidth/2-5, $gridY+$gridColHeight*$y+$gridColHeight/2-5, $gridX+$gridColWidth*$x+$gridColWidth/2+5, $gridY+$gridColHeight*$y+$gridColHeight/2+5)
				;_WinAPI_FillRect($hDC, $tRect, $hBrush)
				;$tRect = _WinAPI_CreateRect($gridX+$gridColWidth*($x)+$gridColWidth/2-5, $gridY+$gridColHeight*($y-1)+$gridColHeight/2-5, $gridX+$gridColWidth*($x)+$gridColWidth/2+5, $gridY+$gridColHeight*($y-1)+$gridColHeight/2+5)
				;_WinAPI_FillRect($hDC, $tRect, $hBrush)
				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y-1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				x
			     x
			     x
			#ce
			If Execute("$aGrid[$x+1][$y+1]") = $iType And Execute("$aGrid[$x+1][$y+2]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+1+($y+1)*8
				$aRet[2] = $x+1+($y+2)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x+1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				x
			     xx
			#ce
			If Execute("$aGrid[$x+1][$y+1]") = $iType And Execute("$aGrid[$x+2][$y+1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x+1+($y+1)*8
				$aRet[2] = $x+2+($y+1)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y+1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				x
			   x
			   x
			#ce
			If Execute("$aGrid[$x-1][$y+1]") = $iType And Execute("$aGrid[$x-1][$y+2]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x-1+($y+1)*8
				$aRet[2] = $x-1+($y+2)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x-1)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
			#cs
				x
			  xx
			#ce
			If Execute("$aGrid[$x-1][$y+1]") = $iType And Execute("$aGrid[$x-2][$y+1]") = $iType Then
				$aRet[0] = $x+$y*8
				$aRet[1] = $x-1+($y+1)*8
				$aRet[2] = $x-2+($y+1)*8

				$pos = WinGetPos($hWnd)
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y)+$gridColHeight/2-5, 0)
				MouseDown("left")
				MouseMove($pos[0]+$gridX+$gridColWidth*($x)+$gridColWidth/2-5, $pos[1]+$gridY+$gridColHeight*($y+1)+$gridColHeight/2-5, 0)
				MouseUp("left")

				ContinueLoop 1
				ExitLoop 2
			EndIf
		Next
	Next

	Return $aRet
EndFunc
