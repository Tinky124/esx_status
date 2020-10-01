ESX = nil
Status = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    xPlayer.set('status', Status[xPlayer.identifier] or {
        {name = 'hunger', val = 500000},
        {name = 'thirst', val = 500000},
        {name = 'drunk',  val = 0},
    })

    TriggerClientEvent('esx_status:load', playerId, xPlayer.get('status'))
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    Status[xPlayer.identifier] = xPlayer.get('status') or {}
end)

AddEventHandler('esx_status:getStatus', function(playerId, statusName, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end
end)

RegisterServerEvent('esx_status:update')
AddEventHandler('esx_status:update', function(status)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.set('status', status)
	end
end)
