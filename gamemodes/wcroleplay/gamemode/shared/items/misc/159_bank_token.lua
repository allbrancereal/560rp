local ITEM 					= {}

ITEM.ID 					= 159;

ITEM.Name 					= "Mortgage Payment"
ITEM.Description			= "Earn 250 Reputation with the bank when smashing this token."
ITEM.Category				= "Misc"
ITEM.Weight 				= 5
ITEM.Cost					= 40

ITEM.MaxStack 				= 1
ITEM.CamPos = Vector(32.43, 32.43, 48.65);
ITEM.LookAt = Vector(-10.81, 0, 0);
ITEM.ModelFOV 					= 20
ITEM.Model 			= "models/props_lab/binderbluelabel.mdl"

ITEM.RestrictedSelling	 	= true // Used for drugs and the like. So we can't sell it.

ITEM.OnPickedUp = function( _p )

end 
 
ITEM.CanUse = function( _p )
	return true
end
ITEM.OnUsed = function( _p )
	
	_p:AddReputation( 3, 250 )

	return false;
	
end

ITEM.OnDropped = function( _p )
	return true
end

SetupItem(ITEM)