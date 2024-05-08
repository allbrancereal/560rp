local ITEM 					= {}

ITEM.ID 					= 157;

ITEM.Name 					= "Medical Alert"
ITEM.Description			= "Allows you to share your location with a paramedic."
ITEM.Category				= "Misc"
ITEM.Weight 				= 5
ITEM.Cost					= 1250

ITEM.MaxStack 				= 1
ITEM.CamPos = Vector(0, 0, 0);
ITEM.LookAt = Vector(0, 0, 5.41);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/props_c17/consolebox05a.mdl"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.


ITEM.OnPickedUp = function( _p )

end 
 
ITEM.CanUse = function( _p )
	return false
end
ITEM.OnUsed = function( _p )
	
	return false
	
end

ITEM.OnDropped = function( _p )
	return true
end

SetupItem(ITEM)