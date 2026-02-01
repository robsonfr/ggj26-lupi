require "sprites"
require "mundo"

Aster = {
    x = 0,
    y = 0,
    estado=1,
    vida=0,
    limites = {
        {x=22,y=16, s=1, t=0},
        {x=19,y=16, s=1, t=0},
        {x=16,y=13, s=2, t=0},
        {x=14,y=10, s=5, t=4},
        {x=0,y=0, s=0, t=0},
    },
    draw = function(self, m)
        local l
        if self.estado < 5 then
            l = m:paralocal(self.x, self.y)
            if l.natela then
                ui.spr(Sprites["aster0" .. self.estado], l.x, l.y)
            end
        end
    end,
    limiteAtual = function(self)
        return self.limites[self.estado]
    end,
    natela = function(self, m)
        return m:paralocal(self.x, self.y).natela
    end,
    bateu = function(self, m)
        local l
        local limite
        if self.estado == 5 then
            return false
        end
        l = m:paralocal(self.x, self.y)
            if l.natela then
                limite = self.limites[self.estado]
                if (l.x + limite.s <= 232 + 16) and (l.x + limite.s + limite.x >= 232) and (l.y + limite.t <= 127 + 16) and (l.y + limite.t + limite.y >= 127) then
                    return true
                end
            end
        return false
    end,
    recebeutiro = function(self)
        if self.estado < 5 then
            self.estado = self.estado + 1
        end
    end
}

function Aster:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end