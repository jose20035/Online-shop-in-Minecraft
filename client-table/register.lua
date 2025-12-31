local basalt = require("/basalt")
local hash = require("hash")

return function(mainFrame)
    -- Create subFrame
    local register = mainFrame:addFrame()
    :setSize(26,20)
    :setBackground(colors.lightGray)
    :hide()

    -- Defincir objetos
    local BackgroundTitleCreate = register:addLabel()
        :setPosition(1,1)
        :setText("")
        :setSize(26,4)
        :setBackground(colors.orange)
    
    local LabelTitleCreate = register:addLabel()
        :setPosition(2,2)
        :setText("Registro")
        :setBackground(colors.orange)
        :setForeground(colors.blue)
        :setFontSize(2)
    
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

    local GoLogin = register:addButton()
        :setText("Inicio")
        :setPosition(4,16)
        :setBackground(colors.red)
        :setSize(8,3)

    local EnviarCreate = register:addButton()
        :setText("Enviar")
        :setPosition(17,16)
        :setBackground(colors.red)
        :setSize(8,3)

    -- Funcones de objetos
    GoLogin:onClick(basalt.schedule(function(self)
        self:setBackground(colors.green)
        sleep(0.2)
        self:setBackground(colors.red)
        registerFrame:hide()
        loginFrame:show()
    end))

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
                    registerFrame:hide()
                    loginFrame:show()
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

    return register
end