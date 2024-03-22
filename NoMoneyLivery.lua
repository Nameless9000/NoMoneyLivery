util.require_natives("3095a")

local VMT_LIVERY_MOD = 48

local update_delay = 100 -- ms

local livery_ids = { -- [vehicle_name] = livery_id;
	39; -- money livery
	--["raiju"] = 11; -- raiju livery
}

local no_max_vehicle_livery = false
local new_livery_id = -1

local function update()
	local vehicle = entities.get_user_vehicle_as_handle()
	if vehicle == INVALID_GUID then
		return
	end
	
	local livery_id = entities.get_upgrade_value(vehicle, VMT_LIVERY_MOD)
	
	local found = livery_ids:contains(livery_id)
	if not found then
		return
	end
	
	if no_max_vehicle_livery then
		local max_livery_id = entities.get_upgrade_max_value(vehicle, VMT_LIVERY_MOD)
	
		if livery_id == max_livery_id then
			entities.set_upgrade_value(vehicle, VMT_LIVERY_MOD, new_livery_id)
		end
		
		return
	end

	-- vehicle check
	if found and string.isalpha(found) and not VEHICLE.IS_VEHICLE_MODEL(vehicle, util.joaat(found)) then 
		return
	end
	
	entities.set_upgrade_value(vehicle, VMT_LIVERY_MOD, new_livery_id)
end

local function update_loop()
	while true do
		update()
		util.yield(update_delay)
	end
end

util.create_thread(update_loop)
