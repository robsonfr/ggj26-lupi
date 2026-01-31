require "palette"
require "sprites"
-- function _draw()
--     ui.cls(1)
--     ui.print("Teste Global Game Jam 2026", 80, 120, 7)
-- end 

x = 230
y = 140

a_x = 100
a_y = 100

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
            substep = 0
        end
    else
        substep = 0
        step = 1
    end

    ui.palset(0, 0x0)
    ui.palset(1, 0x63E2)
    ui.palset(2, 0x46C1)
    ui.palset(3, 0x3A41)
    ui.palset(4, 0x7F82)
    ui.palset(5, 0x5EA1)
    ui.palset(6, 0x4A01)
    ui.palset(7, 0x95F)
    ui.palset(8, 0x4F8)
    ui.palset(9, 0x4B0)
    ui.palset(10, 0x7C47)
    ui.palset(11, 0x6026)
    ui.palset(12, 0x5024)
    ui.palset(13, 0x7C5B)
    ui.palset(14, 0x5432)
    ui.palset(15, 0x7FFF)
    ui.cls(0)
    ui.print("Teste Global Game Jam 2026", 200, 260, 2)
    ui.spr(Sprites.mask01, x, y)
    ui.spr(Sprites.aster01, a_x, a_y)
end
