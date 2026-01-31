require "sprites"
require "globais"


Tiro = {
    x = 0,
    y = 0,
    direcao = 1,
    updatedraw = function(self, m)
        local l
        local offset
        local mx
        local my
        offset = Direcoes[self.direcao]
        mx = self.x
        my = self.y
        self.x = self.x + offset.x
        self.y = self.y + offset.y
        l = m:paralocal(self.x, self.y)
        if l.natela then
            ui.line(mx,my,l.x,l.y,2)
            return true
        end
        return false
    end
}

function Tiro:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
