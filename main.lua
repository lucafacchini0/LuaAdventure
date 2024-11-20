function love.load() 
    player = {}
    player.x = 400;
    player.y = 200;
    player.speed = 3;
end


function love.update(dt)
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        player.x = player.x + player.speed;
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        player.x = player.x - player.speed;
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        player.y = player.y - player.speed;
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        player.y = player.y + player.speed;
    end
end

function love.draw() 
    love.graphics.circle("fill", player.x, player.y, 50);
end