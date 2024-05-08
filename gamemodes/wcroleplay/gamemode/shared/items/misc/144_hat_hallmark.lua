local ITEM 					= {}

ITEM.ID 					= 144
ITEM.Reference 				= "hat_hallmark"

ITEM.Name 					= "Hallmark Hat"
ITEM.Description			= "These kinds of hats are usually worn by real pimps."

ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= "models/player/items/demo/hallmark.mdl"
ITEM.CamPos= Vector(70, 0, 0);
ITEM.LookAt = Vector(60, 0, 0.7);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/player/items/demo/hallmark.mdl"
ITEM.Category				= "Hat"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.

ITEM.Forward = 1.2
ITEM.Right = -0.8

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