
# 1146313142
import sys
with open(sys.argv[1], "rt") as inp:
    indice=-1
    for linha in inp:
        if indice >=0 and len(linha.strip()) > 0:
            rgb = [int(n.strip()) for n in linha.replace(" Untitled","").split(" ") if len(n.strip()) > 0]
            valor = (((rgb[2] >> 3) & 31) << 10) + (((rgb[1] >> 3) & 31) << 5) + ((rgb[0] >> 3) & 31)
            print(f"ui.palset({indice}, 0x{valor:0X})")
            indice = indice + 1
        if linha[0] == '#':
            indice = 0
        