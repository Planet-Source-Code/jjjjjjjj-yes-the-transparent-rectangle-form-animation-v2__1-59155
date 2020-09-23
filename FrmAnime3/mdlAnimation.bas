Attribute VB_Name = "mdlAnimation"
'=============================================================
'=============================================================
'            [ Auther  : 'Jim Jose '           ]
'            [ Email   : jimjosev33@yahoo.com  ]
'            [ Created : 26/2/2005             ]
'=============================================================
'            [ Title   : 'Transparent Rectangle Form Animations' ]
'            [ Page    : Not Set                                 ]
'=============================================================
'=============================================================
Option Explicit

'[Types]
Public Type POINTAPI
        X As Long
        Y As Long
End Type

'[Event Enum]
Public Enum AnimeEventEnum
    aUnload = 0
    aload = 1
End Enum

'[APIs]
Private Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)
Private Declare Function FillRgn Lib "gdi32.dll" (ByVal hdc As Long, ByVal hRgn As Long, ByVal hBrush As Long) As Long
Private Declare Function CreateSolidBrush Lib "gdi32.dll" (ByVal crColor As Long) As Long
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Private Declare Function CombineRgn Lib "gdi32.dll" (ByVal hDestRgn As Long, ByVal hSrcRgn1 As Long, ByVal hSrcRgn2 As Long, ByVal nCombineMode As Long) As Long
Private Declare Function SetWindowRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long, ByVal bRedraw As Long) As Long
Private Declare Function CreateRectRgn Lib "gdi32.dll" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long

'[This function is the animation maker ]
'======================================================================================================
Public Sub AnimateForm(Frm As Form, Optional ByVal X As Long = -1, Optional ByVal Y As Long = -1, Optional aEvent As AnimeEventEnum, Optional ByVal TrailCount As Long = 0, _
                            Optional ByVal FrameTime As Long = 3, Optional ByVal BorderWidth As Long = 2, Optional ByVal FrameCount As Long = 25, Optional BorderColor As Long = 0)
Static MousePos As POINTAPI
Dim ScrX As Long, ScrY As Long
Dim XValue As Long, YValue As Long
Dim XIncr As Double, YIncr As Double
Dim WIncr As Double, HIncr As Double
Dim hBrush As Long, ColIncr As Double
Dim X1 As Long, Y1 As Long, iNow As Long
Dim FrmRgn As Long, hrgn1 As Long, hrgn2 As Long

    If TrailCount > FrameCount Then TrailCount = FrameCount
    frmRect.Show: frmRect.BackColor = BorderColor: ColIncr = 200 / (TrailCount + 1)
    ScrX = Screen.TwipsPerPixelX: ScrY = Screen.TwipsPerPixelY
    If aEvent = aload Then If (X = -1 Or Y = -1) Then GetCursorPos MousePos Else MousePos.X = X: MousePos.Y = Y
    XIncr = (Frm.Left / ScrX - MousePos.X) / FrameCount
    YIncr = (Frm.Top / ScrY - MousePos.Y) / FrameCount
    WIncr = Frm.Width / ScrX / FrameCount
    HIncr = Frm.Height / ScrY / FrameCount
    
    For X1 = 0 To FrameCount
        FrmRgn = CreateRectRgn(0, 0, 0, 0)
        For Y1 = 0 To TrailCount
            If aEvent = aload Then iNow = X1 - Y1 Else iNow = FrameCount - X1 + Y1
            If iNow >= FrameCount Or iNow <= 0 Then Y1 = TrailCount
            XValue = MousePos.X + iNow * XIncr: YValue = MousePos.Y + iNow * YIncr
            hrgn1 = CreateRectRgn(XValue, YValue, XValue + iNow * WIncr, YValue + iNow * HIncr)
            hrgn2 = CreateRectRgn(XValue - BorderWidth, YValue - BorderWidth, XValue + iNow * WIncr + BorderWidth, YValue + iNow * HIncr + BorderWidth)
            CombineRgn hrgn1, hrgn1, hrgn2, 3
            hBrush = CreateSolidBrush(RGB(Y1 * ColIncr, Y1 * ColIncr, Y1 * ColIncr))
            FillRgn frmRect.hdc, hrgn1, hBrush
            CombineRgn FrmRgn, hrgn1, FrmRgn, 2
            DeleteObject hrgn1: DeleteObject hrgn2: DeleteObject hBrush
        Next Y1
        SetWindowRgn frmRect.hwnd, FrmRgn, True: DoEvents
        Sleep FrameTime
    Next X1
    Unload frmRect
End Sub
'======================================================================================================
