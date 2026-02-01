require "globais"
require "sprites"

AnimacaoRosto = 0
FrameRosto = 1

function huddraw()
    ui.rectfill(0,234,480,270,0)
    ui.rect(0,234,480,270,2)
    if AnimacaoRosto == 0 then
        AnimacaoRosto = Tempo
    end
    if Tempo - AnimacaoRosto >= 45 then
        FrameRosto = 3 - FrameRosto
        AnimacaoRosto = Tempo
    end
    ui.spr(Sprites["pilot0" .. FrameRosto], 10, 237)
end