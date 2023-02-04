-- Funciones

function EncontrarNill (X,Y,Z)
    if X == nil or Y == nil or Z == nil then
        return 1
    else
        return 0
    end
end

function DarLavuelta()
    turtle.turnLeft()
    turtle.turnLeft()
end

function PicarDirecion(Direcion)
    if Direcion == "Arriba" then
        turtle.digUp()
    elseif  Direcion == "Abajo" then
        turtle.digDown()
    elseif Direcion == "Frente" then
        turtle.dig()
    else
        error("Mala Direcion")
    end
end

function PicarDirecion(Direcion)
    if Direcion == "Arriba" then
        turtle.digUp()
    elseif  Direcion == "Abajo" then
        turtle.digDown()
    elseif Direcion == "Frente" then
        turtle.dig()
    else
        error("Mala Direcion")
    end
end

function BloqueDirecion(Direcion)
    if Direcion == "Arriba" then
        turtle.placeDown()
    elseif  Direcion == "Abajo" then
        turtle.placeUp()
    elseif Direcion == "Frente" then
        turtle.place()
    else
        error("Mala Direcion")
    end
end

function MoverDirecion(Direcion)
    if Direcion == "Arriba" then
        turtle.up()
    elseif Direcion == "Abajo" then
        turtle.down()
    elseif Direcion == "Frente" then
        turtle.forward()
    else
        error("Mala Direcion")
    end
end

function DetectDirecion(Direcion)
    if Direcion == "Arriba" then
        return turtle.detectUp()
    elseif Direcion == "Abajo" then
        return turtle.detectDown()
    elseif Direcion == "Frente" then
        return turtle.detect()
    else
        error("Mala Direcion")
    end
end

function CheckDarLavuelta(Direcion)
    if Direcion == "Frente" then
        DarLavuelta()
    end
end

function IntercambiarSloc(Sloc1,Sloc2)
    turtle.transferTo(15)
    turtle.select(2)
    turtle.transferTo(Sloc1)
    turtle.select(15)
    turtle.transferTo(Sloc2)
    turtle.select(1)
end

function Avanzar(Numero,Direcion)
    turtle.select(1)
    for i=1,Numero do
        if DetectDirecion(Direcion) then
            if turtle.getItemCount() > 0 then
                turtle.transferTo(2)
                PicarDirecion(Direcion)
                MoverDirecion(Direcion)
                CheckDarLavuelta()
                IntercambiarSloc(1,2)
                BloqueDirecion(Direcion)
                IntercambiarSloc(1,2)
                CheckDarLavuelta()
            else
                PicarDirecion(Direcion)
                MoverDirecion(Direcion)
            end
        else
            if turtle.getItemCount() > 0 then
                MoverDirecion(Direcion)
                CheckDarLavuelta()
                BloqueDirecion(Direcion)
                CheckDarLavuelta()
            else
                MoverDirecion(Direcion)
            end
        end
    end
end

function MirarAPosi(Latitu)
    -- Coger primera referencia
    FirX, FirY, FirZ = gps.locate()
    -- Dar un paso
    contador = 1
    while not turtle.forward() do
        turtle.turnLeft()
        if contador == 4 then
            tmp = turtle.getSelectedSlot()
            turtle.select(15)
            turtle.dig()
            turtle.drop()
            turtle.select(tmp)
        end
        contador = contador + 1
    end
    SecX, SecY, SecZ = gps.locate()
    -- Vuelve al punto de partida
    DarLavuelta()
    turtle.forward()
    DarLavuelta()
    -- Compara la información
    if FirX ~= SecX then
        if Latitu == "X" then
            if FirX > SecX then
                DarLavuelta()
            end
        else
            if FirX > SecX then
                turtle.turnLeft()
            else
                turtle.turnRight()
            end
        end
    elseif FirZ ~= SecZ then
        if Latitu == "Z" then
            if FirZ > SecZ then
                DarLavuelta()
            end
        else 
            if FirZ > SecZ then
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
        end
    end
end

function RecorrerDistancia (Des, Loc, Latitu)
    if Latitu == "Y" then
        Distancia = Des - Loc
        if Des > Loc then
            Avanzar(math.abs(Distancia),"Arriba")
        else
            Avanzar(math.abs(Distancia),"Abajo")
        end
    elseif Latitu == "X" then
        Distancia = Des - Loc
        if Des > Loc then
            MirarAPosi("X")
            Avanzar(math.abs(Distancia),"Frente")
        else
            MirarAPosi("X")
            DarLavuelta()
            Avanzar(math.abs(Distancia),"Frente")
        end
    elseif Latitu == "Z" then
        Distancia = Des - Loc
        if Des > Loc then
            MirarAPosi("Z")
            Avanzar(math.abs(Distancia),"Frente")
        else
            MirarAPosi("Z")
            DarLavuelta()
            Avanzar(math.abs(Distancia),"Frente")
        end
    else
        error("Mala entrada en la entrada de Latitu")
    end
end

-- Definir dicionario de libreria

return { EncontrarNill = EncontrarNill, DarLavuelta = DarLavuelta, PicarDirecion = PicarDirecion, BloqueDirecion = BloqueDirecion, MoverDirecion = MoverDirecion, DetectDirecion = DetectDirecion , CheckDarLavuelta = CheckDarLavuelta, IntercambiarSloc = IntercambiarSloc, Avanzar = Avanzar, MirarAPosi = MirarAPosi, RecorrerDistancia = RecorrerDistancia }