require "palette"
require "sprites"
require "aster"
require "mundo"
require "globais"
require "tiro"

-- Inicializacoes de globais
for i = 1, NumAsteriodes do
    Asteroides[i] = Aster:new()
    Asteroides[i].x = math.random(-600,600)
    Asteroides[i].y = math.random(-520,520)
    Asteroides[i].estado = math.random(1,4)
end

Mm = Mundo:new()

for i=1, MaximoTiros do
    Tiros[i] = Tiro:new()
    Tiros[i].x = -10000
    Tiros[i].y = -10000
end



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


function update()
    local ajuste

    Tempo = Tempo + 1
    ajuste = 0
    DirX = 0
    DirY = 0

    if ui.btn(LEFT) then
        DirX = -1
        ajuste = 1
    end
    if ui.btn(RIGHT) then
        DirX = 1
        ajuste = 1
    end
    if ui.btn(UP) then
        DirY = -1
        ajuste = 1
    end
    if ui.btn(DOWN) then
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
    end

    local k = 0
    if ui.btn(BTN_Z) then
        if TempoTiro == 0 then
            TempoTiro = Tempo - (CadenciaTiros * 2)
        end
        if Tempo - TempoTiro >= CadenciaTiros then
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
            if not tt:updatedraw(Mm) then
                tt.x = -10000
                tt.y = -10000
            else
                for j=1, #Asteroides do
                    local b
                    local lbx
                    local lby
                    b=Asteroides[j]
                    lbx = (b.limites.x // 2)
                    lby = (b.limites.y // 2)
                    if b.estado <=4 and b:natela() and math.abs(b.x + lbx - tt.x) < lbx and math.abs(b.y + lby - tt.y) < lby then
                        b:recebeutiro()
                        sfx.fx(16, 25)
                        if b.estado == 5 then
                            Bombas = Bombas + 1
                        end
                        tt.x = -10000
                        tt.y = -10000
                        break
                    end
                end
            end
        end
    end

end
