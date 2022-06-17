-- README: Users, edit these arrays if you want to modify the demotion order
-- DESCRIPTION: The arrays of spell kinds to demote, each having spells ordered by potency
-- TIP: Don't demote spells, such as protect or an enfeeble, where there'd be a long-lasting detriment to doing so
-- CREDIT: Array built loosely on Zarianna's GEO.lua's degrade_array
return {
	-- Earth
	['Stone'] = {'Stone', 'Stone II', 'Stone III', 'Stone IV', 'Stone V', 'Stoneja', 'Stone VI'}, --the -aja gets filtered out
	['Stonega'] = {'Stonega', 'Stonega II', 'Stonega III'},
	['Stonera'] = {'Stonera', 'Stonera II'},
	['Quake'] = {'Quake', 'Quake II'},
	
	-- Wind
	['Aero'] = {'Aero', 'Aero II', 'Aero III', 'Aero IV', 'Aero V', 'Aeroja', 'Aero VI'}, --the -aja gets filtered out
	['Aeroga'] = {'Aeroga', 'Aeroga II', 'Aeroga III'},
	['Aera'] = {'Aera', 'Aera II'},
	['Tornado'] = {'Tornado', 'Tornado II'},
	
	-- Water
	['Water'] = {'Water', 'Water II', 'Water III', 'Water IV', 'Water V', 'Waterja', 'Water VI'}, --the -aja gets filtered out
	['Waterga'] = {'Waterga', 'Waterga II', 'Waterga III'},
	['Watera'] = {'Watera', 'Watera II'},
	['Flood'] = {'Flood', 'Flood II'},
	
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
	
	-- Lightning
	['Thunder'] = {'Thunder', 'Thunder II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thundaja', 'Thunder VI'}, --the -aja gets filtered out
	['Thundaga'] = {'Thundaga', 'Thundaga II', 'Thundaga III'},
	['Thundara'] = {'Thundara', 'Thundara II'},
	['Burst'] = {'Burst', 'Burst II'},
	
	-- Dark
	['Aspir'] = {'Aspir', 'Aspir II', 'Aspir III'},
	['Drain'] = {'Drain', 'Drain II', 'Drain III'},
	
	-- Light
	['Banish'] = {'Banish', 'Banish II', 'Banish III', 'Banish IV'},
	['Cure'] = {'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Cure V', 'Cure VI'}, --why not?
	['Curaga'] = {'Curaga', 'Curaga II', 'Curaga III', 'Curaga IV', 'Curaga V'}, --why not?
}