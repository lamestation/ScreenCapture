CON
    _clkmode = xtal1|pll16x
    _xinfreq = 5_000_000

OBJ
    lcd     :   "LameLCD"
    gfx     :   "LameGFX"
    map     :   "LameMap"

    tileset :   "gfx_cave"
    cavemap :   "map_cave"

VAR
    word buffer

OBJ
    cap : "ScreenCapture"

PUB Main

    lcd.Start(buffer := gfx.Start)
    map.Load(tileset.Addr, cavemap.Addr)
    map.Draw(0,64)
    lcd.DrawScreen

    cap.Capture(buffer)
