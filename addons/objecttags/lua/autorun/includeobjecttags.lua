 
 
ObjectTags = ObjectTags || {};

ObjectTags.ShowDebugPrints = false;

if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag Files.")

end

if SERVER then

	//AddCSLuaFile( "ext/flagsnwlib.lua")
	//include( "ext/flagsnwlib.lua" )
	include("objtags/filesystem/tagmysql.lua")
	include("objtags/filesystem/tagsql.lua")
	include("objtags/filesystem/tagdata.lua")

	// Load Serverside Scripts
	for k,v in pairs(file.Find("objtags/sv/*.lua", "LUA")) do
		include( "objtags/sv/" .. v )

	end

	// Load Clientside Scripts
	for k,v in pairs(file.Find("objtags/cl/*.lua", "LUA")) do
		AddCSLuaFile( "objtags/cl/" .. v )

	end

	// Load Shared Scripts
	for k,v in pairs(file.Find("objtags/*.lua", "LUA")) do
		AddCSLuaFile( "objtags/" .. v )
		include( "objtags/" .. v )
	end


end 

if CLIENT then

	// Load Clientside Scripts
	for k,v in pairs(file.Find("objtags/cl/*.lua", "LUA")) do
		include( "objtags/cl/" .. v )

	end

	// Load Shared Scripts
	for k,v in pairs(file.Find("objtags/*.lua", "LUA")) do
		
		include( "objtags/" .. v )

	end

end


   