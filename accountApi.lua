local ttf = require("tableToFile")
local component = require("component")
local modem = component.modem

local accountApi = {}

local serverFile = "serverData"
local data = {}
local address = 0
local port = 0

function accountApi:loadFile()
	data = ttf.load(serverFile)
	address = data["address"]
	port = data["port"]
end

function accountApi:createAccount(name)
	return modem.send(address, port, "createAccount", name)
end

function accountApi:getAmount(name)
	return modem.send(address, port, "getAmount", name)
end

function accountApi:transfer(sender, receiver, amount)
	return modem.send(address, port, "transfer", sender, receiver, amount)
end

return accountApi