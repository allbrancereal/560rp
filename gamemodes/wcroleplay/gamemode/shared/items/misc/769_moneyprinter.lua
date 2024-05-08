
local ITEM = ITEM || {};

ITEM.ID = 769
ITEM.Category = "Illegal"
ITEM.Name = "Money Printer"
ITEM.Quality = 3
ITEM.Description = "A printer capable of producing legal tender."
ITEM.Model	= "models/props_lab/reciever_cart.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 1;
ITEM.Cost = 5000;
ITEM.Class = "moneyprinter";
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.CamPos = Vector(43.24, 21.62, 43.24);
ITEM.LookAt = Vector(0, 0, 5.41);

ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	local _PlantAmount = _p:getFlag( "maxprinters", 0 );
	
	if _PlantAmount <=  _p:GetPrinterLimit() then
		
		return true
			
	else
		
		return false
			
	end
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	local _PrinterAmount = _p:getFlag( "maxprinters", 0 );

	_p:setFlag("maxprinters", _PrinterAmount + 1 )
	entityItem:getFlag( "ownedBy", _p:SteamID() )
end


SetupItem ( ITEM ) 