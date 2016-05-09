for p = 0, 35 do
	local psuffix = p == 7 and "" or p

	local dust = "technic:uranium"..psuffix.."_dust"
	minetest.override_item(dust, {
		inventory_image = "tech_add_uranium_dust.png^[colorize:green:" .. p*7 ,
	});

	local ingot = "technic:uranium"..psuffix.."_ingot"
	minetest.override_item(ingot, {
		inventory_image = "tech_add_uranium_ingot.png^[colorize:green:" .. p*7 ,
	});

	local block = "technic:uranium"..psuffix.."_block"
	minetest.override_item(block, {
		tiles = {"tech_add_uranium_block.png^[colorize:green:" .. p*7 ,},
	});

end



