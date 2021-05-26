local shell = require("shell")
local computer = require("computer")
local process = require("process")

local programName = "accountServer"

-- Create directory
shell.execute("mkdir /".. programName)

-- Download autoStart script
shell.execute("wget https://raw.githubusercontent.com/CapdinCrando/SiberiaAccountSystem/master/autoStart.lua /" .. programName .. "/autoStart.lua")

-- Download tableToFile API
shell.execute("wget https://raw.githubusercontent.com/CapdinCrando/SiberiaAccountSystem/master/tableToFile.lua tableToFile.lua")
local ttf = require("tableToFile")

-- Generate account data table
local accountData = {}
accountData["test"] = 0
ttf.save(accountData, "/" .. programName .. "/accountData")

-- Generate vendor data table
local vendorData = {}
vendorData["test"] = 0
ttf.save(vendorData, "/" .. programName .. "/vendorData")

-- Generate server data table
local component = require("component")
local serverData = {}
serverData["address"] = component.modem.address
serverData["port"] = 123 -- Change this before deploying!
ttf.save(serverData, "/" .. programName .. "/serverData")

-- Copy server data to floppy
shell.execute("cp /".. programName .. "/serverData /data/serverData")

-- Write to .shrc (for startup)
local startFile = assert(io.open("/home/.shrc", "a"))
startFile:write("\n/" .. programName .. "/autoStart.lua\n")
startFile:close()

-- Restart computer
computer.shutdown(true)