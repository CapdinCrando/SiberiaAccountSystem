local shell = require("shell")
local args, ops = shell.parse(...)
local event = require("event")
event.push("addVendor", args[1])