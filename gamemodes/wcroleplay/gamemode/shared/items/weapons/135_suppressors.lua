
local ITEM = ITEM || {};

/*

		if not CustomizableWeaponry:hasSpecifiedAttachments(activator, attatchmentsToGive) then
			CustomizableWeaponry.giveAttachments( activator , attatchmentsToGive )
		end
		*/
		
ITEM.ID = 135
ITEM.Category = "Weapon"
ITEM.Name = "Various Suppressors"
ITEM.Quality = 0
ITEM.Description = "Useful packet of suppressors for weapons."
ITEM.Model	= "models/Items/BoxSRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
ITEM.Cost = 2350;
ITEM.CamPos = Vector(27.03, -32.43, 10.81);
ITEM.LookAt = Vector(-100, 100, -100);
ITEM.Illegal = true
ITEM.Tradeable = false;
ITEM.Attatchment =  {"md_pbs1", "md_saker", "md_tundra9mm", "md_cobram2"}

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