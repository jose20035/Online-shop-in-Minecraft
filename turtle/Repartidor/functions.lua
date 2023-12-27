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

function ComprobarLatitudPositiva(Des,Loc)
    if Des > Loc then
        return true
    end
    return false
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

function MirarAPosi(Latitud)
    -- Revisar String
    if Latitud == nil then
        error("Latitud erronea")
    else
        tostring(Latitud)
    end
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
    
    -- Compara la información
    --Esta Mirando X
    if SecX > FirX then
        if Latitud == "X" then
            return gps.locate()
        elseif Latitud == "-X" then
            DarLavuelta()
            return gps.locate()
        elseif Latitud == "Z" then
            turtle.turnRight()
            return gps.locate()
        elseif Latitud == "-Z" then
            turtle.turnLeft()
            return gps.locate()
        end
    end
    
    --Esta Mirando -X
    if FirX > SecX then
        if Latitud == "X" then
            DarLavuelta()
            return gps.locate()
        elseif Latitud == "-X" then
            return gps.locate()
        elseif Latitud == "Z" then
            turtle.turnLeft()
            return gps.locate()
        elseif Latitud == "-Z" then
            turtle.turnRight()
            return gps.locate()
        end
    end
    
    --Esta mirando Z
    if SecZ > FirZ then
        if Latitud == "X" then
            turtle.turnLeft()
            return gps.locate()
        elseif Latitud == "-X" then
            turtle.turnRight()
            return gps.locate()
        elseif Latitud == "Z" then
            return gps.locate()
        elseif Latitud == "-Z" then
            DarLavuelta()
            return gps.locate()
        end
    end
    --Esta mirando -Z
    if FirZ > SecZ then
        if Latitud == "X" then
            turtle.turnRight()
            return gps.locate()
        elseif Latitud == "-X" then
            turtle.turnLeft()
            return gps.locate()
        elseif Latitud == "Z" then
            DarLavuelta()
            return gps.locate()
        elseif Latitud == "-Z" then
            return gps.locate()
        end
    end
end

function RecorrerCordenadas(Des, Loc, Vertice)
    -- Revisar String
    if Vertice == nil then
        error("Latitud Vacia")
    elseif Vertice ~= "Vertical" and Vertice ~= "Horizontal" then
        error("Latitud erronea")
    end

    --Vertice Vertical
    if Vertice == "Vertical" then
        Distancia = Des - Loc
        if Des > Loc then
            Avanzar(math.abs(Distancia),"Arriba")
        else
            Avanzar(math.abs(Distancia),"Abajo")
        end
    end

    -- --Vertice Horizontal
    
    if Vertice == "Horizontal" then
        Distancia = Des - Loc
        Avanzar(math.abs(Distancia),"Frente")
    end
end

function MoverA(DesX, DesY, DesZ, AlturaDeTransito)
    -- Revisar Numeros de Cordenadas
    if EncontrarNill(DesX,DesY,DesZ) then
        error("Faltan 3 argumentos que corresponden a la posición del destino en el siguiente orden (X Y Z).")
    end

    -- Sacar cordenadas actuales
    LocX, LocY, LocZ = gps.locate()
    
    --Ir a altura de transito
    RecorrerCordenadas(AlturaDeTransito,LocY,"Vertical")

    --Mover X
    if ComprobarLatitudPositiva(DesX,LocX) then
        LocX, LocY, LocZ = MirarAPosi("X")
        RecorrerCordenadas(DesX,LocX,"Horizontal")
        -- Mover Z
        if ComprobarLatitudPositiva(DesZ,LocZ) then
            turtle.turnRight()
            RecorrerCordenadas(DesZ,LocZ,"Horizontal")
        else
            turtle.turnLeft()
            RecorrerCordenadas(DesZ,LocZ,"Horizontal")
        end
    else
        LocX, LocY, LocZ = MirarAPosi("-X")
        RecorrerCordenadas(DesX,LocX,"Horizontal")
        -- Mover Z
        if ComprobarLatitudPositiva(DesZ,LocZ) then
            turtle.turnLeft()
            RecorrerCordenadas(DesZ,LocZ,"Horizontal")
        else
            turtle.turnRight()
            RecorrerCordenadas(DesZ,LocZ,"Horizontal")
        end
    end

    --Bajar altura de transito
    RecorrerCordenadas(DesY,AlturaDeTransito,"Vertical")
end

-- Definir dicionario de libreria

return { MoverA = MoverA }