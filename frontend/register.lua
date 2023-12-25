local basalt = require("basaltWeb")
local register = basalt.createFrame()

--Variables

Server = 8

-- Defincir objetos

local EnviarCreate = register:addButton()
    :setText("Enviar")
    :setPosition(17,16)
    :setBackground(colors.red)
    :setSize(8,3)

local GoInicio = register:addButton()
    :setText("Inicio")
    :setPosition(4,16)
    :setBackground(colors.red)
    :setSize(8,3)

local BackgroundTitleCreate = register:addLabel()
    :setPosition(1,1)
    :setText("")
    :setSize(26,4)
    :setBackground(colors.orange)

local LabelTitleCreate = register:addLabel()
    :setPosition(2,2)
    :setText("Registro")
    :setFontSize(2)
    :setBackground(colors.orange)
    :setForeground(colors.blue)
    :setSize(26,3)

local ImpUsuarioCreate = register:addInput()
    :setPosition(10,7)

local LabelUsuarioCreate = register:addLabel()
    :setText("User:")
    :setPosition(4,7)

local ImpPassCreate = register:addInput()
    :setPosition(10,9)
    :setInputType("password")

local LabelUsuarioCreate = register:addLabel()
    :setText("Pass:")
    :setPosition(4,9)

local LabelErrorServerCreate = register:addLabel()
    :hide()
    :setText("Error con el servidor")
    :setPosition(4,12)
    :setForeground(colors.red)

local LabelErrorEmpyCreate = register:addLabel()
    :hide()
    :setText("Error pass o user vacio")
    :setPosition(3,12)
    :setForeground(colors.red)

local LabelErrorExistCreate = register:addLabel()
    :hide()
    :setText("Usuario existente")
    :setPosition(4,12)
    :setForeground(colors.red)

local LabelDoneCreate = register:addLabel()
    :hide()
    :setText("¡ Usuario creado !")
    :setPosition(4,12)
    :setForeground(colors.blue)

-- Funciones

function EsperarRespuesta(protocol,time)
    id = true
    while id ~= Server and id ~= nil do
        id, message, protocol = rednet.receive(protocol,time)
    end
    return id, message, protocol
end

-- Funcones de objetos

EnviarCreate:onClick(basalt.schedule(function(self)
    self:setBackground(colors.green)
    if ImpUsuarioCreate:getValue() == "" or ImpPassCreate:getValue() == "" then
        LabelErrorEmpyCreate:show()
    else
        info = {Name = ImpUsuarioCreate:getValue(),Pass = hash.sha256(ImpPassCreate:getValue())}
        rednet.send(Server,info,"createuser")
        id, message, protocol = EsperarRespuesta("createuser",10)
        if id == Server then
            if message == true then
                LabelErrorEmpyCreate:hide()
                LabelErrorServerCreate:hide()
                LabelErrorExistCreate:hide()
                LabelDoneCreate:show()
                sleep(2)
                login.login:show()
            else
                LabelErrorEmpyCreate:hide()
                LabelErrorServerCreate:hide()
                LabelErrorExistCreate:show()
            end
        elseif id == nil then
            LabelErrorEmpyCreate:hide()
            LabelErrorExistCreate:hide()
            LabelErrorServerCreate:show()
        end
    end
    sleep(2)
    LabelErrorEmpyCreate:hide()
    LabelErrorServerCreate:hide()
    LabelErrorExistCreate:hide()
    LabelDoneCreate:hide()
    self:setBackground(colors.red)
end))

GoInicio:onClick(basalt.schedule(function(self)
    self:setBackground(colors.green)
    sleep(0.2)
    login.login:show()
    self:setBackground(colors.red)
end))

return { register = register }