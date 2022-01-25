local QBCore = exports['qbr-core']:GetCoreObject()

local woodcutter = {

    { x = 6.830657, y = 1209.566, z = 174.98445 }, -- near velentine
	{ x = 1358.8629, y = -948.0615, z = 54.988559 }, -- near rhodes
	{ x = -902.6328, y = -1100.234, z = 58.518131 }, -- near blackwater
	{ x = -1703.829, y = -309.0387, z = 178.11149 }, -- near strawberry
	{ x = 2747.6904, y = 1404.0628, z = 99.600639 }, -- near annesburg
	{ x = 2728.6862, y = 1303.8863, z = 94.96566 }, -- near annesburg
	-- add more as required
}

local active = false
local TreePrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil

function SetupTreePrompt()
    Citizen.CreateThread(function()
        local str = 'Start Chopping'
        TreePrompt = PromptRegisterBegin()
        PromptSetControlAction(TreePrompt, 0xF3830D8E) -- [J}
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(TreePrompt, str)
        PromptSetEnabled(TreePrompt, false)
        PromptSetVisible(TreePrompt, false)
        PromptSetHoldMode(TreePrompt, true)
        PromptRegisterEnd(TreePrompt)
    end)
end

AddEventHandler('rsg_woodcutter:hasEnteredMarker', function(zone)
    currentZone = zone
end)

AddEventHandler('rsg_woodcutter:hasExitedMarker', function(zone)
    if active == true then
        PromptSetEnabled(TreePrompt, false)
        PromptSetVisible(TreePrompt, false)
        active = false
    end
	currentZone = nil
end)

Citizen.CreateThread(function()
    SetupTreePrompt()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZone = false

        for k,v in ipairs(woodcutter) do
            if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.5) then
                isInMarker  = true
                currentZone = 'woodcutter'
                lastZone    = 'woodcutter'
            end
        end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('rsg_woodcutter:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('rsg_woodcutter:hasExitedMarker', lastZone)
		end
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if currentZone then
            if active == false then
                PromptSetEnabled(TreePrompt, true)
                PromptSetVisible(TreePrompt, true)
                active = true
            end
            if PromptHasHoldModeCompleted(TreePrompt) then
                TriggerEvent('rsg_woodcutter:clent:dowoodcutting')
                PromptSetEnabled(TreePrompt, false)
                PromptSetVisible(TreePrompt, false)
                active = false

				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("rsg_woodcutter:clent:dowoodcutting")
AddEventHandler("rsg_woodcutter:clent:dowoodcutting", function()
	QBCore.Functions.TriggerCallback('rsg_woodcutter:server:checkaxe', function(HasItems)  
		if HasItems then
			TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("EA_WORLD_HUMAN_TREE_CHOP_NEW"), 18000, true, false, false, false)
			Wait(18000)
			ClearPedSecondaryTask(playerPed)
			TriggerServerEvent('rsg_mining:server:giveWoodcuttingReward')
		else
			QBCore.Functions.Notify("You don't have a axe!", "error")
		end
	end)
end)