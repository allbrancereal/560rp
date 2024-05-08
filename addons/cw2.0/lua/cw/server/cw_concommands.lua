/*
hook.Add( "InitPostEntity" , "turnAutoSpawnAttatchOff", function()

	local newLine = "\n"
	local space = " "
	
	-- process attachments
	for k, v in ipairs(CustomizableWeaponry.registeredAttachments) do
		local value = tonumber(ply:GetInfo(v.clcvar))
		
		game.ConsoleCommand(v.cvar .. space .. 0 .. newLine)
	end
	
	timer.Simple(0, function()
		CustomizableWeaponry:updateAdminCVars()
	end)
end)

*/

function CW20_DisableAllAttachmentsOnSpawn()
	
	for key, attData in ipairs(CustomizableWeaponry.registeredAttachments) do
		game.ConsoleCommand(attData.cvar .. " 0\n")
	end
	timer.Simple(0, function()
		CustomizableWeaponry:updateAdminCVars()
	end)
end
hook.Add( "InitPostEntity" , "turnAutoSpawnAttatchOff", function()

	CW20_DisableAllAttachmentsOnSpawn()
end)

concommand.Add("cw_disable_all_attachments_on_spawn", CW20_DisableAllAttachmentsOnSpawn)
/*
local function CW20_EnableAllAttachmentsOnSpawn(ply, com, args)
	if not ply:IsDev() then
		return
	end
	
	for key, attData in ipairs(CustomizableWeaponry.registeredAttachments) do
		game.ConsoleCommand(attData.cvar .. " 1\n")
	end
end

concommand.Add("cw_enable_all_attachments_on_spawn", CW20_EnableAllAttachmentsOnSpawn)
*/
/*
local function CW20_DropWeapon(ply, com, args) -- makes you drop your CW 2.0 weapon with all attachments stored on it
	if not CustomizableWeaponry.canDropWeapon then
		return
	end
	
	if not ply:Alive() then
		return
	end
	
	CustomizableWeaponry:dropWeapon(ply)
end

concommand.Add("cw_dropweapon", CW20_DropWeapon)*/
