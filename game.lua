require "palette"
require "sprites"
require "aster"
require "mundo"
require "globais"
require "tiro"
require "hud"
require "inimigo"
require "bomba"

-- Inicializacoes de globais

Mm = Mundo:new()
for i = 1, 20 do
    Asteroides[i] = Aster:new()
    Asteroides[i].x = math.random(-400,400)
    Asteroides[i].y = math.random(-300,300)
    Asteroides[i].estado = math.random(1,4)
end

for i = 21, NumAsteriodes do
    Asteroides[i] = Aster:new()
    Asteroides[i].x = math.random(-2000,2000)
    Asteroides[i].y = math.random(-1500,1500)
    Asteroides[i].estado = math.random(1,4)
end

for i=1, MaximoTiros do
    Tiros[i] = Tiro:new()
    Tiros[i].x = -10000
    Tiros[i].y = -10000
end

for i=1, NumInimigos do
    Inimigos[i] = Inimigo:new()
    Inimigos[i].x = math.random(-400,400)
    Inimigos[i].y = math.random(-400,400)
    Inimigos[i].vel = math.random(1,2)
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
    Tempo = Tempo + 1
    ui.cls(0)
    ui.clip(0,0,480,270)
    ui.camera()
    for i = 1, #Palette do
        ui.palset(i-1, Palette[i])
    end
    
    if EstadoGlobal == 1 then
        gameplay()
    elseif EstadoGlobal == 2 then
        abertura()
    elseif EstadoGlobal == 3 then
        gameover()
    elseif EstadoGlobal == 4 then
        creditos()
    end

end

function abertura()
    ui.spr(Sprites.mask02,0,PosicaoTitulo)
    
    if PosicaoTitulo > 0 then
        PosicaoTitulo = PosicaoTitulo - 1
    else
        PosicaoTitulo = 0
        if AberturaMensagem then
            AberturaMensagem = AberturaMensagem - 1
        else
            AberturaMensagem = 30
            CorTextoAbertura = 3 - CorTextoAbertura
        end
        ui.print(" ----- MONSTRAO MASCARADO --------", 40, 220, 3)
        ui.print("PRESSIONE [A] PARA INICIAR!!", 40, 240, CorTextoAbertura)
    end
    if ui.btnp(BTN_Z) then
        EstadoGlobal = 1
    end
end

function gameover()

end

function creditos()

end

function gameplay()
    local ajuste
    ajuste = 0
    DirX = 0
    DirY = 0

    if ContadorGameOver == TempoGameOver then
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


    --    if ui.btnp(BTN_X) then
    --       Mm:zero()
    --  end

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
        ui.spr(Sprites["nave0" .. Direcao], 232, 127)
    else
        ContadorGameOver = ContadorGameOver - 1
        if ContadorGameOver == 0 then
            ContadorGameOver = TempoGameOver
            EstadoGlobal = 3
            return
        else
            ui.print("GAME OVER!!", 200, 180, 2)
        end
    end
    

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

    for i=1, #Inimigos do
        local inm = Inimigos[i]
        inm:logic(Mm)
        inm:draw(Mm)
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
                    lbx = (b:limiteAtual().x / 2)
                    lby = (b:limiteAtual().y / 2)
                    if b:natela(Mm) then
                        if b.estado <=4 and math.abs(b.x + lbx - tt.x) < lbx and math.abs(b.y + lby - tt.y) < lby then
                            b:recebeutiro()
                            Score = Score + 50
                            sfx.fx(16, 25)
                            if b.estado == 5 then
                                local u
                                u = #Bombas + 1
                                Bombas[u] = Bomba:new()
                                Bombas[u].x = b.x
                                Bombas[u].y = b.y
                                Bombas[u].estado = 0
                                Bombas[u].dirX = 0
                                Bombas[u].dirY = 0
                            end
                            tt.x = -10000
                            tt.y = -10000
                            break
                        end
                    end
                end
                for j=1, #Inimigos do
                    local c
                    c=Inimigos[j]
                    if c:natela(Mm) then
                        if math.abs(c.x + 8 - tt.x) < 8 and math.abs(c.y + 8 - tt.y) < 8 then
                            Inimigos[j].x = math.random(-400,400)
                            Inimigos[j].y = math.random(-400,400)
                            Inimigos[j].vel = math.random(1,2)
                            Score = Score + 100
                            sfx.fx(16, 50)
                            tt.x = -10000
                            tt.y = -10000
                            break
                        end
                    end
                end
            end
        end
    end
    for i=1, #Inimigos do
        local inm = Inimigos[i]
        inm:logic(Mm)
        if math.abs(inm.x + 8 - Mm.x) < 8 and math.abs(inm.y + 8 - Mm.y) < 8 then
            if ContadorGameOver == TempoGameOver then
                ContadorGameOver = TempoGameOver-1
            end
        end
        inm:draw(Mm)
    end
    for i=1, #Bombas do
        local bb = Bombas[i]
        bb:logic()
        bb:draw(Mm)

    end
    --ui.spr(Sprites.mask02, 300, 80)
    huddraw()
end
