require "palette"
require "sprites"
require "aster"
require "mundo"
-- function _draw()
--     ui.cls(1)
--     ui.print("Teste Global Game Jam 2026", 80, 120, 7)
-- end 

x = 230
y = 140

asteroides = {}
for i = 1, 10 do
    asteroides[i] = Aster:new()
    asteroides[i].x = math.random(-400,400)
    asteroides[i].y = math.random(-320,320)
    asteroides[i].estado = math.random(1,4)
end


mm = Mundo:new()
a_x = 100
a_y = 100

step = 1
substep = 0

estado = 1
direcao = 1

function update()
    local ajuste
    ajuste = 0
    if ui.btn(LEFT) then
        direcao = 4
        ajuste = 1
    end
    if ui.btn(RIGHT) then
        direcao = 2
        ajuste = 1
    end
    if ui.btn(UP) then
        direcao = 1
        ajuste = 1
    end
    if ui.btn(DOWN) then
        direcao = 3
        ajuste = 1
    end

    if ajuste == 1 then
        if direcao == 1 then
            mm:move_y(-step)
        elseif direcao == 2 then
            mm:move_x(step)
        elseif direcao == 3 then
            mm:move_y(step)
        elseif direcao == 4 then
            mm:move_x(-step)
        end
        substep = substep + 1
        if substep >= 10 then
            step = step + 1
            substep = 0
        end
    else
        substep = 0
        step = 1
    end

    -- if ui.btn(LEFT) and (x > step) then
    --     x = x - step
    --     ajuste = 1
    -- end
    -- if ui.btn(RIGHT) and (x < 460-step) then
    --     x = x + step
    --     ajuste = 1
    -- end

    -- if ui.btn(UP) and (y > step) then
    --     y = y - step
    --     ajuste = 1
    -- end
    -- if ui.btn(DOWN) and (y < 250-step) then
    --     y = y + step
    --     ajuste = 1
    -- end
    -- if ajuste == 1 then
    --     substep = substep + 1
    --     if substep >= 10 then
    --         step = step + 1
    --         substep = 0
    --     end
    -- else
    --         step = 1
    --         substep = 0

    -- end


    for i = 1, #Palette do
        ui.palset(i-1, Palette[i])
    end
    -- ui.palset(0, 0x0)
    -- ui.palset(1, 0xBF8)
    -- ui.palset(2, 0x6D1)
    -- ui.palset(3, 0x64E)
    -- ui.palset(4, 0xB9F)
    -- ui.palset(5, 0x6B7)
    -- ui.palset(6, 0x612)
    -- ui.palset(7, 0x7D42)
    -- ui.palset(8, 0x60E1)
    -- ui.palset(9, 0x40A1)
    -- ui.palset(10, 0x1C5F)
    -- ui.palset(11, 0x1838)
    -- ui.palset(12, 0x1034)
    -- ui.palset(13, 0x6C5F)
    -- ui.palset(14, 0x4835)
    -- ui.palset(15, 0x7FFF)
    if ui.btnp(BTN_Z) then
        mm:zero()
    end
    -- if ui.btnp(BTN_Z) and estado < 4 then
    --     estado = estado + 1
    -- end

    -- if ui.btnp(BTN_X) and estado > 1 then
    --     estado = estado - 1
    -- end

    ui.cls(0)
    ui.print("Monstrao Mascarado", 200, 260, 2)
    ui.spr(Sprites["nave0" .. direcao], 232, 127)
    for i = 1, 10 do
        asteroides[i]:draw(mm)
    end
    -- ui.spr(Sprites["aster0" .. estado], a_x, a_y)
    ui.spr(Sprites["mask01"], 160, 100)
    ui.spr(Sprites["mask01"], 360, 100)
end
