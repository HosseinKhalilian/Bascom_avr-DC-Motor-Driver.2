'======================================================================='

' Title:  DC Motor Driver * PWM
' Last Updated :  01.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega16 + L298

'======================================================================='

$regfile = "m16def.dat"
$crystal = 1000000

Config Timer1 = Pwm , Pwm = 8 , Compare A Pwm = Clear Down , Prescale = 1024

Config Porta = Output
Config Portb = &B00000111
Config Portd.0 = Output
Config Portd.1 = Output
Config Portd.5 = Output
Config Portc.0 = Output
Config Portc.1 = Output

Enable Interrupts
Dim A As Word
Dim B As Bit

Dim P As Bit
Declare Sub Leds(n As Word)
A = 100
B = 0
P = 0

'-----------------------------------------------------------

Do

If Pinb.4 = 1 Then
B = 1
Set Portd.0
Reset Portd.1
Reset Portc.0
Set Portc.1
Bitwait Pinb.4 , Reset
End If

If Pinb.5 = 1 Then
B = 0
Reset Portd.0
Set Portd.1
Set Portc.0
Reset Portc.1
Bitwait Pinb.5 , Reset
End If

If Pinb.3 = 1 Then
P = Not P

If P = 0 Then
If B = 0 Then
Reset Portd.0
Set Portd.1
Set Portc.0
Reset Portc.1
End If
End If

If P = 0 Then
If B = 1 Then
Set Portd.0
Reset Portd.1
Reset Portc.0
Set Portc.1
End If
End If

If P = 1 Then
Reset Portd.0
Reset Portd.1
End If

Bitwait Pinb.3 , Reset
End If

If Pinb.6 = 1 Then
If A < 250 Then A = A + 10
Bitwait Pinb.6 , Reset
End If

If Pinb.7 = 1 Then
If A > 10 Then A = A - 10
Bitwait Pinb.7 , Reset
End If

Pwm1a = A
Call Leds(a)

Loop

End

'-----------------------------------------------------------

Sub Leds(n As Word)

If N < 25 Then
Portb.1 = 1
Portb.0 = 0
Porta = 0
End If

If N < 50 And N >= 25 Then
Portb.1 = 1
Portb.0 = 1
Porta = 0
End If

If N < 75 And N >= 50 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B10000000
End If

If N < 100 And N >= 75 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B11000000
End If

If N < 125 And N >= 100 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B11100000
End If

If N < 150 And N >= 125 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B11110000
End If

If N < 175 And N >= 150 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B11111000
End If

If N < 200 And N >= 175 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B11111100
End If

If N < 225 And N >= 200 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B11111110
End If

If N < 255 And N >= 225 Then
Portb.1 = 1
Portb.0 = 1
Porta = &B11111111
End If

End Sub

'-----------------------------------------------------------




