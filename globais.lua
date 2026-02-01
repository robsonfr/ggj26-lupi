Direcoes = {
    { x=0, y=-1, op=3, posTiro = {x=0,y=-1} },
    { x=1, y=0, op=4, posTiro = {x=1,y=0} },
    { x=0, y=1, op=1, posTiro = {x=0,y=1} },
    { x=-1, y=0, op=2, posTiro = {x=-1, y=0} },
    { x=1, y=-1, op=7, posTiro = {x=1,y=-1}},
    { x=1, y=1, op=8, posTiro = {x=1, y=1} },
    { x=-1,y=1, op=5, posTiro = {x=-1,y=1}},
    { x=-1, y=-1, op=6, posTiro = {x=-1,y=-1} }
}

Asteroides = {}
MaximoTiros = 30
CadenciaTiros = 5

for i = 1, 20 do
    Asteroides[i] = Aster:new()
    Asteroides[i].x = math.random(-400,400)
    Asteroides[i].y = math.random(-320,320)
    Asteroides[i].estado = math.random(1,4)
end

Mm = Mundo:new()

Step = 1
Substep = 0

Direcao = 1
Tiros = {}
for i=1, MaximoTiros do
    Tiros[i] = Tiro:new()
    Tiros[i].x = -1000
    Tiros[i].y = -1000
end

Tempo = 0
TempoTiro = 0
