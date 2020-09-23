VERSION 5.00
Begin VB.Form frmTest 
   BackColor       =   &H00404040&
   Caption         =   "Sample Form"
   ClientHeight    =   2625
   ClientLeft      =   75
   ClientTop       =   420
   ClientWidth     =   3525
   LinkTopic       =   "Form1"
   Picture         =   "frmTest.frx":0000
   ScaleHeight     =   175
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   235
   StartUpPosition =   3  'Windows Default
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Sample Form"
      BeginProperty Font 
         Name            =   "Comic Sans MS"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   2160
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    AnimateForm Me, -1, -1, aload, Val(frmMain.txtTrailCount), Val(frmMain.txtFrameTime), Val(frmMain.txtBorder), Val(frmMain.txtFrames)
    End Sub

Private Sub Form_Unload(Cancel As Integer)
    AnimateForm Me, -1, -1, aUnload, Val(frmMain.txtTrailCount), Val(frmMain.txtFrameTime), Val(frmMain.txtBorder), Val(frmMain.txtFrames)
End Sub
