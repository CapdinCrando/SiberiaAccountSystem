-- Imports
local shell = require("shell")
local serialization = require("serialization")

local programName = "accountServer"

-- Change PWD
shell.setWorkingDirectory("/" .. programName .. "/")

-- Download file list
local header = "https://raw.githubusercontent.com/CapdinCrando/"
shell.execute("wget -f " .. header .. "SiberiaAccountSystem/master/downloadList.txt")

-- Download Files
local tableFile = assert(io.open("/" .. programName .. "/downloadList.txt"))
local files = serialization.unserialize(tableFile:read("*all"))
for k,v in pairs(files) do
	for _,f in ipairs(v) do
		shell.execute("wget -f " .. header .. k .. "/master/" .. f)
	end
end

-- Start server
shell.execute(programName)