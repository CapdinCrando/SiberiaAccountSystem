local ttf = require("tableToFile")
local component = require("component")
local event = require("event")
local modem = component.modem

local accountApi = {}

local serverFile = "serverData"
local data = {}
local address = 0
local port = 0

local function getModemMessage()
	local _, _, from, _, _, message = event.pull("modem_message")
	if from == address then
		return message
	end
end

function accountApi:loadFile()
	data = ttf.load(serverFile)
	address = data["address"]
	port = data["port"]
	modem.open(port)
end

function accountApi:doesAccountExist(name)
	modem.send(address, port, "doesAccountExist", name)
	return getModemMessage()
end

function accountApi:createAccount(name)
	modem.send(address, port, "createAccount", name)
	return getModemMessage()
end

function accountApi:getAmount(name)
	modem.send(address, port, "getAmount", name)
	return getModemMessage()
end

function accountApi:transfer(sender, receiver, amount)
	modem.send(address, port, "transfer", sender, receiver, amount)
	return getModemMessage()
end

return accountApi