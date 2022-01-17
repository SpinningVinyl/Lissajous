_Title "Lissajous (32-bit color)"

' ==== variable declarations ====

Const T_MIN = _Pi(0) ' lower limit of the iterator
Const T_MAX = _Pi(24) ' higher limit of the iterator

Dim maxX%, maxY% ' sets the max width and max height of the Lissajous curve
Dim t# ' iterator used to draw the Lissajous curves
Dim x%, y% ' horizontal and vertical coordinates of the curent dot
Dim centerX%, centerY% ' coordinates of the center of the screen
Dim a! ' frequency ratio of the equations for X and Y
Dim delta# ' value used to increase the iterator with each iteration
Dim cycles% ' number of cycles per second
Dim gradientColor~& ' this variable holds the color of the current dot being drawn
Dim relativeX#, relativeY# ' relative coordinates of the current dot
Dim phaseDenominator% 'denominator of the phase difference between x and y

setupScreen

' this calculations are used to make sure that the curves are drawn without gaps
' and that the speed is consistent between different systems and screen resolutions
delta# = 1 / Sqr(_Width ^ 2 + _Height ^ 2)
cycles% = Int(5 / delta#)

' find the center of the screen and the maximum dimensions of the curves
centerX% = _Width / 2
centerY% = _Height / 2
maxX% = _Width / 2.2
maxY% = _Height / 2.2

' initial color
' col% = 48

' initial frequency ratio
a! = 0.1

' ==== main loop ====
phaseDenominator% = 1
Do
    a! = 0.1
    Do While a! < 1.6
        t# = T_MIN
        Do While t# <= T_MAX
            _Limit cycles% ' limit the drawing speed

            ' exit if there is any keyboard input
            If InKey$ <> "" Then
                System
            End If

            ' calculate the coordinates of the current point
            x% = centerX% + Int(maxX% * Sin(a! * t# + _Pi(1 / phaseDenominator%)))
            y% = centerY% + Int(maxY% * Sin(t#))
            relativeX# = x% / _DesktopWidth ' relative X coordinate
            relativeY# = y% / _DesktopHeight ' relative Y coordinate
            gradientColor~& = _RGB32((64 * Sin(relativeX# + 2 * t#) + 192) / 2, (64 * Cos(relativeY# + 2 * t#) + 192) / 2, (64 * Cos(relativeX# + relativeY# + 2 * t#) + 192) / 2)

            PSet (x%, y%), gradientColor~& ' draw the current point

            t# = t# + delta# ' increment the iterator
        Loop

        _Delay 1 ' one second of delay before moving to the next curve
        Cls ' clear screen

        a! = a! + 0.1 ' increment the frequency ratio
    Loop

    ' increment the phase denominator
    phaseDenominator% = phaseDenominator% + 1
    If phaseDenominator% = 6 Then ' if phase denominator is > 4, cycle back to 2
        phaseDenominator% = 2
    End If
Loop

Sub setupScreen ()
    Screen _NewImage(_DesktopWidth, _DesktopHeight, 32)
    _MouseHide
    _FullScreen
    Cls
End Sub
