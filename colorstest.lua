c = require 'bashcolors'
local escape = string.char(27)
colors = c.colors
write = io.write
write(colors('bgRed', 'fgblue') .. ' E ')
write(colors('bgGreen', 'fglgray') .. ' x ')
write(colors('bgyellow', 'fgblack') .. ' t ')
write(colors('bgblue', 'fglred', 'underline') .. ' r' )
write(colors('bgwhite', 'fgcyan', 'bold', 'runderline') .. ' a ')
write(colors('bgmagneta', 'fgwhite') .. ' T ')
write(colors('bglightred', 'fgblack') .. ' M ')
write(colors() .. '\n\n')

local extra = {'-', '_', '_', '-', '@', 'E', 'x', 't', 'r', 'a', 'T', 'M','-', '_', '_', '-',}
for i=0,15 do
	for j=0,15 do
		local color = i * 16 + j
		write(colors('sb'.. color, 'sf' .. (255 - color)) .. ' ' .. extra[j+1] .. ' ')
	end
	write(colors(), '\n')
end
write('\n')