local anim8 = require 'libraries/anim8'

local Player = {}

function Player:new()
    local obj = {
        x = 400,
        y = 200,
        speed = 5,
        spriteSheet = love.graphics.newImage('sprites/player-sheet.png'),
        animations = {},
        anim = nil
    }

    obj.grid = anim8.newGrid(12, 18, obj.spriteSheet:getWidth(), obj.spriteSheet:getHeight())

    obj.animations.down = anim8.newAnimation(obj.grid('1-4', 1), 0.2)
    obj.animations.left = anim8.newAnimation(obj.grid('1-4', 2), 0.2)
    obj.animations.right = anim8.newAnimation(obj.grid('1-4', 3), 0.2)
    obj.animations.up = anim8.newAnimation(obj.grid('1-4', 4), 0.2)

    obj.anim = obj.animations.left

    self.__index = self
    return setmetatable(obj, self)
end

function Player:move(dt)
    local isMoving = false
    local speed = self.speed

    if love.keyboard.isDown("up", "w") and love.keyboard.isDown("left", "a") then
        local diagSpeed = speed / math.sqrt(2)
        self.x = self.x - diagSpeed
        self.y = self.y - diagSpeed
        self.anim = self.animations.left
        isMoving = true

    elseif love.keyboard.isDown("up", "w") and love.keyboard.isDown("right", "d") then
        local diagSpeed = speed / math.sqrt(2)
        self.x = self.x + diagSpeed
        self.y = self.y - diagSpeed
        self.anim = self.animations.right
        isMoving = true

    elseif love.keyboard.isDown("down", "s") and love.keyboard.isDown("left", "a") then
        local diagSpeed = speed / math.sqrt(2)
        self.x = self.x - diagSpeed
        self.y = self.y + diagSpeed
        self.anim = self.animations.left
        isMoving = true
    elseif love.keyboard.isDown("down", "s") and love.keyboard.isDown("right", "d") then
        local diagSpeed = speed / math.sqrt(2)

        self.x = self.x + diagSpeed
        self.y = self.y + diagSpeed
        self.anim = self.animations.right
        isMoving = true
    else
        if love.keyboard.isDown("right", "d") then
            self.x = self.x + speed
            self.anim = self.animations.right
            isMoving = true
        elseif love.keyboard.isDown("left", "a") then
            self.x = self.x - speed
            self.anim = self.animations.left
            isMoving = true
        elseif love.keyboard.isDown("down", "s") then
            self.y = self.y + speed
            self.anim = self.animations.down
            isMoving = true
        elseif love.keyboard.isDown("up", "w") then
            self.y = self.y - speed
            self.anim = self.animations.up
            isMoving = true
        end
    end

    -- FIX: Player sprite has to be instantly played as soon as it starts moving
    if not isMoving then
        self.anim:gotoFrame(2)
    else
        if self.anim.position ~= 1 then
            self.anim:gotoFrame(1)
        end
        self.anim:update(dt)
    end
end

function Player:draw()
    local scaleX, scaleY = 6, 6
    self.anim:draw(self.spriteSheet, self.x, self.y, nil, scaleX, scaleY, 6, 9)
end

return Player
