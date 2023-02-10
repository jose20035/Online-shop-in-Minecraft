--Funtion

function ReadUserjson()
    file = fs.open("/home/data/user.json","r")
    datastr = file.readAll()
    file.close()
    return textutils.unserialiseJSON(datastr)
end

function WriteUserjson(data)
    file = fs.open("/home/data/user.json","w")
    file.write(textutils.serialiseJSON(data))
    file.close()
end

function SearchPass(data,NameUser)
    for _,User in ipairs(data) do
        if NameUser == User["Name"] then
            return User["Pass"]
        end
    end
    return false
end

function SearchUser(data,NameUser)
    for _,User in ipairs(data) do
        if NameUser == User["Name"] then
            return true
        end
    end
    return false
end

--Main

peripheral.find("modem", rednet.open)
while true do
    id, message, protocol = rednet.receive()
    if protocol == "login" then
        dataUser = ReadUserjson()
        pass = SearchPass(dataUser,message)
        rednet.send(id,pass,protocol)
    elseif protocol == "createuser" then
        dataUser = ReadUserjson()
        if SearchUser(dataUser,message["Name"]) then
            rednet.send(id,false,protocol)
        else
            table.insert(dataUser,message)
            WriteUserjson(dataUser)
            rednet.send(id,true,protocol)
        end
    end
end

rednet.close()
