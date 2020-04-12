--[[
    TODO: animation for the ship
    TODO: scaling and zooming in

]]--
backgroundlayer0 = love.graphics.newImage("assets/layers/backgroundlayer0(5).png")
backgroundlayer0x = 0

backgroundlayer1 = love.graphics.newImage("assets/layers/backgroundlayer1(8).png")
backgroundlayer1x = 0

backgroundlayer2x = 0

backgroundlayer3 = love.graphics.newImage("assets/layers/backgroundlayer3(10).png")
backgroundlayer3x = 0

scalefactor = 1
translatefactor = 0

backgroundlayer5 = love.graphics.newImage("assets/layers/backgroundlayer5(still).png")
backgroundlayer5x = 0

backgroundcolor = love.graphics.newImage("assets/layers/backgroundcolor.png")

asteroid0 = love.graphics.newImage("assets/layers/asteroid(0).png")

asteroid1 = asteroid0
asteroid1x = 896
asteroid1y = 414/2

asteroid2 = asteroid0
asteroid2x = 896
asteroid2y = 414/3

asteroid3 = asteroid0


asteroid4 = asteroid0


asteroid5 = asteroid0


asteroid6 = asteroid0


ship = love.graphics.newImage("assets/layers/ship.png")
shipx = 896/6
shipy = 414/2

shipx2 = shipx + 180
shipy2 = shipy + 74

shipexpectedy = 414/2

score = 0

font = love.graphics.newFont("Roboto-Bold.ttf", 25)

activateLightSpeed = false
deactivateLightSpeed = false
lightSpeedDuration = 0
deactivateLightSpeedDuration = 0
function love.load()

    love.window.setMode(896,414,{vsync = true, fullscreen = false, resizable = true})
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)
    

end



multiplier = 5

function love.update(dt)
  
    shipy2 = shipy + 74
  
    backgroundlayer0x = backgroundlayer0x - (multiplier/7)
    backgroundlayer1x = backgroundlayer1x - (multiplier/6)
    backgroundlayer2x = backgroundlayer2x - (multiplier/5)
    backgroundlayer3x = backgroundlayer3x - (multiplier/4)
    backgroundlayer5x = backgroundlayer5x - (multiplier/2)
    asteroid1x = asteroid1x - (multiplier/3)
    asteroid2x = asteroid2x - (multiplier/3)
    checkIfBackgroundImagesClipped()
    
    score = score + dt
    
    differenceShipY = shipy - shipexpectedy

    if(shipexpectedy > shipy)
    then
        if(shipy2 <= shipexpectedy)
        then
            shipy = shipy + 1
        end
    else
        shipy = shipy - 1        
    end


    checkIfAsteroidClipped(dt)

    if(activateLightSpeed == true)
    then
        whenLightSpeed(dt)
    end

    if(deactivateLightSpeed == true)
    then
        whenDeactivatingLightSpeed(dt)
    end

end

x = 0
globaly = 0


function checkIfAsteroidClipped(dt)

    math.randomseed(dt)
    if(asteroid1x <= -50)
    then 
        asteroid1x = 896
        asteroid1y = math.random(5,414-50)

    end

    if(asteroid2x <= -50)
    then 
        asteroid2x = 896
        asteroid2y = math.random(5,414-50)
    end

end

function checkIfBackgroundImagesClipped()

    if(backgroundlayer0x <= -896) then
        backgroundlayer0x = 0
    end

    if(backgroundlayer1x <= -896) then
        backgroundlayer1x = 0
    end

    if(backgroundlayer3x <= -896) then
        backgroundlayer3x = 0
    end
    

end
function love.touchpressed( id, x, y, dx, dy, pressure )
    -- test if the touch happened in the upper half of the screen
    shipexpectedy = y
    if(x >= 200 and activateLightSpeed == false)
    then
        activateLightSpeed = true
        multiplier = multiplier + 20
    end
end
    

function love.mousepressed( x, y, button, istouch, presses )
    shipexpectedy = y
    if(x >= 200 and activateLightSpeed == false)
    then
        activateLightSpeed = true
        multiplier = multiplier + 20
    end
end



function whenLightSpeed(dt)
    scalefactor = scalefactor + 0.001
    translatefactor = translatefactor - 0.1
    lightSpeedDuration = lightSpeedDuration + dt
    if(lightSpeedDuration >= 3)
    then
        activateLightSpeed = false
        multiplier = 5
        deactivateLightSpeed = true
        lightSpeedDuration = 0
    end
end

function whenDeactivatingLightSpeed(dt)
    scalefactor = scalefactor - 0.001
    translatefactor = translatefactor + 0.1
    deactivateLightSpeedDuration = deactivateLightSpeedDuration + dt
    if(deactivateLightSpeedDuration >= 3)
    then
        deactivateLightSpeed = false
        deactivateLightSpeedDuration = 0
    end
    
end

function love.draw()
    
    love.graphics.scale(scalefactor, scalefactor)
    love.graphics.translate(0, translatefactor)
    love.graphics.draw(backgroundcolor,0,0);
    love.graphics.draw(backgroundlayer0,backgroundlayer0x,0);
    love.graphics.draw(backgroundlayer1,backgroundlayer1x,0);
 
    love.graphics.draw(backgroundlayer3,backgroundlayer3x,0);
    love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
    --love.graphics.print(backgroundlayer1x,0,0)

    if(backgroundlayer5x >= -120)
    then
        love.graphics.draw(backgroundlayer5,backgroundlayer5x,0);
    end
    love.graphics.draw(asteroid0,asteroid1x,asteroid1y,0)
    love.graphics.draw(asteroid1,asteroid2x,asteroid2y,90)
    love.graphics.draw(ship,shipx,shipy)
    love.graphics.print(math.floor(score+0.5),20,20)
    
    
    
end