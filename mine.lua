args = {...}
torchDistance = 13
returnHomeValue = args[1]
blocksTraveled = 0
function returnHome(value)
    turtle.turnLeft()
    turtle.turnLeft()
    forward(value)
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
        filterInventorySlot()
    end
    turtle.select(1)
end

function containsMinedOre(value)
    ore = {"minecraft:torch","minecraft:coal","minecraft:raw_iron","minecraft:emerald","minecraft:diamond","minecraft:raw_gold","minecraft:redstone","minecraft:lapis_lazuli"}
    for i = 1, #(ore) do 
        if ore[i] == value then
            return true
        end
    end
    return false
end

function containsOre(value)
    ores = {"minecraft:coal_ore","minecraft:diamond_ore","minecraft:iron_ore","minecraft:emerald_ore","minecraft:gold_ore","minecraft:redstone_ore","minecraft:lapis_ore","minecraft:deepslate_lapis_ore","minecraft:deepslate_diamond_ore","minecraft:deepslate_redstone_ore","minecraft:deepslate_emerald_ore","minecraft:deepslate_gold_ore","minecraft:deepslate_coal_ore","minecraft:deepslate_iron_ore"}
    for i = 1, #(ores) do
        if ores[i] == value then
           return true 
        end
    end
    return false
end

function checkGravel()
    while turtle.detect() == true do
        success, data = turtle.inspect()
        print(success)
        if success then
            if data.name == "minecraft:gravel" then
                print("gravel")
                turtle.dig()
            else 
                print("not gravel")
                break
            end
        end
    end
     
end

function forward(value)
    
    for i = 1, value do
        checkGravel()
        if turtle.getFuelLevel() == 0 then
            refuel()
        end
        turtle.dig()
        checkGravel()
        turtle.forward()
    end
end

function turnLeft(value)
    for i = 1, value do 
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

function minePlot(value)
    for i = 1, value do
        print(turtle.getFuelLevel())
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
        print(turtle.getFuelLevel())
        inventoryFilter()
        minePlot(total)
        turnLeft(1)
        forward(1)
        turnRight(1)
    end
    returnHomeValue = returnHomeValue + mid
    blocksTraveled = blocksTraveled + mid
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
    local succes1, data1 = turtle.inspectDown()
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

function placeTorch()
    if findItem("minecraft:torch") == true then
        turtle.turnLeft()
        turtle.placeUp()
        turtle.turnRight()
    end
end

function refuel()
    for i = 1, 16 do
        if findItem("minecraft:coal") == true then
            turtle.refuel(1)
            break
        end
    end
    turtle.select(1)
end  

function countItems(item)
    amount = 0
    for i = 1, 16 do
        turtle.select(i)
        data = turtle.getItemDetail()
        if data then
            if data.name == item then
                amount = amount + turtle.getItemCount()
            end
        end
    end
    return amount

end

function distanceLimit()
    amount = countItems("minecraft:coal")
    gas = amount * 70
    if blocksTraveled >= gas then
        return true
    end
    return false
end

function main(args)
    
    for loop = 1, args[1],1 do
        if turtle.getFuelLevel() == 0 then
            refuel()
        end
        if distanceLimit() == true then
            returnHome(blocksTraveled)
            do return end
        end
        scan()
        turtle.dig()
        if loop%torchDistance == 0 then
            placeTorch()
        end
        turtle.digUp()
        forward(1)
        inventoryFilter()
        blocksTraveled = blocksTraveled + 1
        print("amount of blocks traveled: " .. blocksTraveled)
        print("amount of gas: " .. turtle.getFuelLevel())
    end
    returnHome(returnHomeValue)
end

main(args)
--print(countItems("minecraft:coal"))
--checkGravel()
--forward(10)
--collectOre()
--turnLeft(2)
--forward(100)
--turnLeft(2)
--forward(100)
--turnLeft(2)
