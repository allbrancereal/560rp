

function fsrp.mining.GenerateRockHash( _p , rockTypeString )
	
	local _type = fsrp.mining.config.RockTypes[rockTypeString];
	
	if !_type then
	
		return print("Could not find rock type, aborting fsrp.mining.")
		
	end
	
	if !IsValid( _p ) || !_p:Alive() then
	
		return print( "Invalid character mining pick attempt" )
		
	end
	
	local _RocksToGive = {};
	

	for k , v in pairs( fsrp.mining.config.RockTypes ) do
	
		local _shouldBeConsidered = math.random( 1, 100 )
		
		if _shouldBeConsidered > v.ConsideredPercentage then
		
			table.insert( _RocksToGive , { name = k , amount = math.random( v.MinDropChance, v.MaxDropChance ) } )
			
		end
	
	end
	
	
	
	return _RocksToGive
	
end 

local _pMeta = FindMetaTable( 'Player' )

function fsrp.mining.GiveRock( _p , rockTypeString )

	if !_p:IsPlayer() || !IsValid( _p ) || !_p:Alive() then return end

	local _hash = fsrp.mining.GenerateRockHash( _p , rockTypeString );
	
	//PrintTable( _hash )
	
	for k , v in pairs( _hash ) do
	
		for i = 1 , v.amount do
		
			_p:AddItemByID( fsrp.mining.config.RockTypes[v.name].ItemID )
			
		end
		
	end

end

function fsrp.mining.makeRocks()

	for k , v in pairs( ents.FindByClass("fsrp_rock") ) do
	
		if IsValid( v ) then
		
			v:Remove() 
		end
		
	end
	
	fsrp.mining.cache.SpawnedRocks = {};
			
	for k , v in pairs( fsrp.mining.config.RockSpawns ) do
	
		local _rockCache = ents.Create( "fsrp_rock" )
		_rockCache:SetPos( v.pos )
		_rockCache:SetAngles( v.ang )
		_rockCache:SetModel( v.mdl )
		table.insert( fsrp.mining.cache.SpawnedRocks , _rockCache )
		_rockCache:Spawn()
		_rockCache:SetRockType( v.dominanttype )
		
	end
	
end

hook.Add( "InitPostEntity" , "miningAddon_SpawnRocks" , function (  )
	
		if #player.GetAll() <= 1 then
		
			for k , v in pairs( fsrp.PropertyTable ) do

				SetupProperty( v )
				
			end
		
		end

	fsrp.mining.makeRocks()
			
					
end )