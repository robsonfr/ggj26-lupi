require "palette"
require "sprites"
-- function _draw()
--     ui.cls(1)
--     ui.print("Teste Global Game Jam 2026", 80, 120, 7)
-- end 

x = 20
y = 20

function update()
    if ui.btn(LEFT) and (x > 0) then
        x = x - 1
    end
    if ui.btn(RIGHT) and (x < 460) then
        x = x + 1
    end


    ui.palset(0, 0x03E6) 
    ui.palset(1, 0x07E0) 
    ui.palset(2, 0x467A)
    ui.cls(1)
    ui.print("Teste Global Game Jam 2026", 80, 120, 2)
    ui.spr(Sprites.mask01, x, y)
end
