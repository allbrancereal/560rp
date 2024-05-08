
local ITEM = ITEM || {};

ITEM.ID = 47
ITEM.Category = "Misc"
ITEM.Name = "Health Vial"
ITEM.Quality = 0
ITEM.Description = "Allows you to inject a shot that will tend to any minor injuries."
ITEM.Model	= "models/healthvial.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(-16.22, 0, 5.41);
ITEM.LookAt = Vector(10.81, 0, 5.41);
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
	_p:SetHealth( math.Clamp(_p:Health() + 20 , 1 , 100 ))
	return false
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 