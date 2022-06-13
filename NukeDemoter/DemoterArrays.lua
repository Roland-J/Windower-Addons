local res = require('resources')

-- Array of spell kinds to demote, each ordered by potency
-- NOTE: Don't demote spells, such as protect or an enfeeble, where there'd be a long-lasting detriment to doing so
-- CREDIT: Array built loosely on Zarianna's GEO.lua's degrade_array
kind_arrays = {
	-- Fire
	['Fire'] = {'Fire', 'Fire II', 'Fire III', 'Fire IV', 'Fire V', 'Firaja', 'Fire VI'}, --the -aja gets filtered out
	['Firaga'] = {'Firaga', 'Firaga II', 'Firaga III'},
	['Fira'] = {'Fira', 'Fira II'},
	['Flare'] = {'Flare', 'Flare II'},
	
	-- Ice
	['Blizzard'] = {'Blizzard', 'Blizzard II', 'Blizzard III', 'Blizzard IV', 'Blizzard V', 'Blizzaja', 'Blizzard VI'}, --the -aja gets filtered out
	['Blizzaga'] = {'Blizzaga', 'Blizzaga II', 'Blizzaga III'},
	['Blizzara'] = {'Blizzara', 'Blizzara II'},
	['Freeze'] = {'Freeze', 'Freeze II'},
	
	-- Wind
	['Aero'] = {'Aero', 'Aero II', 'Aero III', 'Aero IV', 'Aero V', 'Aeroja', 'Aero VI'}, --the -aja gets filtered out
	['Aeroga'] = {'Aeroga', 'Aeroga II', 'Aeroga III'},
	['Aerora'] = {'Aerora', 'Aerora II'},
	['Tornado'] = {'Tornado', 'Tornado II'},
	
	-- Earth
	['Stone'] = {'Stone', 'Stone II', 'Stone III', 'Stone IV', 'Stone V', 'Stoneja', 'Stone VI'}, --the -aja gets filtered out
	['Stonega'] = {'Stonega', 'Stonega II', 'Stonega III'},
	['Stonera'] = {'Stonera', 'Stonera II'},
	['Quake'] = {'Quake', 'Quake II'},
	
	-- Lightning
	['Thunder'] = {'Thunder', 'Thunder II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thundaja', 'Thunder VI'}, --the -aja gets filtered out
	['Thundaga'] = {'Thundaga', 'Thundaga II', 'Thundaga III'},
	['Thundara'] = {'Thundara', 'Thundara II'},
	['Burst'] = {'Burst', 'Burst II'},
	
	-- Water
	['Water'] = {'Water', 'Water II', 'Water III', 'Water IV', 'Water V', 'Waterja', 'Water VI'}, --the -aja gets filtered out
	['Waterga'] = {'Waterga', 'Waterga II', 'Waterga III'},
	['Watera'] = {'Watera', 'Watera II'},
	['Flood'] = {'Flood', 'Flood II'},
	
	-- Dark
	['Aspir'] = {'Aspir', 'Aspir II', 'Aspir III'},
	['Drain'] = {'Drain', 'Drain II', 'Drain III'},
	
	-- Light
	['Banish'] = {'Banish', 'Banish II', 'Banish III', 'Banish IV'},
	['Cure'] = {'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Cure V', 'Cure VI'}, --why not?
	['Curaga'] = {'Curaga', 'Curaga II', 'Curaga III', 'Curaga IV', 'Curaga VI'}, --why not?
}

-- A name-to-ID cross-reference array built to avoid repeated resource referencing during demotion process
local spell_ids_by_name = {}
for id, spell in ipairs(res.spells) do
	local kind = spell.en:split(' ')[1]
	-- Only process the above listed kinds
	if kind_arrays[kind] ~= nil then
		local result = table.find(kind_arrays[kind], spell.english)
		-- Only process the spells in the given kind
		if result ~= nil then
			spell_ids_by_name[spell.english] = id
		end
	end
end

-- Return these arrays to the main module
return {
	['kind_arrays'] = kind_arrays,
	['spell_ids_by_name'] = spell_ids_by_name,
}