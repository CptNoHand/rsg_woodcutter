local blips = {

	{ name = 'Wood Cutting', sprite = 1904459580, x = 6.830657, y = 1209.566, z = 174.98445 }, -- near valentine
	{ name = 'Wood Cutting', sprite = 1904459580, x = 1358.8629, y = -948.0615, z = 54.988559 }, -- near rhodes
	{ name = 'Wood Cutting', sprite = 1904459580, x = -902.6328, y = -1100.234, z = 58.518131 }, -- near blackwater
	{ name = 'Wood Cutting', sprite = 1904459580, x = -1703.829, y = -309.0387, z = 178.11149 }, -- near strawberry
	{ name = 'Wood Cutting', sprite = 1904459580, x = 2747.6904, y = 1404.0628, z = 99.600639 }, -- near annesburg
	{ name = 'Wood Cutting', sprite = 1904459580, x = 2728.6862, y = 1303.8863, z = 94.96566 }, -- near annesburg
	-- add more if you like

}

-- do not touch code below
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)