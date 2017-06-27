--[[
~ Some Unicode notes ~

Byte-order marks:
https://en.wikipedia.org/wiki/Byte_order_mark#Byte_order_marks_by_encoding
The BOM for UTF-8 is '\239\187\191'
The BOM for UTF-16 LE is '\255\254'

Unicode in Rainmeter:
https://docs.rainmeter.net/tips/unicode-in-rainmeter/

A cursory read of the Rainmeter docs originally led me to believe that
all files (ini, lua, and txt) must be encoded in UTF-16 LE, but there
is actually a separate section on reading and writing Unicode files in Lua!
(It's at the end)

Takeaways:
1. The script file should be in UTF-16 LE
2. The file being read/written to should be UTF-8
3. Since the first character set of UTF-8 is identical to ANSI, always
   write a UTF-8 byte-order mark so that the file is unambiguously UTF-8

--]]
path, contents = nil, ""

function Initialize()
	path = SKIN:MakePathAbsolute(SKIN:GetVariable('notesfile', SKIN:ReplaceVariables('#@#notes.txt')))
	readFromFile()
end

function Update()
	return contents
end

function writeToFile()
	local text = SELF:GetOption('temp')
	local file = io.open(path, 'w')
	assert(file, 'could not write to ' .. path)
	file:write('\239\187\191', text)
	file:close()
end

function readFromFile()
	local file = io.open(path, 'r')
	assert(file, 'could not read from ' .. path)
	contents = file:read('*a')
	file:close()
end
