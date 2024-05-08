
local ITEM = ITEM || {};

/*

		if not CustomizableWeaponry:hasSpecifiedAttachments(activator, attatchmentsToGive) then
			CustomizableWeaponry.giveAttachments( activator , attatchmentsToGive )
		end
		*/
		
ITEM.ID = 125
ITEM.Category = "Weapon"
ITEM.Name = "Deagle Barrels"
ITEM.Quality = 0
ITEM.Description = "Useful packet of barrels for the desert eagle."
ITEM.Model	= "models/Items/BoxSRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
ITEM.Cost = 1000;
ITEM.CamPos = Vector(27.03, -32.43, 10.81);
ITEM.LookAt = Vector(-100, 100, -100);
ITEM.Illegal = true
ITEM.Tradeable = false;
ITEM.Attatchment =  {"bg_deagle_compensator", "bg_deagle_extendedbarrel"}

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