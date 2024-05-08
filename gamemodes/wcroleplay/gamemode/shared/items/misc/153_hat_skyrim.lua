local ITEM 					= {}

ITEM.ID 					= 153
ITEM.Reference 				= "hat_skyrim"

ITEM.Name 					= "Dragonborn Hat"
ITEM.Description			= "FUS ROH DAH!"

ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= "models/player/items/heavy/skyrim_helmet.mdl"
ITEM.CamPos= Vector(70, 0, 0);
ITEM.LookAt = Vector(60, 0, 0.7);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/player/items/heavy/skyrim_helmet.mdl"
ITEM.Category				= "Hat"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.

ITEM.Forward = -1
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