require "globais"
require "sprites"

AnimacaoRosto = 0
FrameRosto = 1

function huddraw()
    local sc
    local nmb
    ui.rectfill(0,234,480,270,0)
    ui.rect(0,234,480,270,2)
    if AnimacaoRosto == 0 then
        AnimacaoRosto = Tempo
    end
    if Tempo - AnimacaoRosto >= 45 then
        FrameRosto = 3 - FrameRosto
        AnimacaoRosto = Tempo
    end
    ui.spr(Sprites["pilot0" .. FrameRosto], 10, 232)
    sc  = "Score.." .. string.format("%07d", Score)
    nmb = "Bombas." .. string.format("%7d", NumBombas)
    ui.print(sc, 60, 235, 2)
    ui.print(nmb, 60, 247, 2)
    ui.print("Nivel Monstrao=" .. OMonstrao.nivel, 320, 235, 2)
end