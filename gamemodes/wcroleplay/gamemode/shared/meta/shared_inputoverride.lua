
local CMoveData = FindMetaTable( "CMoveData" )

function CMoveData:RemoveKeys( _k )
	-- Using bitwise operations to clear the key bits.
	local newbuttons = bit.band( self:GetButtons(), bit.bnot( _k ) )
	self:SetButtons( newbuttons )
end
local function GetBool( var, ply )
	if CLIENT then return cvars.Bool(var) end
	return ply:GetInfo( var )=="1"
end

function GM:StartCommand( _p  , _m )

/*
	if _m:KeyDown( IN_MOVELEFT ) && !_p:getFlag("leftStrafe", false ) then
	   
	   _p:SetAngles( _p:GetAngles( ) + Angle( 0, -50, 0 ) )
	   
		

		
		_p:setFlag("leftStrafe", true )
	
	elseif !_m:KeyDown( IN_MOVELEFT )  && _p:getFlag("leftStrafe", false ) then
	
		
		_p:setFlag("leftStrafe", false )
		
	end
	
	if _m:KeyDown( IN_MOVERIGHT )  && !_p:getFlag("rightStrafe", false ) then
	
	    _p:SetAngles( _p:GetAngles( ) + Angle( 0, 50, 0 ) )
		

		
		
		_p:setFlag("rightStrafe", true )
		
	elseif !_m:KeyDown( IN_MOVERIGHT )  && _p:getFlag("leftStrafe", false ) then
	
		
		_p:setFlag("rightStrafe", false )
		
	end
*/

	
end
