require "sprites"

Aster = {
    x = 240,
    y = 150,
    estado=1,
    draw = function(self)
        ui.spr(Sprites["aster0" .. estado], self.x, self.y)
    end
}