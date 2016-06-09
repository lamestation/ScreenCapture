'' Screen Capture Tool
'' -------------------------------------------------
''        Author: Marko Lukat
'' Last modified: 2015/10/26
''       Version: 0.3
'' -------------------------------------------------
''
'' ### Usage 
''
''  * Include the *ScreenCapture* object into your project
''  * Pass a screen buffer address to the Capture method
''  * Output is captured and converted with lscapture (host side).
''
'' *NOTE: you may also pass a 128x64 sprite as an address, if you skip the sprite header.*

OBJ
    ser : "LameSerial"

VAR
    long  cog

PUB null
PUB Capture(addr)

    ifnot cog
        ifnot cog := ser.StartRxTx(31, 30, 0, 921600)
            return
        waitcnt(clkfreq*3 + cnt)
    
    ser.Str(string($AA, $AA, $AA, $AA))              ' header

    repeat 2048                                         ' 128x64x2/8
        ser.Char(byte[addr++])
