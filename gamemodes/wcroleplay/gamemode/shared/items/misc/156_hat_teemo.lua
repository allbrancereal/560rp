local ITEM 					= {}

ITEM.ID 					= 156
ITEM.Reference 				= "hat_teemo"

ITEM.Name 					= "Captain Teemo's Hat"
ITEM.Description			= "Might teach you how to throw up explosion shrooms, he's back from League of Legends!"
ITEM.Category				= "Hat"
ITEM.Weight 				= 5
ITEM.Cost					= 5000

ITEM.MaxStack 				= 1

ITEM.InventoryModel 		= "models/player/items/soldier/soldier_warpig_s2.mdl"
ITEM.CamPos= Vector(70, 0, 0);
ITEM.LookAt = Vector(60, 0, 0);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/player/items/soldier/soldier_warpig_s2.mdl"

ITEM.RestrictedSelling	 	= false // Used for drugs and the like. So we can't sell it.

ITEM.Forward = 2.5
ITEM.Right = 1

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