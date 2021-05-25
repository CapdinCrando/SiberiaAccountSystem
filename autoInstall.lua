local shell = require("shell")

local programName = "accountServer"

-- Create directory
shell.execute("mkdir /".. programName)

-- Download autoStart script
shell.execute("wget https://raw.githubusercontent.com/CapdinCrando/SiberiaAccountSystem/master/autoStart.lua /" .. programName .. "/autoStart.lua")

-- Generate account data table
local accountData = {}
accountData["test"] = 0
ttf.save(accountData,"accountData")

-- Generate vendor data table
local vendorData = {}
vendorData["test"] = 0
ttf.save(vendorData,"vendorData")

-- Generate server data table
local component = require("component")
local serverData = {}
serverData["address"] = component.modem.address
serverData["port"] = 123 -- Change this before deploying!
ttf.save(serverData,"serverData")

-- Write to .shrc (for startup)
local startFile = assert(io.open("/home/.shrc", "a"))
startFile:write("\n/" .. programName .. "/autoStart.lua\n")
startFile:close()