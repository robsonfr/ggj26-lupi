require "sprites"
require "globais"


Tiro = {
    x = 0,
    y = 0,
    direcao = 1,
    natela = function(self, m)
        return m:paralocal(self.x, self.y).natela
    end,
    updatedraw = function(self, m)
        local l
        local offset
        local s
        offset = Direcoes[self.direcao]
        s = m:paralocal(self.x, self.y)
        self.x = self.x + offset.x
        self.y = self.y + offset.y
        l = m:paralocal(self.x, self.y)
        if l.natela then
            ui.line(s.x,s.y,l.x,l.y,2)
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
