
-- black powder
minetest.register_craft({
	output = "tnt:gunpowder 2",
	type = "shapeless",
	recipe = {"default:coal_lump", "technic:sulfur_lump"}
})

minetest.register_craft({
	output = "tnt:gunpowder 2",
	type = "shapeless",
	recipe = {"technic:coal_dust", "technic:sulfur_dust"}
})

-- Lead Battery(Sulfuric acid + Lead) backet NOT return (used as case))
minetest.register_craft({
	output = 'technic:battery',
	recipe = {
		{'group:wood', 'technic:lead_ingot', 'group:wood'},
		{"technic:sulfur_dust", "bucket:bucket_water", "technic:sulfur_dust"},
		{'group:wood', 'technic:lead_ingot', 'group:wood'},
}})

minetest.register_craft({
	output = 'technic:battery',
	recipe = {
		{'group:wood', 'technic:lead_ingot', 'group:wood'},
		{"technic:sulfur_lump", "bucket:bucket_water", "technic:sulfur_lump"},
		{'group:wood', 'technic:lead_ingot', 'group:wood'},
}})
