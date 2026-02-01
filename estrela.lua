require "globais"

Estrela = {
    x = math.random(-240, 240),
    y = math.random(-135, 135),
    draw = function(self, m)
        local l
        l = m:paralocal(self.x, self.y)
        if l.natela then
            ui.line(self.x, self.y, self.x, self.y, 3)
        else
            self.x = math.random(-240, 240)
            self.y = math.random(-135, 135)
        end
    end
}

function Estrela:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end