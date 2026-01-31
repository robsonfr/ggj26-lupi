width = 480
height = 270

center_x = width / 2
center_y = height / 2

Mundo = {
    x = 0,
    y = 0,
    paralocal = function(self, ox, oy)
        lx=(ox-self.x)+center_x
        ly=(oy-self.y)+center_y
        natela=true
        if lx < 0 or lx > width or ly < 0 or ly > height then
            natela=false
        end
        return { x=lx, y=ly, natela=natela }
    end,
    move_x = function(self, dx)
        if dx < 0 and self.x > -width then
            self.x = self.x + dx
        end
        if dx > 0 and self.x < width then
            self.x = self.x + dx
        end
    end,
    move_y = function(self, dy)
        if dy < 0 and self.y > -height then
            self.y = self.y + dy
        end
        if dy > 0 and self.y < height then
            self.y = self.y + dy
        end
    end,
    move = function(self, dx, dy)
        self.move_x(dx)
        self.move_y(dy)
    end,
    zero = function(self)
        self.x = 0
        self.y = 0
    end
}

function Mundo:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end