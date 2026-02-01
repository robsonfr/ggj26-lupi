require "globais"

Bomba = {
    x = 0,
    y = 0,
    dirX = 0,
    dirY = 0,
    cor = 3,
    tcor = 30,
    estado = 0,
    draw = function(self,m)
        local l
        l = m:paralocal(self.x, self.y)
        if l.natela then
            ui.rectfill(l.x-1,l.y-1,l.x+1,l.y+1,self.cor)
            self.tcor = self.tcor - 1
            if self.tcor == 0 then
                self.tcor = 30
                self.cor = 7 - self.cor
            end
        end
    end,
    logic = function(self)
        if self.estado == 1 then
            
        end
    end
}

function Bomba:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end