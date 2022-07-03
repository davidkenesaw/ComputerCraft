args = {...}
torchDistance = 13
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
function refuel()
    for i = 1, 16 do
        if findItem("minecraft:coal") == true then
            turtle.refuel(1)
            break
        end
    end
    turtle.select(1)
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
function placeLadder()
    if findItem("minecraft:ladder") == true then
        turtle.place()
    end
end  
function placeTorch()
    if findItem("minecraft:torch") == true then
        turnRight(2)
        turtle.dig()
        turtle.place()
        turnLeft(2)
    end
end  
function excavate()
    distance = args[1] - 12
    
    for i = 1, distance do
        down(1)
        turtle.dig()
        placeLadder()
        if i % torchDistance == 0 then
            placeTorch()
        end
    end
    up(distance)
end
excavate()
