require "globais"

TempoCorBomba = 15

Bomba = {
    x = 0,
    y = 0,
    dirX = 0,
    dirY = 0,
    cor = 3,
    tcor = TempoCorBomba,
    estado = 0,
    draw = function(self,m)
        local l
        l = m:paralocal(self.x, self.y)
        if l.natela and self.estado > 0 then
            ui.rectfill(l.x-1,l.y-1,l.x+1,l.y+1,self.cor)
            self.tcor = self.tcor - 1
            if self.tcor == 0 then
                self.tcor = TempoCorBomba
                self.cor = 7 - self.cor
            end
        end
    end,
    logic = function(self)
        if self.estado == 2 then
            if OMonstrao.nivel  > 0 then
                if OMonstrao.x > self.x then
                    self.dirX = 1
                end
                if OMonstrao.x < self.x then
                    self.dirX = -1
                end
                if OMonstrao.y > self.y then
                    self.dirY = 1
                end
                if OMonstrao.x < self.x then
                    self.dirY = -1
                end
            else
                self.dirX = Direcoes[Direcao].x
                self.dirY = Direcoes[Direcao].y
            end
            for i = 1,#Inimigos do
                local inm
                inm = Inimigos[i]
                if math.abs(inm.x - self.x) <= 2 and math.abs(inm.y - self.y) <= 2 then
                    Inimigos[i].x = math.random(-400,400)
                    Inimigos[i].y = math.random(-400,400)
                    Inimigos[i].vel = math.random(1,2)
                    Score = Score + 100
                    sfx.fx(16, 15)
                    self.estado = 0
                    break
                end
            end
        end
    end
}

function Bomba:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end