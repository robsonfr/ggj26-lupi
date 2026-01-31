require "palette"
require "sprites"
-- function _draw()
--     ui.cls(1)
--     ui.print("Teste Global Game Jam 2026", 80, 120, 7)
-- end 

x = 20
y = 20

step = 1
substep = 0

function update()
    local ajuste
    ajuste = 0
    if ui.btn(LEFT) and (x > step) then
        x = x - step
        ajuste = 1
    end
    if ui.btn(RIGHT) and (x < 460-step) then
        x = x + step
        ajuste = 1
    end

    if ui.btn(UP) and (y > step) then
        y = y - step
        ajuste = 1
    end
    if ui.btn(DOWN) and (y < 250-step) then
        y = y + step
        ajuste = 1
    end
    if ajuste == 1 then
        substep = substep + 1
        if substep >= 10 then
            step = step + 1
        end
    else
        substep = 0
        step = 1
    end


    ui.palset(0, 0x03E6) 
    ui.palset(1, 0x07E0) 
    ui.palset(2, 0x467A)
    ui.cls(1)
    ui.print("Teste Global Game Jam 2026", 80, 120, 2)
    ui.spr(Sprites.mask01, x, y)
end
