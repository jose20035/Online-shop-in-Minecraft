local basalt = require("basaltWeb")
local hash = require("hash")
local login = basalt.createFrame()

--Variables

Server = 8

-- Defincir objetos

-- login

local EnviarLogin = login:addButton()
    :setText("Enviar")
    :setPosition(17,16)
    :setBackground(colors.red)
    :setSize(8,3)

local GoCreateUser = login:addButton()
    :setText("Registrarse")
    :setPosition(3,16)
    :setBackground(colors.red)
    :setSize(11,3)

local ImpUsuario = login:addInput()
    :setPosition(10,7)

local LabelUsuario = login:addLabel()
    :setText("User:")
    :setPosition(4,7)

local ImpPass = login:addInput()
    :setPosition(10,9)
    :setInputType("password")

local LabelUsuario = login:addLabel()
    :setText("Pass:")
    :setPosition(4,9)

local LabelError = login:addLabel()
    :hide()
    :setText("Pass incorrecta o usuario no encontrado")
    :setPosition(4,12)
    :setForeground(colors.red)

local LabelEntrando = login:addLabel()
    :hide()
    :setText("Entrando ...")
    :setPosition(4,12)
    :setForeground(colors.green)

local LabelErrorServer = login:addLabel()
    :hide()
    :setText("Error con el servidor")
    :setPosition(4,12)
    :setForeground(colors.red)

local BackgroundTitleLogin = login:addLabel()
    :setPosition(1,1)
    :setText("")
    :setSize(26,4)
    :setBackground(colors.orange)

local LabelTitleLogin = login:addLabel()
    :setPosition(7,2)
    :setText("Login")
    :setFontSize(2)
    :setForeground(colors.blue)
    :setBackground(colors.orange)

-- Funciones

function EsperarRespuesta(protocol,time)
    id = true
    while id ~= Server and id ~= nil do
        id, message, protocol = rednet.receive(protocol,time)
    end
    return id, message, protocol
end

-- Funcones de objetos

EnviarLogin:onClick(basalt.schedule(function(self)
    self:setBackground(colors.green)
    rednet.send(Server,ImpUsuario:getValue(),"login")
    id, message, protocol = EsperarRespuesta("login",10)
    if id == Server then
        if message == hash.sha256(ImpPass:getValue()) then
            LabelErrorServer:hide()
            LabelError:hide()
            LabelEntrando:show()
        else
            LabelErrorServer:hide()
            LabelEntrando:hide()
            LabelError:show()
        end
    elseif id == nil then
        LabelError:hide()
        LabelEntrando:hide()
        LabelErrorServer:show()
    end
    sleep(2)
    LabelErrorServer:hide()
    LabelError:hide()
    LabelEntrando:hide()
    self:setBackground(colors.red)
end))

GoCreateUser:onClick(basalt.schedule(function(self)
    self:setBackground(colors.green)
    sleep(0.2)
    register.register:show()
    self:setBackground(colors.red)
end))

return { login = login }