args = {...}
returnHomeValue = args[1]

function returnHome()
    turtle.turnLeft()
    turtle.turnLeft()
    for loop = 0, returnHomeValue, do
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
end

function filterInventorySlot()
    local data = turtle.getItemDetail()
    if data then 
        if containsMinedOre(data.name) == false then
            turtle.drop()
        end
    end
end

function inventoryFilter()
    for i = 1, 16 do
        turtle.select(i)
        filterInventory()
    end
    turtle.select(1)
end

function containsOre(valuelist)
    ore = {"minecraft:coal","minecraft:diamond","minecraft:raw_iron","minecraft:emerald","minecraft:raw_gold","minecraft:redstone","minecraft:lapis_lazuli"}
    for i = 1, #(ore) do 
        if ore[i] == value then
            return true
        end
    end
    return false
end 

function containsOre(valuelist)
    ores = {"minecraft:coal_ore","minecraft:diamond_ore","minecraft:iron_ore","minecraft:emerald_ore","minecraft:gold_ore","minecraft:redstone_ore","minecraft:lapis_ore"}
    for i = 1, #(ores) do 
        if ores[i] == value then
            return true
        end
    end
    return false
end 

function forward(value)
    for i = 1, value do
        turtle.dig()
        turtle.forward()
    end
end

function turnLeft(value)
    fori = 1, value do
        turtle.turnLeft()
    end
end

function turnRight(value)
    for i = 1, value do
        turtle.turnRight()
    end
end

function down(value)
    for i = 1, value do
        turtle.digDown()
        turtle.down()
    end
end

function up(value)
    for i = 1, value do
        turtle.digUp()
        turtle.up()    
    end
end

function minePlot(value)
    for i = 1, value do
        forward(value)
        turnLeft(2)
        up(1)
    end
    down(value)
end

function collectOre()
    mid = 2
    total = mid * 2

    turnLeft(2)
    forward(mid)
    turnRight(1)
    forward(mid)
    down(mid)
    turnLeft(2)

    for i = 1, total do
        inventoryFilter()
        minePlot(total)
        turnLeft(1)
        forward(1)
        turnRight(1)
    end
    returnHomeValue = returnHomeValue + mid
    up(mid)
    forward(mid)
    turnLeft(1)
end

function detectOre()
    local success, data = turtle.inspect()
    if containsOre(data.name) == true then
        return true
    end
    return false
end

function detectUpDown()
    local success, data = turtle.inspectUp()
    local success1, data1 = turtle.inspectDown()

    if containsOre(data.name) == true then
        return true
    elseif containsOre(data1.name) then
        return true
    end
    return false
end

function scan()
    boolResult = false
    for i = 1, 4 do
        if detectOre() == true then
            boolResult = true
        end
        turtle.turnLeft()
    end
    if detectUpDown() == true then
        boolResult = true
    end
    if boolResult == true then 
        collectOre()
    end
end

function main(args)
    for loop = 0, args[1], 1 do
        if turtle.getFuelLevel() == 0 then
            turtle.refuel(1)
        end
        scan()
        turtle.dig()
        turtle.digUp()
        turtle.digForward()
        inventoryFilter()
    end
    returnHome()
end

main(args)