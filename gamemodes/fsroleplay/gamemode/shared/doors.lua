

fsrp = fsrp || {};
PROPERTY_TABLE = PROPERTY_TABLE || {};

POLICE_DOOR_TABLE = {
	{Vector(-1477, 124, -106), 'models/props_c17/door01_left.mdl'},

	







}

BUISINESS_DOOR_TABLE = {
	{id = 1, pos = Vector( ) , mdl = ""},





}

local _eMeta = FindMetaTable("Entity");

function _eMeta:IsDoor( )

	return self:GetClass() != "item_doorbuster" and string.find(self:GetClass(), "door");

end 

function _eMeta:IsPoliceDoor(  )
	if !self:IsDoor() then return false end
	
	if (self.__policeDoor) then return true end
	
	for k , v in pairs( POLICE_DOOR_TABLE ) do
	
		if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
			
			self.__policeDoor = true;
			
			return true;
			
		end
		
	end
	
	return false;

end

function _eMeta:IsNeutralDoor(  )
	if !self:IsDoor() then return false end
	
	if (self.__neutralDoor) then return true end
	
	for k , v in pairs( NEUTRAL_DOOR_TABLE ) do
	
		if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
			
			self.__neutralDoor = true;
			
			return true;
			
		end
		
	end
	
	return false;
end

function _eMeta:IsBusinessDoor(  )
	if !self:IsDoor() then return false end
	
	if (self.__buisinessDoor) then return true end
	
	for k , v in pairs( BUISINESS_DOOR_TABLE ) do
	
		if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
			
			self.__buisinessDoor = true;
			
			return true;
			
		end
		
	end
	
	return false;

end
function fsrp.SetupProperty( PropertyTable )
	if PROPERTY_TABLE[PropertyTable.ID]  && PROPERTY_TABLE[PropertyTable.ID].Owners != PropertyTable.Owners  && PROPERTY_TABLE[PropertyTable.ID].PrimaryOwner != PropertyTable.PrimaryOwner  then return end
	 
	for k , v in pairs( PropertyTable.Doors ) do
	
		local foundDoor = false;
		
		for _, x in pairs( ents.FindInSphere( v[1], 50 ) ) do
		 
			if x:IsDoor() && x:GetModel() == v[2] then
							
				x.__doorID = v[3]
						
				if SERVER then
					x:Fire( "lock", "", 0 )
					for y , t in pairs(player.GetAll()) do
						net.Start("sendClientDoor")
							net.WriteInt( PropertyTable.ID, 8 )
							net.WriteString ( v[3], 8 )
						net.Send( t );
					end
				end
				foundDoor = true;
				
				break;
				
			end
			
			if !foundDoor then
			
				print("[560Roleplay] Missing doors for property #" .. PropertyTable.ID .. " Name: " .. PropertyTable.ID )
				
			end
		end
		
	end
	
	PROPERTY_TABLE[PropertyTable.ID] = PropertyTable;
end

local _pMeta = FindMetaTable( "Player" )

function _pMeta:CanManipulateDoor( door )

	if !table.HasValue( {TEAM_MAYOR, TEAM_POLICE}, self:Team() ) && door:IsPoliceDoor() then return false else return true end

	if !door:IsDoor() && !door:IsVehicle() then return false end
	
	local doorOwner = door:GetDoorOwner( )
	
	if table.HasValue( doorOwner , self:SteamID() ) then
	
		return true
		
	end
	
	if !doorowner || !IsValid( doorOwner ) || !doorOwner:IsPlayer() then return false end
	
	return false;
end

function _eMeta:GetDoorOwner( int )
	if !self:IsVehicle() && !self:IsDoor() then return nil end
	
	if self:IsDoor() then
	
		if self:GetPropertyTable() then
		
			return self:GetPropertyTable().PrimaryOwner[1];
			
		else
		
			return nil;
			
		end
		
	end
	
end
function _eMeta:GetDoorData()

	if !self:IsVehicle() && !self:IsDoor() then return nil end
	
	if self:IsDoor() then
	
		if self:GetPropertyTable() then
		
			return self:GetPropertyTable();
			
		else
		
			return nil;
			
		end
		
	end
	
end

function _pMeta:GiveProperty( _pid )
	local bool = false;
	
	if PROPERTY_TABLE[_pid] then
		if table.HasValue( PROPERTY_TABLE[_pid].Owners, self:SteamID() ) then return print("Couldn't give property, (Same owner)") end
		
		if PROPERTY_TABLE[_pid].CanBuy( self ) then
			
			bool = true;
			
		end
		
		if ( PROPERTY_TABLE[_pid].OnBought ) then
			
			PROPERTY_TABLE[_pid].OnBought( self )
			
		end
		if bool then
		
			table.insert( PROPERTY_TABLE[_pid].Owners, self:SteamID() )
				print("Added " .. self:Nick() .. " to property: " .. PROPERTY_TABLE[_pid].Name )
			if table.Count( PROPERTY_TABLE[_pid].PrimaryOwner ) == 0 then
			
				PROPERTY_TABLE[_pid].PrimaryOwner = {self:Nick(), self:SteamID()}
				print("Added " .. self:Nick() .. " to property Leader: " .. PROPERTY_TABLE[_pid].Name )
			end
			PROPERTY_TABLE[_pid].PostCanBuy( self, true )
			
		else
		
			self:Notify( "You are not allowed to buy this property " .. PROPERTY_TABLE[_pid].Name .. "!")
			PROPERTY_TABLE[_pid].PostCanBuy( self, false )
			
			return
		end
			
		if SERVER then
				
			net.Start("sendClientPropertyOwners")
				net.WriteTable( PROPERTY_TABLE[_pid].Owners )
				net.WriteInt( _pid , 8)
				if PROPERTY_TABLE[_pid].PrimaryOwner[2] == self:SteamID() then
					net.WriteBool( true );
				end
			net.Send( self )
					
		end
				
	end
	
end

function _pMeta:TakeProperty( _pid )

	if PROPERTY_TABLE[_pid] then
		if table.HasValue( PROPERTY_TABLE[_pid].PrimaryOwner, self:SteamID() ) then 
		
		if ( PROPERTY_TABLE[_pid].OnSold ) then
			
			PROPERTY_TABLE[_pid].OnSold( self )
			
		end

		for k , v in pairs( PROPERTY_TABLE[_pid].Owners ) do
		
			if v == self:SteamID() then
			
				table.Empty( PROPERTY_TABLE[_pid].Owners )
				table.Empty( PROPERTY_TABLE[_pid].PrimaryOwner )
				print("Removed all from property: " .. PROPERTY_TABLE[_pid].Name )
				
				if SERVER then
				
					net.Start("removeclientPropertyOwners")
						net.WriteInt( _pid , 8)
					net.Send( self )
					
				end
				
			else 
			
				table.remove( PROPERTY_TABLE[_pid].Owners , k );
				print("Removed " .. self:Nick() .. " to property: " .. PROPERTY_TABLE[_pid].Name )

				if SERVER then
				
					net.Start("updateclientPropertyOwners")
						net.WriteTable(  PROPERTY_TABLE[_pid].Owners  , 8)
						net.WriteInt( _pid , 8)
					net.Send( self )
					
				end
					
			end
			
		end
		
		
	else
	
		print("Couldn't take property away, (No owner)")
	
		end
	end
end

function _eMeta:GetPropertyTable( )

	if !self:IsDoor() then return end;
	
	for k, v in pairs( PROPERTY_TABLE ) do
			
		for _ , _info in pairs( v.Doors ) do
			//print(_info[1])
			//print(_info[2])
			if _info[1]:Distance( self:GetPos() ) < 50 && self:GetModel() == _info[2] then
					
				return PROPERTY_TABLE[v.ID];
							
			end
						
		end
				
	end
	
end

function showClientReadout( _p )
	
	local ent = _p:GetEyeTrace().Entity
	
	Msg("{Vector(" .. ent:GetPos().x .. ", " .. ent:GetPos().y .. ", " .. ent:GetPos().z .. "), '" .. ent:GetModel() .. "'},\n")

end

if CLIENT then

net.Receive( "sendClientPropertyOwners", function( _len , _p )
	local _tbl = net.ReadTable();
	local _id = net.ReadInt(8);
	
	local _bool = net.ReadBool( ) || false;
	
	PROPERTY_TABLE[_id].Owners = _tbl;
	
	if (_bool) then
			
			table.Empty( PROPERTY_TABLE[_id].PrimaryOwner )
		
			PROPERTY_TABLE[_id].PrimaryOwner = { LocalPlayer():Nick() , LocalPlayer():SteamID(), LocalPlayer():getRPName() };
			
		
	end
	
	
	
	
end )

net.Receive( "updateclientPropertyOwners", function( _len , _p )
	local _tbl = net.ReadTable();
	local _id = net.ReadInt(8);
	
	PROPERTY_TABLE[_id].Owners = _tbl;
		
	
end )

net.Receive( "removeclientPropertyOwners", function( _len , _p )

	local _id = net.ReadInt( 8 );
	
		table.Empty( PROPERTY_TABLE[_id].PrimaryOwner )
		table.Empty( PROPERTY_TABLE[_id].Owners )
	
	

end )

end
