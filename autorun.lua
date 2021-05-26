-- This is meant to be put on the data floppy
local fs = require("filesystem")
local proxy = ...
fs.mount(proxy, "/data")