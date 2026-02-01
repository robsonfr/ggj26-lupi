require "sprites"
require "globais"

VelocidadeInimigo = 2

Inimigo = {
    x = 0,
    y = 0,
    dirX = 0,
    dirY = 0,
    pegouMinerio = false,
    draw = function(self, m)
        self.x = self.x + self.dirX * math.random(1,VelocidadeInimigo)
        self.y = self.y + self.dirY * math.random(1,VelocidadeInimigo)
        local l = m:paralocal(self.x, self.y)
        if l.natela then
            ui.spr(Sprites.mask01, l.x, l.y)
        end
    end,
    logic = function(self, m)
        -- Verificar se ha minerio perto
        -- Verificar se esta perto da nave
        local l = m:paralocal(self.x, self.y)
        if l.natela then
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

        end
    end
}

function Inimigo:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end