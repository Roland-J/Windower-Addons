_addon.author = 'RolandJ'
_addon.version = '1.0.1'
_addon.commands = {'engage'}

-- PURPOSE: To allow the player to specifically engage/disengage, rather than just a toggle (/attack)


-------------------------------------------------------------------------------------------------------------------
-- Local variables used throughout addon
-------------------------------------------------------------------------------------------------------------------

require('tables')
local packets = require('packets')
local engaging = false
local disengaging = false
local attempts = 0
local attemptsMax = 10
local attemptDelay = 1
local debugMode = false
local red = 123
local green = 215
local purple = 200



-------------------------------------------------------------------------------------------------------------------
-- Function for pushing addon messages to chat
-------------------------------------------------------------------------------------------------------------------

local function logger(color, message, isCommand)
	if debugMode or isCommand then
		windower.add_to_chat(color, '[Engage] ' .. message)
	end
end



-------------------------------------------------------------------------------------------------------------------
-- Check current status and engage/disengage if applicable
-------------------------------------------------------------------------------------------------------------------

local function engage_target()
	-- Return out if there is no target
	local target = windower.ffxi.get_mob_by_target()
	if target == nil  then
		return logger(red, 'No target, cancelling...')
	end
	
	-- Try to engage
	engaging = true
	disengaging = false
	attempts = 0
	while engaging do
		-- Get/Update Player Status
		local player = windower.ffxi.get_player()
		local playerIsEngaged = player and player.status == 1 or false
		
		-- Return out if already engaged (/attack won't do this!)
		if playerIsEngaged then
			engaging = false
			if attempts == 0 then
				return logger(purple, 'Player is already engaged...')
			else
				return logger(purple, 'Player engaged on attempt ' .. attempts .. ' of ' .. attemptsMax .. '...')
			end
		else
			if attempts < attemptsMax then
				attempts = attempts + 1
				logger(purple, 'Attempting to engage "' .. target.name .. '"... (attempt ' .. attempts .. ' / ' .. attemptsMax .. ')')
				windower.send_command('input /attack')
				coroutine.sleep(attemptDelay)
			else
				engaging = false
				return logger(red, 'Failed to engage after ' .. attempts .. ' attempts.')
			end
		end
	end
end

function disengage()
	disengaging = true
	engaging = false
	attempts = 0
	while disengaging do
		local player = windower.ffxi.get_player()
		local playerIsEngaged = player and player.status == 1 or false
		
		if not playerIsEngaged then
			disengaging = false
			if attempts == 0 then
				return logger(purple, 'Player is already disengaged...')
			else
				return logger(purple, 'Player disengaged on attempt ' .. attempts .. ' of ' .. attemptsMax .. '...')
			end
		else
			if attempts < attemptsMax then
				attempts = attempts + 1
				logger(purple, 'Attempting to disengage... (attempt ' .. attempts .. ' / ' .. attemptsMax .. ')')
				windower.send_command('input /attack')
				coroutine.sleep(attemptDelay)
			else
				disengaging = false
				return logger(red, 'Failed to disengage after ' .. attempts .. ' attempts.')
			end
		end
	end
end



-------------------------------------------------------------------------------------------------------------------
-- Processing for addon commands (type "//engage" ingame)
-------------------------------------------------------------------------------------------------------------------

-- Handler for addon's dual command "//disengage"
windower.register_event('unhandled command', function(source, ...)
	if source == 'disengage' then
		local cmd = T{...}
		if cmd[1] == nil or cmd[1]:lower() == 'send' or cmd[1]:lower() == 's' then
			if cmd[1] == nil then
				--Local command
				windower.send_command('engage off') -- Handing this off to the official handler
			else
				--Send command
				if cmd[2] == nil then
					return logger(red, 'ABORT: Please specify a sendee...', true)
				end
				logger(purple, 'Sending disengage command to "' .. cmd[2]:lower() .. '"...')
				windower.send_command('send ' .. cmd[2]:lower() .. ' engage off')
			end
		elseif cmd[1]:lower() == 'debug' then
			windower.send_command('engage debug')
		end
	end
end)

-- Handler for addon's official command "//engage"
windower.register_event('addon command', function(...)
	local cmd = T{...}
	
	if cmd[1] == nil or cmd[1]:lower() == 'send' or cmd[1]:lower() == 's' then
		-- This first command handles lazy engage commands "//engage" or "//engage s [recipient]"
		if cmd[1] == nil then
			--Local command
			engage_target()
		else
			--Send command
			if cmd[2] == nil then
				return logger(red, 'ABORT: Please specify a sendee...', true)
			end
			logger(purple, 'Sending engage command to "' .. cmd[2]:lower() .. '"...')
			windower.send_command('send ' .. cmd[2]:lower() .. ' settarget <tid>; wait 0.5; send ' .. cmd[2]:lower() .. ' engage on')
		end
	elseif cmd[1]:lower() == 'off' then
		if cmd[2] == nil then
			disengage()
		else
			local sendee = (table.contains({'all', 'others'}, cmd[2]) and '@' or '') .. cmd[2]
			logger(purple, 'Sending disengage command to "' .. sendee .. '"...')
			windower.send_command('send ' .. sendee .. ' engage off')
		end
	elseif cmd[1]:lower() == 'debug' then
		debugMode = not debugMode
		logger(purple, 'Debug Mode ' .. (debugMode and 'Activated' or 'Deactivated'), true)
	elseif cmd[1]:lower() == 'help' then
        logger(purple, 'Engage  v' .. _addon.version .. ' commands:', true)
        logger(purple, '//engage [commands]', true)
        logger(purple, '    "on"                   - Engages the player to their target.', true)
        logger(purple, '    "on send [recipient]"  - Engages recipient to current player\'s target.', true)
        logger(purple, '    "off"                  - Disengages the player from their target.', true)
        logger(purple, '    "off send [recipient]" - Disengages recipient from their target.', true)
        logger(purple, '    "help"                 - Displays this help text.', true)
        logger(purple, ' ', true)
        logger(purple, ' NOTE: The [recipient] can be "@all", "@others", or an alt\'s name.', true)
        logger(purple, ' SHORTHAND: Try the "//engage", "//engage s [recipient]", "//disengage", and "//disengage s [recipient]" shorthand commands!', true)
	else
		logger(red, 'ABORT: Invalid command, showing list of commands...')
		windower.send_command('engage help')
	end
end)

-- Handle incoming chunks for "You cannot attack that target." messages
windower.register_event('incoming chunk', function(id,data,modified,injected,blocked)
	if id == 0x029 then
		if packets.parse('incoming', data).Message == 446 then
			engaging = false
			return logger(red, 'ABORT: You cannot attack that target...', true)
		end
	end
end)