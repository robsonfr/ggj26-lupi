require "palette"
require "sprites"
require "aster"
require "mundo"
require "globais"
require "tiro"

Asteroides = {}
MaximoTiros = 30

for i = 1, 20 do
    Asteroides[i] = Aster:new()
    Asteroides[i].x = math.random(-400,400)
    Asteroides[i].y = math.random(-320,320)
    Asteroides[i].estado = math.random(1,4)
end

Mm = Mundo:new()

Step = 1
Substep = 0

Direcao = 1
Tiros = {}
for i=1, MaximoTiros do
    Tiros[i] = Tiro:new()
    Tiros[i].x = -1000
    Tiros[i].y = -1000
end

Tempo = 0

function Camera(d)
    if d == 1 or d == 5 or d == 8 then
        Mm:move_y(-Step)
    end
    if d == 2 or d == 5 or d == 6 then
        Mm:move_x(Step)
    end
    if d == 3 or d == 6 or d == 7 then
        Mm:move_y(Step)
    end
    if d == 4 or d == 7 or d == 8 then
        Mm:move_x(-Step)
    end
end

TempoTiro = 0

function update()
    local ajuste
    
    Tempo = Tempo + 1
    ajuste = 0
    DirX = 0
    DirY = 0
    
    if ui.btn(LEFT) then
        --Direcao = 4
        DirX = -1
        ajuste = 1
    end
    if ui.btn(RIGHT) then
        -- Direcao = 2
        DirX = 1
        ajuste = 1
    end
    if ui.btn(UP) then
        --Direcao = 1
        DirY = -1
        ajuste = 1
    end
    if ui.btn(DOWN) then
        -- Direcao = 3
        DirY = 1
        ajuste = 1
    end

    if DirX == 0 and DirY ~= 0 then
        if DirY == -1 then
            Direcao = 1
        elseif DirY == 1 then
            Direcao = 3
        end
    elseif DirY == 0 and DirX ~= 0 then
        if DirX == 1 then
            Direcao = 2
        elseif DirX == -1 then
            Direcao = 4
        end
    else
        if DirX == 1 and DirY == -1 then
            Direcao = 5
        elseif DirX == 1 and DirY == 1 then
            Direcao = 6
        elseif DirX == -1 and DirY == 1 then
            Direcao = 7
        elseif DirX == -1 and DirY == -1 then
            Direcao = 8
        end
    end

    if ajuste == 1 then
        Camera(Direcao)
        Substep = Substep + 1
        if Substep >= 10 then
            Step = Step + 1
            Substep = 0
        end
    else
        Substep = 0
        Step = 1
    end

    for i = 1, #Palette do
        ui.palset(i-1, Palette[i])
    end

    if ui.btnp(BTN_X) then
        Mm:zero()
        NumTiros = 0
    end

    local k = 0
    if ui.btn(BTN_Z) then
        if TempoTiro == 0 then
            TempoTiro = Tempo - 20
        end
        if Tempo - TempoTiro >= 15 then
            TempoTiro = Tempo
            k = k + 1
            while k<= #Tiros do
                if not Tiros[k]:natela(Mm) then
                    break
                end
                k = k + 1
            end
            if k<= #Tiros then
                Tiros[k].x = Mm.x + Direcoes[Direcao].posTiro.x
                Tiros[k].y = Mm.y + Direcoes[Direcao].posTiro.y
                Tiros[k].direcao = Direcao
            end
        end
    end

    ui.cls(0)
    ui.clip(0,0,480,270)
    ui.camera()
    ui.print("Monstrao Mascarado", 200, 260, 2)
    ui.spr(Sprites["nave0" .. Direcao], 232, 127)
    
    for i = 1, #Asteroides do
        local a
        a=Asteroides[i]
        if a:bateu(Mm) then
            ui.print("Bateu! " .. i, 220, 240, 2)
            Step = 1
            Substep = 0
            Camera(Direcoes[Direcao].op)
        end
        
        a:draw(Mm)
    end
    
    for i = 1, #Tiros do
        local tt
        
        tt = Tiros[i]
        if tt and tt:natela(Mm) then
            tt:updatedraw(Mm)
        end
        --if tt and not tt:updatedraw(Mm) then
        -- Tiros[i] = nil
        --end 
    end

    ui.print("Tempo=" .. Tempo, 10, 10, 2)
    ui.print("TempoTiro=" .. TempoTiro, 10, 20, 2)
    ui.print("#Tiros=" .. #Tiros, 10, 30, 2)
    
    if k <= 10 and k>= 1 and Tiros[k] then
        ui.print("Tiros[" .. k .. "].x=" .. Tiros[k].x,10,50,2)
        ui.print("Tiros[" .. k .. "].y=" .. Tiros[k].y,10,60,2)
    end

    
--    ui.spr(Sprites["mask01"], 160, 100)
--    ui.spr(Sprites["mask01"], 360, 100)
end
