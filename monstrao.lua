require "sprites"
require "globais"

Monstrao = {
    x = 0,
    y = 0,
    dirX = 0,
    dirY = 0,
    nivel = 0,
    draw = function(self, m)
        local l
        l = m:paralocal(self.x, self.y)
        if self.nivel > 0 and l.natela then
            ui.spr(Sprites["mask020" .. self.nivel], l.x, l.y)
        end
    end,
    logic = function(self, m)
        if self.nivel >= 2 then
            if m.x > self.x then
                self.dirX = 1
            end
            if m.x < self.x then
                self.dirX = -1
            end
            if m.y > self.y then
                self.dirY = 1
            end
            if m.y < self.y then
                self.dirY = -1
            end
        end
        if self.nivel > 0 and math.random(1,100) < 900 then
            self.x = self.x + self.dirX * 5
            self.y = self.y + self.dirY * 5
        end
    end
}

function Monstrao:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end