QBCore = exports['qbr-core']:GetCoreObject()

-- check player has axe
QBCore.Functions.CreateCallback('rsg_woodcutter:server:checkaxe', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local axe = Ply.Functions.GetItemByName("axe")
    if axe ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

-- give wood reward
RegisterServerEvent('rsg_mining:server:giveWoodcuttingReward')
AddEventHandler('rsg_mining:server:giveWoodcuttingReward', function()
    local src = tonumber(source)
    local xPlayer = QBCore.Functions.GetPlayer(src)
	local randomNumber = math.random(1,4)
	if randomNumber == 1 then
		xPlayer.Functions.AddItem('wood', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wood'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'you chopped one wood', 'success')
	elseif randomNumber == 2 then
		xPlayer.Functions.AddItem('wood', 2)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wood'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'you chopped two wood', 'success')
	elseif randomNumber == 3 then
		xPlayer.Functions.AddItem('wood', 3)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wood'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'you chopped three wood', 'success')
	else
		TriggerClientEvent('QBCore:Notify', src, 'You\'re axe got stuck, no wood this time!', 'error')
	end
end)