local ttf = require("tableToFile")

local accountManager = {}

local accountFile = "accountData"
local data = {}

function accountManager:loadFile()
	data = ttf.load(accountFile)
end

function accountManager:createAccount(name)
	if name == nil then
		return "Please supply a name for the account!"
	elseif data[name] == nil then
		data[name] = 0
		ttf.save(data, accountFile)
		return "Account creation successful!"
	else
		return "Account already exists!"
	end
end

function accountManager:getAmount(name)
	if data[name] == nil then
		return "Account does not exist!"
	else then
		return data[name]
	end
end

function accountManager:transfer(sender, receiver, amount)
	if sender == nil then
		if receiver == nil then
			return "Transfer function: nil input!"
		end
	elseif data[sender] == nil then
		return "Sender account does not exist!"
	elseif data[sender] >= amount then
		data[sender] = data[sender] - amount
	else then
		return "Insufficient funds!"
	end
	data[receiver] = data[receiver] + amount
	ttf.save(data, accountFile)
	return "Transaction successful!"
end

return accountManager