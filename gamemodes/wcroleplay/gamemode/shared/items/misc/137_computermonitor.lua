
local ITEM = {};
 
ITEM.ID = 137
ITEM.Category = "Misc"
ITEM.Name = "Monitor"
ITEM.Quality = 5
ITEM.Description = "A rarity of sorts some people would say."
ITEM.Model	= "models/props/cs_office/computer_monitor.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 1;
ITEM.Class = "fsrpmonitor";
ITEM.Cost = 2500;
ITEM.CamPos = Vector(48.648648648649, 5.4054054054054, 27.027027027027);
ITEM.LookAt = Vector(-16.216216216216, 0, 0);

ITEM.OnPickedUp = function( _p )

end 
 
ITEM.CanUse = function( _p )
	return !_p:getFlag( "monitorStatus", false ) 
end
ITEM.OnUsed = function( _p )

	return false
	
end

ITEM.EntityOnUse = function( _p, _e )

	_p:setFlag( "monitorStatus", true )
	_p:setFlag( "monitorEntityIndex" , _e:EntIndex( ) );
	_e:setFlag("itemID", 137)
	_e:setFlag("savedInvEntity", true)
	
	return false
end

ITEM.OnDropped = function( _p )
	return true
end


SetupItem ( ITEM ) 