local ttf = require("tableToFile")

local accountApi = {}

local accountFile = "accountData"
local data = {}

function accountApi:setup()
  data = ttf.load(accountFile)
end

function accountApi:createAccount(name)
  if data[name] == nil then
    data[name] = 0
  end
  ttf.save(data, accountFile)
end

function accountApi:getAmount(name)
  return data[name]
end

function accountApi:transfer(sender, reciever, amount)
  if sender == nil then
    if reciever == nil then
      return false
    end
  elseif data[sender] == nil then
    return false
  elseif data[sender] >= amount then
    data[sender] = data[sender] - amount
  end
  data[reciever] = data[reciever] + amount
  ttf.save(data, accountFile)
  return true
end

return accountApi