
local ITEM = ITEM || {};

ITEM.ID = 44
ITEM.Category = "Misc"
ITEM.Name = "Cannabis Plant"
ITEM.Quality = 0
ITEM.Description = "A wet cannabis plant ready to be placed for growing."
ITEM.Model	= "models/alakran/marijuana/marijuana_stage5.mdl"
ITEM.Weight = 0.5;
ITEM.Class = "cannabis_plant";
ITEM.MaxStack = 25;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.Cost = 25;
ITEM.CamPos = Vector(-100, -75.68, 16.22);
ITEM.LookAt = Vector(5.41, 5.41, 21.62);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	local _PlantAmount = _p:getFlag( "maxcannabisplants", 0 );
	
	if _PlantAmount <=  _p:GetCannabisPlantLimit() then
		
		return true
			
	else
		
		return false
			
	end
		
end

ITEM.OnUsed = function( _p )
	local _finished = _p:FinishedQuest(8);
	if _finished == false then
		_p:SetQuestStep(8,3)
	end
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 

ITEM.EntityOnUse = function ( _p, entityItem )
	local _PlantAmount = _p:getFlag( "maxcannabisplants", 0 );

	_p:setFlag("maxcannabisplants", _PlantAmount + 1 )
	entityItem:getFlag( "ownedBy", _p:SteamID() )
end

SetupItem ( ITEM ) 