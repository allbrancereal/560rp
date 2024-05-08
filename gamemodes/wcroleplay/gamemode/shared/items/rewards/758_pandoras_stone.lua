
local ITEM = ITEM || {};

ITEM.ID = 758
ITEM.Category = "Misc"
ITEM.Name = "Pandoras Stone"
ITEM.Quality = 3
ITEM.Description = "Use to roll for a chance to double or half your money in the bank and what your carrying!"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);


ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	local _ran = math.random(2);
	if _ran == 1 then
		_oldbank = _p:getBank()*2
		_oldmon = _p:getMoney()*2
		_p:setBank(_oldbank);
		_p:setBank(_oldmon);
		_p:Notify("Your money has been doubled.")
	else
		_oldbank = _p:getBank()*.5
		_oldmon = _p:getMoney()*.5
		_p:setBank(_oldbank);
		_p:setBank(_oldmon);
		_p:Notify("Your money has been halved.")
	end
	return true
end

ITEM.OnUsed = function( _p )
	return false
end


ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 