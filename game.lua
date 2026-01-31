require "palette"
require "sprites"
require "aster"
require "mundo"

Asteroides = {}
Direcoes = {
    { x=0, y=-1 },
    { x=1, y=0 },
    { x=0, y=1 },
    { x=-1, y=0 },
    { x=1, y=-1},
    { x=1, y=1},
    { x=-1,y=1},
    { x=-1, y=-1 }
}

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


function update()
    local ajuste
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
        if Direcao == 1 or Direcao == 5 or Direcao == 8 then
            Mm:move_y(-Step)
        end
        if Direcao == 2 or Direcao == 5 or Direcao == 6 then
            Mm:move_x(Step)
        end
        if Direcao == 3 or Direcao == 6 or Direcao == 7 then
            Mm:move_y(Step)
        end
        if Direcao == 4 or Direcao == 7 or Direcao == 8 then
            Mm:move_x(-Step)
        end
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

    if ui.btnp(BTN_Z) then
        Mm:zero()
    end

    ui.cls(0)
    ui.clip(0,0,480,270)
    ui.camera()
    ui.print("Monstrao Mascarado", 200, 260, 2)
    ui.spr(Sprites["nave0" .. Direcao], 232, 127)
    
    for i = 1, #Asteroides do
        -- ui.print("x=" .. Asteroides[i].x,10,i*12,2)
        -- ui.print("y=" .. Asteroides[i].y,130,i*12,2)
        a=Mm:camera(Asteroides[i].x, Asteroides[i].y)
        if a.natela then
            if a.x >= 224 and a.x <= 256 and a.y >= 119 and a.y <= 155 then
                ui.print("Bateu! " .. i, 220, 240, 2)
            end
        end
        
        
        Asteroides[i]:draw(Mm)
    end
    ui.spr(Sprites["mask01"], 160, 100)
    ui.spr(Sprites["mask01"], 360, 100)
end
