local ttf = require("tableToFile")

local accountManager = {}

local accountFile = "accountData"
local data = {}

lock = 0

local function mutex_lock()
	while(lock) do
		os.sleep(1)
	end
	lock = 1
end

local function mutex_unlock()
	lock = 0
end

function accountManager:loadFile()
	mutex_lock()
	data = ttf.load(accountFile)
	mutex_unlock()
end

function accountManager:doesAccountExist(name)
	if name == nil then
		return false
	end
	
	local returnValue = false
	mutex_lock()
	returnValue = data[name] ~= nil
	mutex_unlock()
	return returnValue
end

function accountManager:createAccount(name)
	local returnValue = "Account already exists!"
	if name == nil then
		returnValue = "Please supply a name for the account!"
	else 
		mutex_lock()
		if data[name] == nil then
			data[name] = 0
			ttf.save(data, accountFile)
			returnValue = "Account creation successful!"
		end
		mutex_unlock()
	end
	return returnValue
end

function accountManager:getAmount(name)
	local returnValue = "Account does not exist!"
	mutex_lock()
	if data[name] ~= nil then
		returnValue = data[name]
	end
	mutex_unlock()
	return returnValue
end

function accountManager:transfer(sender, receiver, amount)
	mutex_lock()
	if sender == nil then
		if receiver == nil then
			mutex_unlock()
			return "Transfer function: nil input!"
		end
	elseif data[sender] == nil then
		mutex_unlock()
		return "Sender account does not exist!"
	elseif data[sender] >= amount then
		data[sender] = data[sender] - amount
	else
		mutex_unlock()
		return "Insufficient funds!"
	end
	data[receiver] = data[receiver] + amount
	ttf.save(data, accountFile)
	mutex_unlock()
	return "Transaction successful!"
end

return accountManager