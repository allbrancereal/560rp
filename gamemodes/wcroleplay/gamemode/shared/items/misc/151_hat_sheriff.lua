local ITEM 					= {}

ITEM.ID 					= 151
ITEM.Reference 				= "hat_sheriff"

ITEM.Name 					= "Sheriff hat"
ITEM.Description			= "Used by the wild western sheriffs."

ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= "models/player/items/sniper/sniper_crocleather_slouch.mdl"
ITEM.CamPos= Vector(70, 0, 0);
ITEM.LookAt = Vector(60, 0, 0.5);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/player/items/sniper/sniper_crocleather_slouch.mdl"
ITEM.Category				= "Hat"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.

ITEM.Forward = -1.2
ITEM.Right = 0.7

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