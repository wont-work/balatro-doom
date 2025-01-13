local doomlove = SMODS.load_file("doomlove.lua")()
print("doom love loaded", tprint(doomlove))

local og_create_UIBox_options = create_UIBox_options
function create_UIBox_options()
    local ret = og_create_UIBox_options()
    local buttons = ret.nodes[1].nodes[1].nodes[1].nodes
    buttons[#buttons+1] = UIBox_button({ label = { "this balatro boring ah hell" }, button = "doom_run", minw = 5 })
    return ret
end

function G.FUNCS.doom_run()
    doomlove.init("doom1.wad")
    doomlove.hijack()
end