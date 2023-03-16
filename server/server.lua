local QBCore = exports['qb-core']:GetCoreObject()

function GetProhibility()
    local chance = math.random(1, 100)
    local status = "easy"
    if chance >= 90 then 
        status = "rare"
    elseif chance >= 70 and chance < 90 then 
        status = "common"
    else 
        status = "easy"
    end 
    return status
end 

RegisterNetEvent("hopqua:server:OpenCase", function(key)
    local Player = QBCore.Functions.GetPlayer(source)
    local Item_List = {}
    for k, v in pairs(Config.SpawnRewards[key].items) do 
        if GetProhibility() == v then 
            Item_List[k] = true 
        end
    end 

    for k, v in pairs(Item_List) do 
        Player.Functions.AddItem(k, Config.Amount[k] or 1)
    end 

    TriggerClientEvent("hopqua:client:Sync", -1, key)
end)

