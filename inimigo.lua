require "sprites"
require "globais"

VelocidadeInimigo = 2

Inimigo = {
    x = 0,
    y = 0,
    dirX = 0,
    dirY = 0,
    vel = 0,
    pegouMinerio = false,
    draw = function(self, m)
        local l = m:paralocal(self.x, self.y)
        if l.natela then
            ui.spr(Sprites.mask01, l.x, l.y)
        end
    end,
    natela = function(self, m)
        return m:paralocal(self.x, self.y).natela
    end,
    logic = function(self, m)
        -- Verificar se ha minerio perto
        -- Verificar se esta perto da nave
        local l = m:paralocal(self.x, self.y)
        if m.x < self.x then
            self.dirX = -1
        end
        if m.x > self.x then
            self.dirX = 1
        end
        if m.y < self.y then
            self.dirY = -1
        end
        if m.y > self.y then
            self.dirY = 1
        end
        self.x = self.x + self.dirX * self.vel
        self.y = self.y + self.dirY * self.vel


    end
}

function Inimigo:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end