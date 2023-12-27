-- Sloct especiales

-- EL sloct 1 y 2 son especiales para guardar piedras en medio del camino revisar funcion "Avanzar"
-- El sloct 15 es necesario que se quede vacio para utilizarlo como tmp

-- Libreria

movilidad = require("functions")

-- Variables

AlturaDeTransito = 100

-- Destino
DesX = tonumber(arg[1])
DesY = tonumber(arg[2])
DesZ = tonumber(arg[3])

-- main

movilidad.MoverA(DesX, DesY, DesZ, AlturaDeTransito)