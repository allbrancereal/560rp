-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; SCRIPT BY DARKWRAITH AND RAINCHU PLEASE CONTACT THEM (ON STEAM) FOR ANY BUGS/SUGGESTIONS FOR THE SCRIPT!
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua" )
 /*
--Materials
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/base color.vmt" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/base colortwo.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/base normal.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/base specular.vtf" )

resource.AddFile( "materials/models/dwdarksouls/bonfireblend/bonfiresword color.vmt" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/bonfiresword color.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/bonfiresword normal.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/bonfiresword specular.vtf" )

resource.AddFile( "materials/models/dwdarksouls/bonfireblend/detail color.vmt" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/detail color.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/detail normal.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/detail specular.vtf" )

resource.AddFile( "materials/models/dwdarksouls/bonfireblend/skeleton color.vmt" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/skeleton color.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/skeleton normal.vtf" )
resource.AddFile( "materials/models/dwdarksouls/bonfireblend/skeleton specular.vtf" )
       
--Models       
resource.AddFile( "models/dwdarksouls/bonfireblend.dx80.vtx" )
resource.AddFile( "models/dwdarksouls/bonfireblend.dx90.vtx" )
resource.AddFile( "models/dwdarksouls/bonfireblend.mdl" )
resource.AddFile( "models/dwdarksouls/bonfireblend.phy" )
resource.AddFile( "models/dwdarksouls/bonfireblend.sw.vtx" )
resource.AddFile( "models/dwdarksouls/bonfireblend.vvd" )

--Sound
resource.AddFile( "sound/dwdarksouls/bonfire/bonfirewav.wav" )

--Particles
resource.AddFile("particles/dwdarksouls/fire_01.pcf")
*/

-- Utility function for bring, goto, and send
local function playerSend( from, to, force )
	if not to:IsInWorld() and not force then return false end -- No way we can do this one

	local yawForward = to:EyeAngles().yaw
	local directions = { -- Directions to try
		math.NormalizeAngle( yawForward - 180 ), -- Behind first
		math.NormalizeAngle( yawForward + 90 ), -- Right
		math.NormalizeAngle( yawForward - 90 ), -- Left
		yawForward,
	}

	local t = {}
	t.start = to:GetPos() + Vector( 0, 0, 120 ) -- Move them up a bit so they can travel across the ground
	t.filter = { to, from }

	local i = 1
	t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
	local tr = util.TraceEntity( t, from )
	while tr.Hit do -- While it's hitting something, check other angles
		i = i + 1
		if i > #directions then	 -- No place found
			if force then
				return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
			else
				return false
			end
		end

		t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47

		tr = util.TraceEntity( t, from )
	end
	
	return tr.HitPos
end

function entityGoto( calling_ply, target_ply )
	if not calling_ply:IsValid() then
		Msg( "You may not step down into the mortal world from console.\n" )
		return
	end

	if not calling_ply:Alive() then
		calling_ply:ChatPrint( "You are dead!" )
		return
	end

	local newpos = playerSend( calling_ply, target_ply, true )
	if not newpos then
			calling_ply:ChatPrint("Can't find a place to put you, noclip and go again")
		//return
	end

	local newang = (target_ply:GetPos() - newpos):Angle()

	calling_ply:SetPos( newpos )
	calling_ply:SetEyeAngles( newang )
	calling_ply:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!
	
end

hook.Add( "InitPostEntity","MakeBonfires", function()
	
	GenerateBonfiresFromTable()

end )

util.AddNetworkString("sendBonfire")
util.AddNetworkString("startTrueTele")
util.AddNetworkString("getTeleportCall")
util.AddNetworkString("sendBonfireMenu")

net.Receive( "startTrueTele", function( _l , _p )

	for k , v in pairs( ents.FindByClass("cn_npc" ) ) do
	
		if v:GetQuest() == "druggo" then
		
			entityGoto( _p, v )
			break
			
		end
		
	end

end )
function ENT:Use( ply )
	ply.NextUse = ply.NextUse || 0;
	
	if ply:GetStars() > 0 then return ply:Notify("Wanted people cannot teleport") end

	if !ply.LitBonfires then
	
		ply.LitBonfires = {}
		
	end
	local _KnownBonfires = ply:getFlag("knownBonfires", nil )
	if !_KnownBonfires then 
	
		_KnownBonfires = {};
		
	end
	
	if ply.NextUse < CurTime() then
	
		ply.NextUse = CurTime() + 3;
		
		if !table.HasValue(ply.LitBonfires, self:EntIndex()) then
		
			if !ply.LitBonfires then
					
				ply.LitBonfires = {};
				
				
			end
				
			table.insert( ply.LitBonfires , self:EntIndex( ) )
			
			if !table.HasValue( _KnownBonfires, self:getFlag("bonfireID", 0 ) ) then
			
				table.insert( _KnownBonfires, self:getFlag("bonfireID", 0 ) )
				ply:setFlag("knownBonfires", _KnownBonfires );
				
			end
			
			//PrintTable( ply.LitBonfires );
			
			net.Start("sendBonfire")
				net.WriteInt( self:EntIndex() , 32  );
				net.WriteBool( false );
				net.WriteTable( ply.LitBonfires )
			net.Send( ply );
			
		else
			local _hasCD , _timeLeft = 	ply:HasCooldown("BonfireTeleport", 300);
			if 	_hasCD == true  then  return ply:Notify("You already teleported in the last 5 minutes try again in " .. math.Round(_timeLeft,2) .. " seconds.") end

			net.Start("sendBonfireMenu")
				net.WriteInt( self:EntIndex() , 32 )
				net.WriteInt( self:getFlag("bonfireID",0), 8 );
				net.WriteTable(_KnownBonfires)
			net.Send( ply )
			
		end
	
	end
		
end

// Incase we spawn it in sandbox.
function ENT:OnRemove()

	for k , v in pairs( player.GetAll() ) do
	
		if v.LitBonfires && table.HasValue(v.LitBonfires, self:EntIndex()) then
		
			table.RemoveByValue( v.LitBonfires, self:EntIndex() )
			
		end
		
	end			
			
end

