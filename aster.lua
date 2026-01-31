require "sprites"
require "mundo"

Aster = {
    x = 0,
    y = 0,
    estado=1,
    draw = function(self, m)
        if estado < 5 then
            l = m.paralocal(self.x, self.y)
            if l.natela then
                ui.spr(Sprites["aster0" .. estado], l.x, l.y)
            end
        end
    end,
    atingiu = function(self)
        if estado < 5 then
            estado = estado + 1
        end
    end
}

function Aster:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end