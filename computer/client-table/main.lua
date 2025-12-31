local basalt = require("/basalt")
local mainFrame = basalt.createFrame()
local register = require("register")
local login = require("login")

--Variables Gobales
Server = 6
registerFrame = register(mainFrame)
loginFrame = login(mainFrame)

-- Funciones

function EsperarRespuesta(protocol,time)
    id = true
    while id ~= Server and id ~= nil do
        id, message, protocol = rednet.receive(protocol,time)
    end
    return id, message, protocol
end

-- Main
rednet.open("back")
basalt.autoUpdate()
