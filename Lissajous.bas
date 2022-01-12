_Title "Lissajous"

' ==== variable declarations ====

Const T_MIN = _Pi(0) ' lower limit of the iterator
Const T_MAX = _Pi(24) ' higher limit of the iterator

Dim maxX%, maxY% ' sets the max width and max height of the Lissajous curve
Dim t# ' iterator used to draw the Lissajous curves
Dim x%, y% ' horizontal and vertical coordinates of the curent dot
Dim centerX%, centerY% ' coordinates of the center of the screen
Dim a! ' frequency ratio of the equations for X and Y
Dim col% ' color of the curve
Dim delta# ' value used to increase the iterator with each iteration
Dim cycles% ' number of cycles per second

' mouse functionality has been disabled
' Dim mouseMoveX%, mouseMoveY% ' used to trap mouse input

setupScreen

' this calculations are used to make sure that the curves are drawn without gaps
' and that the speed is consistent between different systems and screen resolutions
delta# = 5 / Sqr(_Width ^ 2 + _Height ^ 2)
cycles% = Int(5 / delta#)

' find the center of the screen and the maximum dimensions of the curves
centerX% = _Width / 2
centerY% = _Height / 2
maxX% = _Width / 2.2
maxY% = _Height / 3.3

' initial color
col% = 48

' initial frequency ratio
a! = 0.1

' ==== main loop ====
Do
    t# = T_MIN
    Do While t# <= T_MAX
        _Limit cycles% ' limit the drawing speed

        ' Do While _MouseInput ' trapping mouse input
        '     mouseMoveX% = mouseMoveX% + _MouseMovementX
        '     mouseMoveY% = mouseMoveY% + _MouseMovementY
        ' Loop

        ' exit if there is any keyboard input
        ' If InKey$ <> "" Or mouseMoveX% <> 0 Or mouseMoveY% <> 0 Then
        If InKey$ <> "" Then
            System
        End If

        ' calculate the coordinates of the current point
        x% = centerX% + Int(maxX% * Sin(a! * t# + _Pi(1 / 3)))
        y% = centerY% + Int(maxY% * Sin(t#))

        PSet (x%, y%), col% ' draw the current point

        t# = t# + delta# ' increment the iterator
    Loop

    _Delay 1 ' one second of delay before moving to the next curve
    Cls ' clear screen

    col% = col% + 1 ' increment the color
    If col% > 128 Then ' if we run out of colors, cycle back to the initial color
        col% = 48
    End If

    a! = a! + 0.1 ' increment the frequency ratio
    If a! = 2 Then ' cycle back to the initial frequency ratio
        a! = 0.1
    End If
Loop

Sub setupScreen ()
    Screen _NewImage(_DesktopWidth, _DesktopHeight, 256)
    _MouseHide
    _FullScreen
    Cls
End Sub
