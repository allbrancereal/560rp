
util.AddNetworkString("fsrp_physcolor")
local function SetPhysColor(ply, tab)
	local col = Vector(math.Clamp(tonumber(tab[1]), 0.01, 1), math.Clamp(tonumber(tab[2]), 0.01, 1), math.Clamp(tonumber(tab[3]), 0.01, 1))
	ply.PhysColor = col
	ply:SetWeaponColor(col)
end


function LoadPhysgunColors(ply)
	if(ply:IsDonator()) then
		
		fsdb:Query("SELECT `col` FROM `fsdb_physcol` WHERE `id`='"..ply:SteamID().."'", function (_,data)

			if(data and data[1] and data[1]["col"]) then

				local tbl = string.Explode(",", data[1]["col"])
				if(#tbl != 3) then return end


				SetPhysColor(ply, tbl)
			end
		end)

	end	
end

net.Receive("fsrp_physcolor", function( length, ply )
	if(!ply:IsDonator()) then return end
	if(ply:getBank() < fsrp.config.PhysgunColorPrice) then return ply:Notify("You do not have enough money in the bank for this") end
	
	local tbl = net.ReadTable()
	if(#tbl != 3) then return end

	SetPhysColor(ply, tbl)

	ply:addBank(-fsrp.config.PhysgunColorPrice)

	local newtab = {tostring(math.Round(tbl[1], 2)), tostring(math.Round(tbl[2], 2)), tostring(math.Round(tbl[3], 2))}
	local qstring = string.Implode(",", newtab)
	fsdb:Query("REPLACE INTO `fsdb_physcol` (`id`, `col`) VALUES ('".. ply:SteamID() .."', '".. qstring .."')")
end)