require "palette"
require "sprites"
require "aster"
require "mundo"
require "globais"
require "tiro"
require "hud"
require "inimigo"
require "bomba"
require "monstrao"
require "estrela"

-- Inicializacoes de globais

Mm = Mundo:new()
OMonstrao = Monstrao:new()


for i=1, 50 do
    Estrelas[i] = Estrela:new()
end

for i=1, NumAsteriodes do
    Asteroides[i] = Aster:new()
end

for i=1, MaximoTiros do
    Tiros[i] = Tiro:new()
end

for i=1, NumInimigos do
    Inimigos[i] = Inimigo:new()
end

function reset()
    MaximoTiros = 15
    CadenciaTiros = 20
    NumAsteriodes = 100
    Step = 1
    Substep = 0
    Direcao = 1
    Tempo = 0
    TempoTiro = 0
    NumBombas = 0
    VelocidadeTiro = 4
    Score = 0
    EstadoGlobal = 2
    NumInimigos = 5
    TempoGameOver=120
    ContadorGameOver = TempoGameOver
    PosicaoTitulo = 270
    AberturaMensagem = 30
    CorTextoAbertura = 3
    NivelMonstrao = 0
    Bombas = {}

    for i = 1, 20 do
        
        Asteroides[i].x = math.random(-400,400)
        Asteroides[i].y = math.random(-300,300)
        Asteroides[i].estado = math.random(1,4)
    end

    for i = 21, NumAsteriodes do
        Asteroides[i].x = math.random(-2000,2000)
        Asteroides[i].y = math.random(-1500,1500)
        Asteroides[i].estado = math.random(1,4)
    end


    for i=1, MaximoTiros do
        Tiros[i].x = -10000
        Tiros[i].y = -10000
    end

    for i=1, NumInimigos do
        Inimigos[i].x = math.random(-400,400)
        Inimigos[i].y = math.random(-400,400)
        Inimigos[i].vel = math.random(1,2)
    end
    OMonstrao.nivel = 0
    DestruiuMonstrao = false
    Mm:zero()
end

reset()


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
        if AberturaMensagem > 0 then
            AberturaMensagem = AberturaMensagem - 1
        else
            AberturaMensagem = 30
            CorTextoAbertura = 3 - CorTextoAbertura
        end
        ui.print(" ----- MONSTRAO MASCARADO --------", 40, 220, 3)
        ui.print("PRESSIONE [A] PARA INICIAR!!", 40, 240, CorTextoAbertura)
    end
    if ui.btnp(BTN_G) then
        EstadoGlobal = 1
    end
end

function gameover()
    local ns
    ns = 0
    if DestruiuMonstrao then
        ns = Score
        ui.print("PARABENS!! VOCE CONSEGUIU DESTRUIR O MONSTRAO MASCARADO!!", 20, 120, 3)
    else
        ui.print("QUE PENA!! NAO FOI DESTA VEZ", 20, 120, 3)
    end
    ui.print("SEU SCORE: " .. Score, 40, 180, 3)
    ui.print("PRESSIONE [A] PARA REINICIAR!!", 40, 240, 3)
    if ui.btnp(BTN_G) then
        reset()
        EstadoGlobal = 1
        Score = ns
    end
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

        if ui.btnp(BTN_G) and NumBombas > 0 then
            NumBombas = NumBombas - 1
            for i = 1,#Bombas do
                if Bombas[i].estado == 0 then
                    Bombas[i].estado = 2
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
                                Bombas[u].estado = 1
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
        if bb.estado == 1 then
            if math.abs(Mm.x - bb.x) <= 8 and math.abs(Mm.y - bb.y) <= 8 then
                Bombas[i].estado = 0
                NumBombas = NumBombas + 1
            else
                for j=1, #Inimigos do
                    local inm = Inimigos[j]
                    if math.abs(inm.x - bb.x) <= 8 and math.abs(inm.y - bb.y) <= 8 then
                        Bombas[i].estado = 0
                        if OMonstrao.nivel < 5 then
                            if OMonstrao.nivel == 0 then
                                OMonstrao.x = math.random(-500,500) + Mm.x
                                OMonstrao.y = math.random(-500,500) + Mm.y
                            end
                            OMonstrao.nivel = OMonstrao.nivel + 1
                        end
                    end
                end
            end
        end
    end

    for i=1, #Estrelas do
        local e
        e = Estrelas[i]
        e:draw(Mm)
    end
    if OMonstrao.nivel > 0 then
        OMonstrao:logic(Mm)
        OMonstrao:draw(Mm)

        if math.abs(OMonstrao.x - Mm.x) <= 8 and math.abs(OMonstrao.y - Mm.y) <=8 then
            if ContadorGameOver == TempoGameOver then
                ContadorGameOver = TempoGameOver-1
            end
        end

        for i=1, #Bombas do
            local bb = Bombas[i]
            if bb.estado == 2 then
                if math.abs(OMonstrao.x - bb.x) <= 40 and math.abs(OMonstrao.y - bb.y) <= 40 then
                    OMonstrao.nivel = OMonstrao.nivel - 2
                    if OMonstrao.nivel <= 0 then
                        DestruiuMonstrao = true
                        if ContadorGameOver == TempoGameOver then
                            ContadorGameOver = TempoGameOver-1
                        end
                    end
                end
            end
        end
    end

    --ui.spr(Sprites.mask02, 300, 80)
    huddraw()
end
