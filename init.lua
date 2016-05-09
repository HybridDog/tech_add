-- Global namespace
tech_add = {}
tech_add.path = minetest.get_modpath("tech_add")

-- Load files
dofile(tech_add.path .. "/mesesignalLV.lua")
dofile(tech_add.path .. "/mesesignalMV.lua")
dofile(tech_add.path .. "/mesesignalHV.lua")
dofile(tech_add.path .. "/recipe_add.lua")

dofile(tech_add.path .. "/batterychecker.lua")
dofile(tech_add.path .. "/batterychecker100k.lua")
dofile(tech_add.path .. "/batterychecker500k.lua")

dofile(tech_add.path .. "/override.lua")
