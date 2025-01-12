local self = SMODS.current_mod
local path = self.path

package.cpath = package.cpath .. ';' .. path .. '/?.dll'
local doom = require "doom"

print("DOOM natives loaded", tprint(doom))

doom.start(path .. '/doom1.wad')
print("DOOM started")

local band = bit.band;
local rshift = bit.rshift;

local x, y = 0, 0;
local doomW = doom.get_width()
local doomH = doom.get_height()
local canvas = love.image.newImageData(doomW, doomH, "rgba8")
local image = love.graphics.newImage(canvas)

function love.draw()
    if not doom.get_want_redraw() then return end

    for px = 0, doomW - 1 do
        for py = 0, doomH - 1 do
            local r, g, b = doom.get_pixel_at(px, py)
            canvas:setPixel(px, py, r, g, b, 1)
        end
    end

    image:replacePixels(canvas)
    love.graphics.draw(image, x, y)
end

function love.update(dt)
    doom.tick()
end

function love.keypressed(key, scancode, isrepeat)
    doom.press_key(key)
end

function love.keyreleased(key)
    doom.release_key(key)
end

function love.resize(winW, winH)
    x = (winW - doomW) / 2
    y = (winH - doomH) / 2
end