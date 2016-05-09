minetest.register_node("tech_add:hv_mesesignal", {
	description = "HV Mese Signal",
	tiles = {"tech_add_hv_mese_off.png"},
	infotext = "HV Mese Signal(OFF)",
	groups = {
			snappy=2, choppy=2, oddly_breakable_by_hand=2, 
			technic_machine=1 , mesesignal=1
		},
	active = false,
	paramtype = "light",
	technic_run = function(pos, node)
		local meta         = minetest.get_meta(pos)
		local machine_name = "HV Mese Signal"
		local eu_input     = meta:get_int("HV_EU_input")
		local demand       = 1
		meta:set_int("HV_EU_demand", demand)

		-- Setup meta data if it does not exist.
		if not eu_input then
			meta:set_int("HV_EU_demand", demand)
			meta:set_int("HV_EU_input", 0)
			return
		end

		if eu_input < demand then
			meta:set_string("infotext", machine_name.." Unpowered")
		elseif eu_input >= demand then
			minetest.swap_node(pos, {name="tech_add:hv_mesesignal_on"})
			mesecon.receptor_on(pos)
		end
	end,
	mesecons = {receptor = {
		state = mesecon.state.off,
	}}
})

minetest.register_node("tech_add:hv_mesesignal_on", {
	description = "HV Mese Signal",
	tiles = {"tech_add_hv_mese_on.png"},
	infotext = "HV Mese Signal(ON)",
	groups = {
			snappy=2, choppy=2, oddly_breakable_by_hand=2, 
			technic_machine=1, mesecon = 2 , mesesignal=1
		},
	active = false,
	paramtype = "light",
	drop = "tech_add:hv_mesesignal", 
	technic_run = function(pos, node)
		local meta         = minetest.get_meta(pos)
		local machine_name = "HV Mese Signal"
		local eu_input     = meta:get_int("HV_EU_input")
		local demand       = 1
		meta:set_int("HV_EU_demand", demand)

		-- Setup meta data if it does not exist.
		if not eu_input then
			meta:set_int("HV_EU_demand", demand)
			meta:set_int("HV_EU_input", 1)
			return
		end

		if eu_input < demand then
			minetest.swap_node(pos, {name="tech_add:hv_mesesignal"})
			mesecon.receptor_off(pos)
		elseif eu_input >= demand then
			meta:set_string("infotext", machine_name.." Active")
		end
	end,
	mesecons = {receptor = {
		state = mesecon.state.on,
	}},
})

technic.register_machine("HV", "tech_add:hv_mesesignal", technic.receiver)
technic.register_machine("HV", "tech_add:hv_mesesignal_on", technic.receiver)

minetest.register_craft({
	output = 'tech_add:hv_mesesignal',
	recipe = {
		{'mesecons_torch:mesecon_torch_on',},
		{'technic:machine_casing',},
		{'technic:hv_cable0',},
}})
minetest.register_craft({
	output = 'tech_add:hv_mesesignal',
	recipe = {
		{'group:mesesignal',},
		{'technic:hv_cable0',},
}})
