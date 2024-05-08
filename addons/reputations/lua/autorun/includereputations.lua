 
 
PlayerReputations = PlayerReputations || {};

PlayerReputations.ShowDebugPrints = false;

if PlayerReputations.ShowDebugPrints then

	print( "Including Reputation Files.")

end

if SERVER then


	// Load Shared Scripts
	for k,v in pairs(file.Find("reputation/*.lua", "LUA")) do
		AddCSLuaFile( "reputation/" .. v )
		include( "reputation/" .. v )
	end


	// Load Serverside Scripts
	for k,v in pairs(file.Find("reputation/sv/*.lua", "LUA")) do
		include( "reputation/sv/" .. v )

	end

	// Load Clientside Scripts
	for k,v in pairs(file.Find("reputation/cl/*.lua", "LUA")) do
		AddCSLuaFile( "reputation/cl/" .. v )

	end

end 

if CLIENT then


	// Load Clientside Scripts
	for k,v in pairs(file.Find("reputation/cl/*.lua", "LUA")) do
		include( "reputation/cl/" .. v )

	end

	// Load Shared Scripts
	for k,v in pairs(file.Find("reputation/*.lua", "LUA")) do
		
		include( "reputation/" .. v )

	end

end


   