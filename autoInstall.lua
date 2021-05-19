local shell = require("shell")

-- Download Files
local header = "https://raw.githubusercontent.com/CapdinCrando/SiberiaAccountSystem/master/"
files = {"accountApi.lua", "tableToFile.lua", "accountServer.lua"}
for f in files do
	shell.execute("wget " .. header .. f)
end

-- Import Table API
local ttf=require("tableToFile")

-- Generate account data table
local accountData = {}
accountData["test"] = 0
ttf.save(data,"accountData")

-- Generate server data table
local component = require("component")
local serverData = {}
serverData["address"] = component.modem.address
serverData["port"] = 123 -- Change this before deploying!
local file = assert(io.open("serverData", "w"))
file:write()
file:close()

-- Start server
shell.execute("accountServer")