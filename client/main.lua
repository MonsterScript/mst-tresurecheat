local QBCore = exports['qb-core']:GetCoreObject()
local Object_Spawned = {}

RegisterNetEvent("hopqua:client:Sync", function(key)
    Config.SpawnRewards[key].active = false 
    if Object_Spawned[key] then 
        DeleteEntity(Object_Spawned[key])
        Object_Spawned[key] = nil
    end 
end)

local function DrawScene(coords, text)
    local onScreen, screenX, screenY = World3dToScreen2d(coords.x, coords.y, coords.z)
    if onScreen then
        local camCoords = GetGameplayCamCoords()
        local distance = #(coords - camCoords)
        local fov = (1 / GetGameplayCamFov()) * 75
        local scale = (1 / distance) * (4) * fov * (0.2)

        SetTextScale(0.0, scale)
        SetTextFont(1)
        SetTextProportional(true)
        SetTextColour(255, 255, 255, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        DrawText(screenX, screenY)
    end
end

local function SpawnObjects()
    for k, v in pairs(Config.SpawnRewards) do
        if v.active then 
            local current = GetHashKey(v.object)

            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
            Object_Spawned[k] = CreateObject(current, v.coords.x, v.coords.y, v.coords.z-1, false, false, true)
            FreezeEntityPosition(Object_Spawned[k], true)
        end 
    end
end

local function DeleteObjects()
    for _, v in pairs(Object_Spawned) do
        DeleteEntity(v)
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    DeleteObjects()
end)

CreateThread(function()
    SpawnObjects()
    while true do 
        if LocalPlayer.state['isLoggedIn'] then
            local P = PlayerPedId() 
            local P_Coords = GetEntityCoords(P) 
            local inRange = false
            for k, v in pairs(Config.SpawnRewards) do 
                if v.active then 
                    if #(P_Coords - v.coords) <= 2.0 then 
                        inRange = true
                        DrawScene(v.coords, "~g~[E]~w~ Open Chest")
                        if IsControlJustReleased(0, 38) then 
                            OpenCase(k)
                        end 
                    end 
                end  
            end
            if not inRange then 
                Wait(500)
            end   
        else 
            Wait(500)
        end 
        Wait(0)
    end 
end)

function OpenCase(key)
    local ClosestPlayer, ClosestDistances = QBCore.Functions.GetClosestPlayer()
    if ClosestPlayer ~= -1 and ClosestDistances < 2 then
        QBCore.Functions.Notify("Can't open the chest when someone else is standing next to it")
    else     
        QBCore.Functions.Progressbar("mo_hom", "Opening treasure chest", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "mini@cpr@char_a@cpr_str",
            anim = "cpr_pumpchest",
            flags = 16,
        }, {}, {}, function() -- Done
            DeleteEntity(Object_Spawned[key])
            Object_Spawned[key] = nil 
            Config.SpawnRewards[key].active = false
            TriggerServerEvent("hopqua:server:OpenCase", key)
            ClearPedTasks(PlayerPedId())
            end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
        end)
    end 
end 

