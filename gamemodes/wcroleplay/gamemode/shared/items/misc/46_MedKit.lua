
local ITEM = ITEM || {};

ITEM.ID = 46
ITEM.Category = "Misc"
ITEM.Name = "Med-Kit"
ITEM.Quality = 0
ITEM.Description = "A medicinal package that allows you to attend to your wounds."
ITEM.Model	= "models/Items/HealthKit.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(10.81, 0, 27.03);
ITEM.LookAt = Vector(-16.22, -5.41, -100);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	if !_p:Alive() then return end
	if _p.LastAction && _p.LastAction > CurTime() then return _p:Notify( "You must wait until using another Healing/Medicinal Item") end
	_p.LastAction = CurTime() + 1
	sound.Play('items/smallmedkit1.wav', _p:GetPos() , 100 );
	_p:SetHealth( math.Clamp( _p:Health() + 20 , 1 , 100))
	
	_p.__Crippled = false;
			

	local _runSpeed, _walkSpeed = _p:FindMovementSpeed();
	_p:SetWalkSpeed(_walkSpeed)
	_p:SetRunSpeed( _runSpeed )
	return false
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 