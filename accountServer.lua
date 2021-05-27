local accounts = require("accountManager")
local vendors = require("vendorManager")
local event = require("event")
local ttf = require("tableToFile")
local component = require("component")
local thread = require("thread")
local modem = component.modem

local p = ttf.load("serverData")["port"]

local function handleMessage(_, _, from, port, _, type, sender, receiver, amount)
	thread.create(function()
		if port ~= p then
			print("Invalid port")
			return
		end
		
		if not vendors:isVendor(from) then
			modem.send(from, p, "Device is not a registered vendor!")
			print("Invalid vendor!")
			return
		end
	
		if type == "createAccount" then
			print("createAccount")
			modem.send(from, p, accounts:createAccount(sender))
		elseif type == "doesAccountExist" then
			print("checkAccount")
			modem.send(from, p, accounts:doesAccountExist(sender))
		elseif type == "transfer" then
			print("transfer")
			modem.send(from, p, accounts:transfer(sender, receiver, amount))
		elseif type == "getAmount" then
			print("getAmount")
			modem.send(from, p, accounts:getAmount(sender))
		end
	end)
end

local function handleRefresh()
	thread.create(function()
		accounts:loadFile()
		vendors:loadFile()
	end)
end

local function addVendor(address)
	thread.create(function()
		vendors:addVendor(address)
	end)
end

accounts:loadFile()
vendors:loadFile()
modem.open(p)
event.listen("modem_message", handleMessage)
event.listen("refreshData", handleRefresh)
event.listen("addVendor", addVendor)