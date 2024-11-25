local camera = require 'libraries/camera'
local sti = require 'libraries/sti'
local Player = require 'player'

function love.load()
    -- graphics
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Camera
    cam = camera()
    gameMap = sti('maps/testMap.lua')
    player = Player:new()


end

function love.update(dt)
    player:move(dt)
    cam:lookAt(player.x, player.y)

    -- avoid camera to go out of the map
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local mapW, mapH = gameMap.width * gameMap.tilewidth, gameMap.height * gameMap.tileheight

    cam.x = math.max(math.min(cam.x, mapW - w / 2), w / 2)
    cam.y = math.max(math.min(cam.y, mapH - h / 2), h / 2)
end

function love.draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["Ground"])
        gameMap:drawLayer(gameMap.layers["Trees"])
        player:draw()
    cam:detach()
end
