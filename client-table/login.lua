local basalt = require("/basalt")
local hash = require("hash")

return function(mainFrame)
    -- Create subFrame
    local login = mainFrame:addFrame()
    :setSize(26,20)
    :setBackground(colors.lightGray)
    :show()

    -- Defincir objetos
    local EnviarLogin = login:addButton()
        :setText("Enviar")
        :setPosition(17,16)
        :setBackground(colors.red)
        :setSize(8,3)

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
        :setForeground(colors.blue)
        :setBackground(colors.orange)
        :setFontSize(2)

    local GoRegister = login:addButton()
        :setText("Registrarse")
        :setPosition(3,16)
        :setBackground(colors.red)
        :setSize(11,3)
    
    local EnviarLogin = login:addButton()
        :setText("Enviar")
        :setPosition(17,16)
        :setBackground(colors.red)
        :setSize(8,3)

    -- Funcones de objetos 
    GoRegister:onClick(basalt.schedule(function(self)
        self:setBackground(colors.green)
        sleep(0.2)
        self:setBackground(colors.red)
        loginFrame:hide()
        registerFrame:show()
    end))

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

    return login
end