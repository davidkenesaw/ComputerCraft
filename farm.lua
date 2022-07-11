--48 fuel per run

function refuel()
    for i = 1, 16 do
        if findItem("minecraft:coal") == true then
            turtle.refuel(1)
            break
        end
    end
    turtle.select(1)
end

function forward(value)
    for i = 1, value do
        if turtle.getFuelLevel() == 0 then
            refuel()
        end
        turtle.dig()
        turtle.forward()
    end
end
function placePlant(value, seed)
    for i = 1, value do
        if turtle.getFuelLevel() == 0 then
            refuel()
        end
        turtle.digDown()
        findItem(seed)
        turtle.placeDown()
        turtle.forward()
    end
end

function left(value)
    for i = 1, value do 
        turtle.turnLeft()
    end
end

function right(value)
    for i = 1, value do
        turtle.turnRight()
    end
end

function down(value)
    for i = 1, value do  
        if turtle.getFuelLevel() == 0 then
            refuel()
        end 
        turtle.digDown()
        turtle.down()
    end
end

function up(value)
    for i = 1, value do
        if turtle.getFuelLevel() == 0 then
            refuel()
        end
        turtle.digUp()
        turtle.up()
    end
end

function findItem(item)
    for i = 1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data then 
            if data.name == item then
                return true
            end
        end
    end
    return false
end

function setUp()
    up(1)
    left(1)
    forward(2)
    right(1)
end
function setUp2()
    up(4)
    left(1)
    forward(2)
    right(1)
end
function farm(seed)
    placePlant(8,seed)
    left(1)
    placePlant(1,seed)
    left(1)
    placePlant(8,seed)
    right(1)
    placePlant(1,seed)
    right(1)
    placePlant(8,seed)
    left(1)
    placePlant(1,seed)
    left(1)
    placePlant(8,seed)
end
function  cleanUp()
    left(1)
    placePlant(1,"minecraft:potato")
    forward(4)
    left(1)
    down(1)
end
function  cleanUp2()
    left(1)
    placePlant(1,"minecraft:wheat_seeds")
    forward(4)
    left(1)
    down(4)
end
function main()
    setUp()
    farm("minecraft:potato")
    cleanUp()
    setUp2()
    farm("minecraft:wheat_seeds")
    cleanUp2()
end 
main()
--setUp2()
--cleanUp()
