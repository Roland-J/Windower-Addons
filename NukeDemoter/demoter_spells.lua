local res = require('resources')
local demoter_arrays = require('demotion_arrays')

-- PURPOSE: Build a custom library for demoter_spells ONCE, on addon load, to reduce system
-- resource usage during the demotion act by eliminating the need for resource looping.
-- EX:	['162'] = {
--			['id'] = '162',
--			['english'] = 'Stone IV',
--			['demotion_array'] = {{english: 'Stone', id: 14}, {english: 'Stone II', id: 15}, etc},
--			['demotion_index'] = 4,
--		},

-- First, perform the one and only res loop to build a temporary cross reference, to avoid the need for future loops
local temp_spell_ids_by_name = {}
for id, spell in pairs(res.spells) do
	temp_spell_ids_by_name[spell.en] = id
end


-- Next, temporarily supplement the demoter_arrays with spell ids & then drop the temporary table
local temp_kind_arrays_with_ids = {}
for demotion_family, array in pairs(demoter_arrays) do
	temp_kind_arrays_with_ids[demotion_family] = {}
	for i, spell_english in pairs(array) do
		temp_kind_arrays_with_ids[demotion_family][i] = {
			['english'] = spell_english,
			['id'] = temp_spell_ids_by_name[spell_english],
		}
	end
end
temp_spell_ids_by_name = nil --no longer needed

-- Lastly, build the final demoter spell library & then drop the 2nd temp table
local demoter_spells = {}
for demotion_family, demotion_array in pairs(temp_kind_arrays_with_ids) do
	--windower.add_to_chat(8, 'Processing the "' .. demotion_family .. '" kind...')
	for demotion_index, spell in pairs(demotion_array) do
		-- Give User Error if Spell Misnamed
		if spell.id == nil then
			windower.add_to_chat(8, 'ERROR: The ' .. demotion_family .. ' list\'s "' .. spell.english .. '" entry was not found in windower\\res\\spells.lua. Please check your spelling.')
		else
			demoter_spells[spell.id] = {
				['id'] = spell.id,
				['english'] = spell.english,
				['demotion_array'] = demotion_array,
				['demotion_index'] = demotion_index
			}
		end
	end
end
temp_kind_arrays_with_ids = nil --no longer needed

return demoter_spells