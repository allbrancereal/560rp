local ITEM 					= {}

ITEM.ID 					= 146
ITEM.Reference 				= "hat_lumberjack"

ITEM.Name 					= "Lumberjack Hat"
ITEM.Description			= "Use this when you are out cutting down trees, wear it like a lumberjack."

ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= "models/player/items/heavy/fwk_heavy_lumber.mdl"
ITEM.CamPos= Vector(70, 0, 0);
ITEM.LookAt = Vector(60, 0, 0.7);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/player/items/heavy/fwk_heavy_lumber.mdl"
ITEM.Category				= "Hat"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.

ITEM.Forward = -0.5
ITEM.Right = -1.1

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