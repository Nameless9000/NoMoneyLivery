local VMT_LIVERY_MOD = 48

local update_delay = 100 -- ms
local livery_ids = { -- [new_livery_id] = old_livery_id;
	39; -- money livery
	--11; -- raiju livery
}

local default_new_livery_id = -1

local function update()
	local vehicle = entities.get_user_vehicle_as_pointer()
	if vehicle == 0 then
		return
	end
	
	local livery_id = entities.get_upgrade_value(vehicle, VMT_LIVERY_MOD)
	if not (livery_id in livery_ids) then
		return
	end
	
	local new_livery_id = livery_ids:contains(livery_id) ?? default_new_livery_id
	
	entities.set_upgrade_value(vehicle, VMT_LIVERY_MOD, new_livery_id)
end

local function update_loop()
	while true do
		update()
		util.yield(update_delay)
	end
end

util.create_thread(update_loop)