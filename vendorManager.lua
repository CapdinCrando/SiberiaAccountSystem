local ttf = require("tableToFile")

local vendorManager = {}

local vendorFile = "vendorData"
local data = {}

vendorLock = 0

local function mutex_lock()
	while vendorLock == 1 do	
		os.sleep(1)
	end
	vendorLock = 1
end

local function mutex_unlock()
	vendorLock = 0
end

function vendorManager:loadFile()
	mutex_lock()
	data = ttf.load(vendorFile)
	mutex_unlock()
end

function vendorManager:isVendor(id)
	if id == nil then
		return false
	end

	mutex_lock()
	local returnValue = false
	for _, v in ipairs(data) do
        if v == id then
            return true
        end
    end
	mutex_unlock()
	return returnValue
end

function vendorManager:addVendor(id)
	mutex_lock()
	if data[id] == nil then
		table.insert(data, id)
		ttf.save(data, vendorFile)
	end
	mutex_unlock()
end

return vendorManager