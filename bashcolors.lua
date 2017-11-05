-- Coded by Alireza @ImAWitchBurnMe
-- @ExtraTM rules
local Colors = {}

local vcolors = {
	-- Set
	['bold'] = 1, ['bright'] = 1,
	['dim'] = 2,
	['underline'] = 4,
	['blink'] = 5,
	['reverse'] = 7,
	['hidden'] = 8,
	-- Reset
	['r'] = 0, ['reset'] = 0,
	['rbold'] = 21,
	['rbright'] = 21,
	['rdim'] = 22,
	['runderline'] = 24,
	['rblink'] = 25,
	['rreverse'] = 27,
	['rhidden'] = 28,
	--  Foreground (text)
	['fgdefault'] = 39,
	['fgblack'] = 30,
	['fgred'] = 31,
	['fggreen'] = 32,
	['fgyellow'] = 33,
	['fgblue'] = 34,
	['fgmagneta'] = 35,
	['fgcyan'] = 36, 
	['fglightgray'] = 37, ['fglgray'] = 37,
	['fgdarkgray'] = 90, ['fgdgray'] = 90,
	['fglightred'] = 91, ['fglred'] = 91,
	['fglightgreen'] = 92, ['fglgreen'] = 92,
	['fglightyellow'] = 93, ['fglyellow'] = 93,
	['fglightblue'] = 94, ['fglblue'] = 94,
	['fglightmagneta'] = 95, ['fglmagneta'] = 95,
	['fglightcyan'] = 96, ['fglcyan'] = 96,
	['fgwhite'] = 97,
	-- Backgrounds
	['bgdefault'] = 49,
	['bgblack'] = 40,
	['bgred'] = 41,
	['bggreen'] = 42,
	['bgyellow'] = 43,
	['bgblue'] = 44,
	['bgmagneta'] = 45,
	['bgcyan'] = 46,
	['bglightgray'] = 47, ['bglgray'] = 47,
	['bgdarkgray'] = 100, ['bgdgray'] = 100,
	['bglightred'] = 101, ['bglred'] = 101,
	['bglightgreen'] = 102, ['bglgreen'] = 102,
	['bglightyellow'] = 103, ['bglyellow'] = 103,
	['bglightlbue'] = 104, ['bglblue'] = 104,
	['bglightmagneta'] = 105, ['bglmagneta'] = 105,
	['bglightcyan'] = 106, ['bglcyan'] = 106,
	['bgwhite'] = 107,
}
local sets = {[1] = true, [2] = true, [4] = true, [5] = true ,[7] = true, [8] = true}
local rs = {[0] = true ,[21] = true ,[22] = true, [24] = true, [25] = true, [27] = true, [28] = true}
local fgs = {[39] = true, [30] = true, [31] = true, [32] = true, [33] = true, [34] = true, [35] = true, [36] = true, [37] = true, [90] = true, [91] = true, [92] = true, [93] = true, [94] = true, [95] = true, [96] = true, [97] = true}
local bgs = {[49] = true, [40] = true, [41] = true, [42] = true, [43] = true, [44] = true, [45] = true, [47] = true, [100] = true, [101] = true, [102] = true, [103] = true, [104] = true, [105] = true, [106] = true, [107] = true}
local escape = string.char(27)
local reset = escape .. '[0m'

function Colors.colors (...)
	local set
	local fg
	local bg
	local r
	local args = table.pack(...)
	if not args[1] then return reset end
	for i=1,4 do
		if args[i] then
			local p = args[i]
			if tostring(p) then
				local t = tostring(p):lower()
				if vcolors[t] then
					p = vcolors[t]
				else
					local matches = {t:match("s([bf])(%d+)")}
					if matches then
						local t1 = tonumber(matches[2])
						if t1 >= 0 and t1 < 256 then
							if matches[1] == 'b' then bg = '48;5;' .. t1
							else fg = '38;5;' .. t1
							end
						end
						p = nil
					end
				end
			end
			if p and tonumber(p) then
				local t = tonumber(p)
				if sets[t] then set = t
				elseif rs[t] then r = t
				elseif fgs[t] then fg = t
				elseif bgs[t] then bg = t
				end
			end
		end
	end
	if not (bg or fg or r or set) then return reset end
	local res = ''
	if set then res = res .. set end
	if fg then
		if res:len() ~= 0 then res = res .. ';' end
		res = res .. fg
	end
	if bg then
		if res:len() ~= 0 then res = res .. ';' end
		res = res .. bg
	end
	if r then
		if res:len() ~= 0 then res = res .. ';' end
		res = res .. r
	end
	res = escape .. '[' .. res .. 'm'
	return res
end

local unpack = unpack or table.unpack

function Colors.parse (input) -- Doesn't work now, needs rework, better coding semantics
	local matches = {}
	while (true) do
		local matched = input:match('(%%{.-})')
		if not matched then break end
		matches:insert(matched)
		input:gsub(matched, '{' + #matches + '}', 1)
	end
	print(#matches)
	--input = input:gsub('%%', '')
	local i = 1
	for k,v in pairs(matches) do
		v = v:gsub('%%{', '{')
		print(v)
		local matches1 = {v:match('(%w+);?(%w*);?(%w*);?(%w*)')}
		if matches1 then
			for k,v in pairs(matches1) do
				if v == '' then matches1[k] = nil end
			end
			local t = colors(unpack(matches1))
			input = input:gsub(v, t)
		end
	end
	return input
end
--Colors.__index = Colors
return Colors