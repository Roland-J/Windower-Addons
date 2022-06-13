local res = require('resources')

-- Array of spell kinds ordered by potency
-- CREDIT: Array built loosely on Zarianna's GEO.lua's degrade_array
kind_arrays = {
	-- Fire
	['Fire'] = {'Fire', 'Fire II', 'Fire III', 'Fire IV', 'Fire V'},
	['Firaga'] = {'Firaga', 'Firaga II', 'Firaga III'},
	['Fira'] = {'Fira', 'Fira II'},
	['Flare'] = {'Flare', 'Flare II'},
	['FireMixed'] = {'Fire', 'Fire II', 'Fire III', 'Fire IV', 'Fire V', 'Firaja', 'Fire VI'},
	
	-- Ice
	['Blizzard'] = {'Blizzard', 'Blizzard II', 'Blizzard III', 'Blizzard IV', 'Blizzard V'},
	['Blizzaga'] = {'Blizzaga', 'Blizzaga II', 'Blizzaga III'},
	['Blizzara'] = {'Blizzara', 'Blizzara II'},
	['Freeze'] = {'Freeze', 'Freeze II'},
	['BlizzardMixed'] = {'Blizzard', 'Blizzard II', 'Blizzard III', 'Blizzard IV', 'Blizzard V', 'Blizzaja', 'Blizzard VI'},
	
	-- Wind
	['Aero'] = {'Aero', 'Aero II', 'Aero III', 'Aero IV', 'Aero V'},
	['Aeroga'] = {'Aeroga', 'Aeroga II', 'Aeroga III'},
	['Aerora'] = {'Aerora', 'Aerora II'},
	['Tornado'] = {'Tornado', 'Tornado II'},
	['AeroMixed'] = {'Aero', 'Aero II', 'Aero III', 'Aero IV', 'Aero V', 'Aeroja', 'Aero VI'},
	
	-- Earth
	['Stone'] = {'Stone', 'Stone II', 'Stone III', 'Stone IV', 'Stone V'},
	['Stonega'] = {'Stonega', 'Stonega II', 'Stonega III'},
	['Stonera'] = {'Stonera', 'Stonera II'},
	['Quake'] = {'Quake', 'Quake II'},
	['StoneMixed'] = {'Stone', 'Stone II', 'Stone III', 'Stone IV', 'Stone V', 'Stoneja', 'Stone VI'},
	
	-- Lightning
	['Thunder'] = {'Thunder', 'Thunder II', 'Thunder III', 'Thunder IV', 'Thunder V'},
	['Thundaga'] = {'Thundaga', 'Thundaga II', 'Thundaga III'},
	['Thundara'] = {'Thundara', 'Thundara II'},
	['Burst'] = {'Burst', 'Burst II'},
	['ThunderMixed'] = {'Thunder', 'Thunder II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thundaja', 'Thunder VI'},
	
	-- Water
	['Water'] = {'Water', 'Water II', 'Water III', 'Water IV', 'Water V'},
	['Waterga'] = {'Waterga', 'Waterga II', 'Waterga III'},
	['Watera'] = {'Watera', 'Watera II'},
	['Flood'] = {'Flood', 'Flood II'},
	['WaterMixed'] = {'Water', 'Water II', 'Water III', 'Water IV', 'Water V', 'Waterja', 'Water VI'},
	
	-- Dark
	['Aspir'] = {'Aspir', 'Aspir II', 'Aspir III'},
	
	-- Light
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