local shell = require("shell")

-- Download Files
local header = "https://raw.githubusercontent.com/CapdinCrando/SiberiaAccountSystem/master/"
files = {"accountManager.lua", "tableToFile.lua", "accountServer.lua"}
for _,f in ipairs(files) do
	shell.execute("wget " .. header .. f)
end

-- Import Table API
local ttf=require("tableToFile")

-- Generate account data table
local accountData = {}
accountData["test"] = 0
ttf.save(accountData,"accountData")

-- Generate server data table
local component = require("component")
local serverData = {}
serverData["address"] = component.modem.address
serverData["port"] = 123 -- Change this before deploying!
ttf.save(serverData,"serverData")

-- Start server
shell.execute("accountServer")