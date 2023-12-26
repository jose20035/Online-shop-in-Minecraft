-- Funciones

function EncontrarNill (X,Y,Z)
    if X == nil or Y == nil or Z == nil then
        return true
    else
        return false
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

function PonerBloqueDetras(Direcion)
    CheckDarLavuelta(Direcion)
    IntercambiarSloc()
    BloqueDirecion(Direcion)
    IntercambiarSloc()
    CheckDarLavuelta(Direcion)
end

function IntercambiarSloc()
    if turtle.getSelectedSlot() == 1 then
        turtle.select(2)
    elseif turtle.getSelectedSlot() == 2 then
        turtle.select(1)
    end
end

function getSlococcupied()
    if turtle.getItemCount(2) ~= 0 then
        return 2
    end
    return 1
end

function Avanzar(Numero,Direcion)
    for i=1,Numero do
        --Revisar Slot selecionado correcto
        if turtle.getSelectedSlot() ~= 1 or turtle.getSelectedSlot() ~= 2 then
            turtle.select(getSlococcupied())
        end
        --Intercambiar Sloc vacio
        TengoBloque = false
        while(turtle.getItemCount() ~= 0) do
            TengoBloque = true
            IntercambiarSloc()
        end
        --Mover Direcion
        if DetectDirecion(Direcion) then
            PicarDirecion(Direcion)
            MoverDirecion(Direcion)
            if TengoBloque then
                PonerBloqueDetras(Direcion)
            end
        else
            MoverDirecion(Direcion)
            if TengoBloque then
                PonerBloqueDetras(Direcion)
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

return { EncontrarNill = EncontrarNill, RecorrerDistancia = RecorrerDistancia }