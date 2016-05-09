
minetest.register_node("tech_add:battery_torch500k_on", {
	description="Battery Check Torch(500k)",
	drawtype = "torchlike",
	tiles = {"tech_add_battery_torch500k_on.png", "tech_add_battery_torch500k_on.png^[transformFY", "tech_add_battery_torch500k_on_side.png"},
	inventory_image = "tech_add_battery_torch500k_on.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	paramtype2 = "wallmounted",
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.1, -0.1, -0.5+0.6, 0.1, 0.1},
	},
	groups = {dig_immediate=3 , attached_node=1 , mesecon = 2 , threshold = 100000 , not_in_creative_inventory=1},
	light_source = default.LIGHT_MAX - 1,
	drop = "tech_add:battery_torch500k_off",
	mesecons = {receptor = {
		state = mesecon.state.on,
	}},
})

minetest.register_node("tech_add:battery_torch500k_off", {
	description="Battery Check Torch(500k)",
	drawtype = "torchlike",
	tiles = {"tech_add_battery_torch500k_off.png", "tech_add_battery_torch500k_off.png^[transformFY", "tech_add_battery_torch500k_off_side.png"},
	inventory_image = "tech_add_battery_torch500k_off.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	paramtype2 = "wallmounted",
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.4, -0.1, -0.5+0.6, 0.4, 0.1},
	},
	groups = {dig_immediate=3 , attached_node=1 , threshold = 500000},
	drop = "tech_add:battery_torch500k_off",
	mesecons = {receptor = {
		state = mesecon.state.off,
	}},
})

minetest.register_abm({
	nodenames = {"tech_add:battery_torch500k_on","tech_add:battery_torch500k_off"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local basepos = pos
		local param2 = node.param2
		if param2 == 0 then
			basepos = { x=pos.x, y=pos.y+1 , z=pos.z }
		elseif param2 == 1 then
			basepos = { x=pos.x, y=pos.y-1 , z=pos.z }
		elseif param2 == 2 then
			basepos = { x=pos.x+1, y=pos.y , z=pos.z }
		elseif param2 == 3 then
			basepos = { x=pos.x-1, y=pos.y , z=pos.z }
		elseif param2 == 4 then
			basepos = { x=pos.x, y=pos.y , z=pos.z+1 }
		elseif param2 == 5 then
			basepos = { x=pos.x, y=pos.y , z=pos.z-1 }
		end

		local max_charge = 0
		local battery_check = false
		
		local meta = minetest.get_meta(basepos)
		local current_charge = meta:get_int("internal_EU_charge")
		if current_charge == nil then
			current_charge = 0
		end
		-- TODO How to get max_charge?
--		local max_charge = meta:get_int("max_charge")
--		local threshold = node.threshold
		local threshold = 500000

		--Battery Check
		if current_charge >= threshold then
			battery_check = true
		end
		
		--[[Debug
		local infotext = "charge/max : " ..  current_charge .. "/" .. max_charge
		local thismeta = minetest.get_meta(pos)
		thismeta:set_string("infotext", infotext)
		--]]
		--Debug End

		if battery_check == true and node.name == "tech_add:battery_torch500k_off" then
			minetest.swap_node(pos, {name = "tech_add:battery_torch500k_on", param2 = node.param2})
			mesecon.receptor_on(pos)
		elseif battery_check == false and node.name == "tech_add:battery_torch500k_on" then
			minetest.swap_node(pos, {name = "tech_add:battery_torch500k_off", param2 = node.param2})
			mesecon.receptor_off(pos)
		end
	end
})

minetest.register_craft({
	output = "tech_add:battery_torch500k_off 4",
	recipe = {
		{"technic:fine_gold_wire","group:mesecon_conductor_craftable","technic:wrought_iron_ingot"},
		{"","default:stick",""},
}})
minetest.register_craft({
	output = "tech_add:battery_torch500k_off 4",
	recipe = {
		{"technic:wrought_iron_ingot","group:mesecon_conductor_craftable","technic:fine_gold_wire"},
		{"","default:stick",""},
}})
