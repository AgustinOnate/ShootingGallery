function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 40

    score = 0 
    scorefont = love.graphics.newFont(35)
    timer = 0
    gameState = 1 

    sprites = {}
    sprites.back = love.graphics.newImage("sprites/back.png")
    sprites.target = love.graphics.newImage("sprites/target.png")
    sprites.crosshairs = love.graphics.newImage("sprites/crosshairs.png")

    love.mouse.setVisible(false)

end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end

    if timer < 0 then
        timer = 0
        gameState = 1 
    end 

end

function love.draw()
    love.graphics.draw(sprites.back, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(scorefont)
    love.graphics.print("SCORE: " .. score, 0,0)
    love.graphics.print("TIMER: " .. math.ceil(timer), 450,0)

    if gameState == 1 then
        love.graphics.printf("CLICK TO START", 0, 250, love.graphics.getWidth(), "center")
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end

        love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gameState == 2 then 
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        end

        if mouseToTarget > target.radius then
            score = score - 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        end
    elseif button == 1 and gameState == 1 then 
        gameState = 2
        timer = 10 
        score = 0
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y2)^2 )
end