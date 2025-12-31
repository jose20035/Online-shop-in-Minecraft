-- Evento detección de item en cofres
-- Variables
local chects = { peripheral.find("minecraft:chest") }
local DataFile = "/chests.json"


-- Function
local function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

local function ReadUserjson(File)
    file = fs.open(File,"r")
    datastr = file.readAll()
    file.close()
    if datastr == "[]" or datastr == ""  then
        return {}
    end
    return textutils.unserialiseJSON(datastr)
end

local function WriteUserjson(File, data)
    file = fs.open(File,"w")
    file.write(textutils.serialiseJSON(data))
    file.close()
end

local function CheckItems(ChestItem, DataItems)
    for slot, item in pairs(ChestItem) do
        if DataItems[slot] == nil then
            return false
        elseif not (DataItems[slot]["name"] == item.name and DataItems[slot]["count"] ==item.count) then
            return false
        end
    end
    return true
end

-- Chequea si los datos estan sincronizado
local function CheckSynData(Data, chest)
    if Data[peripheral.getName(chest)] == nil then
        Data[peripheral.getName(chest)] = {name=peripheral.getName(chest):sub(11),Items=nil}
        os.queueEvent("Nuevo Cofre encontrado")
        return false
    else
        if not (next(chest.list()) == nil and Data[peripheral.getName(chest)]["Items"] == nil) then
            os.queueEvent("Change chest")
            return false
        else
            if not CheckItems(chest.list(), Data[peripheral.getName(chest)]["Items"]) then
                os.queueEvent("Change chest")
                return false
            end
        end
    end
    return true
end

-- Sincroniza los datos del cofre con Data
local function SynData(Data, chest)
    for slot, item in pairs(ChestItem) do
        Data[peripheral.getName(chest)]["Items"] = 
    end
end


--Main
-- List perifericos chest
for v,k in pairs(chects) do
    print(v..". "..peripheral.getName(k))
end

local Data = ReadUserjson(DataFile)
for _n,chest in pairs(chects) do
    if not CheckSynData(Data, chest) then
        SynData(Data, chest)
end

--send event os.queueEvent()