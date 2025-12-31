local basalt = require("/basalt")

return function(mainFrame)
    -- Create subFrame
    local ItemList = mainFrame:addFrame()
    :setPosition(2,"parent.h/2")
    :setSize("parent.w-2", "parent.h/2-1")
    :setBackground(colors.black)
    :show()

    -- Defincir objetos
    local aList = ItemList:addList()
    :setPosition(1,1)
    :setSize("parent.w-1","parent.h")
    :setForeground(colors.white)
    :setBackground(colors.cyan)
    :setSelectionColor(colors.blue)

    
    
    aList:addItem("64x Diamantes - chest(1,2)",colors.blue)
    aList:addItem("2x EnderPerl - chest(1)",colors.blue)
    aList:addItem("1x Iron Ingot - chest(2)",colors.blue)


    return ItemList
end