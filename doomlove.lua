local _M = {}

local path = SMODS.current_mod.path
package.cpath = package.cpath .. ';' .. path .. '?.dll'
local doom = require "doom"
print("doom binary loaded", tprint(doom))

local sx, sy = 1, 1
local doomW = doom.get_width()
local doomH = doom.get_height()

local canvas = love.image.newImageData(doomW, doomH, "rgba8")
local image = love.graphics.newImage(canvas)
image:setFilter("nearest", "nearest")

local function draw()
    if not doom.get_want_redraw() then return end

    for px = 0, doomW - 1 do
        for py = 0, doomH - 1 do
            local r, g, b = doom.get_pixel_at(px, py)
            canvas:setPixel(px, py, r, g, b, 1)
        end
    end

    image:replacePixels(canvas)
    love.graphics.push()
        love.graphics.scale(sx, sy)
        love.graphics.draw(image, 0, 0)
    love.graphics.pop()
end

local function update(dt)
    doom.tick()
end

local function keypressed(key, scancode, isrepeat)
    doom.press_key(key)
end

local function keyreleased(key)
    doom.release_key(key)
end

local function resize(winW, winH)
    sx = winW / doomW
    sy = winH / doomH
end

function _M.init(wad)
    doom.start(path .. wad)
end

function _M.hijack()
    local winW, winH = love.window.getMode()
    resize(winW, winH)

    _M._draw = love.draw
    love.draw = draw

    _M._update = love.update
    love.update = update

    _M._keypressed = love.keypressed
    love.keypressed = keypressed

    _M._keyreleased = love.keyreleased
    love.keyreleased = keyreleased

    _M._resize = love.resize
    love.resize = resize

    doom.on_quit(_M.restore)
end

function _M.restore()
    love.draw = _M._draw
    _M._draw = nil

    love.update = _M._update
    _M._update = nil

    love.keypressed = _M._keypressed
    _M._keypressed = nil

    love.keyreleased = _M._keyreleased
    _M._keyreleased = nil

    love.resize = _M._resize
    _M._resize = nil
end

return _M
