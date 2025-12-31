local basalt = require("/basalt")
local monitor = peripheral.wrap("monitor_0")
local ItemList = require("ItemList")

local mainFrame = basalt.addMonitor()
    :setMonitor(monitor)
    :setBackground(colors.lightGray)

--Variables Globales
Server = 6
ItemListSubFrame = ItemList(mainFrame)

-- Defincir objetos Globales

local BackgroundTitleStorage = mainFrame:addLabel()
    :setPosition(1,1)
    :setText("")
    :setSize(29,5)
    :setBackground(colors.orange)

local LabelTitleLogin = mainFrame:addLabel()
    :setPosition(5,2)
    :setText("Storage")
    :setForeground(colors.blue)
    :setBackground(colors.orange)
    :setFontSize(2)

local ProgressbarGlobal = mainFrame:addProgressbar()
    :setSize(25,1)
    :setPosition(3,8)
    :setDirection("right")
    :setProgress(20)
    :setProgressBar(colors.blue)

-- Main
basalt.debug(ItemListSubFrame:getSize())
basalt.autoUpdate()