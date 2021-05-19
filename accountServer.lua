local accounts = require("accountApi")
local event = require("event")
local ttf = require("tableToFile")
local component = require("component")
local modem = component.modem

local p = ttf.load("serverData")["port"]

local function handleMessage(_, _, from, port, _, type, sender, receiver, amount)
	if port ~= p then
		return
	end

	if type = "createAccount" then
		modem.send(from, p, accounts:createAccount(sender))
	if type == "transfer" then
		modem.send(from, p, accounts:transfer(sender, receiver, amount))
	elseif type == "getAmount" then
		modem.send(from, p, accounts:getAmount(sender))
	end
  
end

accounts.loadFile()
modem.open(p)
event.listen("modem_message", handleMessage)