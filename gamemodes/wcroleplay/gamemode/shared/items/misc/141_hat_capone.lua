local ITEM 					= {}

ITEM.ID 					= 141
ITEM.Reference 				= "hat_capone"

ITEM.Name 					= "Capones Hat"
ITEM.Description			= "This hat is the real shit, use it with pride."

ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= "models/player/items/heavy/capones_capper.mdl"
ITEM.CamPos= Vector(70, 0, 0);
ITEM.LookAt = Vector(60, 0, 0.7);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/player/items/heavy/capones_capper.mdl"
ITEM.Category				= "Hat"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.

ITEM.Forward = -1.6
ITEM.Right = -1

ITEM.AnglesAdjust = Angle(0,0,0)

ITEM.Hat = true

ITEM.OnPickedUp = function( _p )

end 
 
ITEM.CanUse = function( _p )
	return !_p:getFlag( "HatEquiped", false ) 
end
ITEM.OnUsed = function( _p )

	return false
	
end

ITEM.OnDropped = function( _p )
	return true
end
SetupItem(ITEM)