local ITEM 					= {}

ITEM.ID 					= 158;

ITEM.Name 					= "Cash Register"
ITEM.Description			= "Allows you to sell an item securely."
ITEM.Category				= "Misc"
ITEM.Weight 				= 5
ITEM.Cost					= 1250

ITEM.MaxStack 				= 1
ITEM.CamPos = Vector(32.43, 32.43, 48.65);
ITEM.LookAt = Vector(-10.81, 0, 0);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/props_c17/cashregister01a.mdl"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.
ITEM.Class 					= "cashregister";

ITEM.OnPickedUp = function( _p )

end 
 
ITEM.CanUse = function( _p )
	return true
end
ITEM.EntityOnUse = function( self, entityItem )
	//entityItem:SetStallManager( self )
end
ITEM.OnUsed = function( _p )
		
	return false
	
end

ITEM.OnDropped = function( _p )
	return true
end

SetupItem(ITEM)