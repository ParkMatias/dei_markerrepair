ESX = exports['es_extended']:getSharedObject()

local blips = {}

Citizen.CreateThread(function ()
    Wait(1000)
    if Config.blips then
        for _,v in pairs(Config.markers) do
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, 402)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Mechanic")
            EndTextCommandSetBlipName(blip)
            table.insert(blips, blip)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
            for _,v in pairs(Config.markers) do
                DrawMarker(27, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.0, 0, 255, 0, 200, 0, 0, 0, 0)
            end
            for _,v in pairs(Config.markers) do
                local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
                local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, v.x, v.y, v.z, true)
                if (distance < 1.5) then
                    ESX.ShowHelpNotification("Presiona E para reparar el vehiculo.")
                    if (IsControlJustPressed(1, 51)) then
                        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                        local ped = GetPlayerPed(-1)
                        FreezeEntityPosition(ped, true)
                        FreezeEntityPosition(vehicle, true)
                        ESX.ShowNotification("Reparando vehiculo...")
                        Wait(5000)
                        FreezeEntityPosition(ped, false)
                        FreezeEntityPosition(vehicle, false)
                        SetVehicleFixed(vehicle)
                        SetVehicleDeformationFixed(vehicle)
                        ESX.ShowNotification("Vehiculo reparado.")
                    end
                end
			end
		end
	end
end)