-- function _draw()
--     ui.cls(1)
--     ui.print("Teste Global Game Jam 2026", 80, 120, 7)
-- end 

function update()
    ui.palset(0, 0x03E6) 
    ui.palset(1, 0x07E0) 
    ui.palset(2, 0x467A)
    ui.cls(1)
    ui.print("Teste Global Game Jam 2026", 80, 120, 7)
    ui.spr(Sprites.mask01, 20, 20)
end
