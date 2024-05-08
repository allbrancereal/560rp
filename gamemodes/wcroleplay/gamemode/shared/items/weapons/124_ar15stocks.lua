
local ITEM = ITEM || {};

/*

		if not CustomizableWeaponry:hasSpecifiedAttachments(activator, attatchmentsToGive) then
			CustomizableWeaponry.giveAttachments( activator , attatchmentsToGive )
		end
		*/
		
ITEM.ID = 124
ITEM.Category = "Weapon"
ITEM.Name = "AR 15 Stocks"
ITEM.Quality = 0
ITEM.Description = "Useful assortment of stocks designed for the AR 15."
ITEM.Model	= "models/Items/BoxSRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
ITEM.Cost = 900;
ITEM.CamPos = Vector(27.03, -32.43, 10.81);
ITEM.LookAt = Vector(-100, 100, -100);
ITEM.Illegal = true
ITEM.Tradeable = false;
ITEM.Attatchment = {"bg_ar15sturdystock", "bg_ar15heavystock"}


ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return !CustomizableWeaponry:hasSpecifiedAttachments( _p, ITEM.Attatchment );
end

ITEM.OnUsed = function( _p )

	CustomizableWeaponry.giveAttachments( _p ,  ITEM.Attatchment )
	
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 