-- Sloct especiales

-- EL sloct 1 y 2 son especiales para guardar piedras en medio del camino revisar funcion "Avanzar"
-- El sloct 15 es necesario que se quede vacio para utilizarlo como tmp

-- Libreria

movilidad = require("functions")

-- Variables

AlturaDeTransito = 73

-- Destino
DesX = tonumber(arg[1])
DesY = tonumber(arg[2])
DesZ = tonumber(arg[3])

-- Actual

LocX, LocY, LocZ = gps.locate()

-- main

if movilidad.EncontrarNill(DesX,DesY,DesZ) == 1 then
    print("Faltan 3 argumentos que corresponden a la posición del destino en el siguiente orden (X Y Z).")
else
    movilidad.RecorrerDistancia(AlturaDeTransito,LocY,"Y")
    LocX, LocY, LocZ = gps.locate()
    movilidad.RecorrerDistancia(DesX,LocX,"X")
    movilidad.RecorrerDistancia(DesZ,LocZ,"Z")
    movilidad.RecorrerDistancia(DesY,LocY,"Y")

end