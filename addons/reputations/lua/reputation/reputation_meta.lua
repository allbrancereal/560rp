
if PlayerReputations.ShowDebugPrints then

	print( "Including Reputation Meta Files.")

end

function PlayerReputations.GetReputationConfig( id ,amount )
	local _foundRep = false;

	for k , v in pairs( PlayerReputations.config.Reputations[id].levels ) do
		
		if _foundRep == true then
			
			break;

		end

		if v[2] < amount && v[3] > amount then
			_foundRep = true;

			return PlayerReputations.config.Reputations[id].levels[k];

		end

	end

	return PlayerReputations.config.Reputations[id].levels[PlayerReputations.config.Reputations[id].startlv] ;
end

local _eMeta = FindMetaTable("Entity");

function _eMeta:SetEntityReputation( id )
	if !PlayerReputations.config.Reputations[id] then return false end;
	if self:IsPlayer() then return false end;
	if !self || !IsValid(self) then return false end;

	self:setFlag("reputation", id);

	return true;
end

function _eMeta:GetEntityReputation(  )
	if self:IsPlayer() then return nil end;
	if !self || !IsValid(self) then return nil end;

	return self:getFlag("reputation", nil )
end

local _pMeta = FindMetaTable("Player");

function _pMeta:GetReputations() 

	return self:getFlag("knownReputations", {}, true );

end


if SERVER then
	util.AddNetworkString("replicateReputations");

	function ReplicateReputationToClients( _p )

		net.Start( "replicateReputations" );
			net.WriteString( util.TableToJSON(_p:getFlag("knownReputations",{},true)) )
			net.WriteString( _p:SteamID() )
		net.Broadcast()

	end

else

	net.Receive( "replicateReputations", function( _l, _locP )

		local _tb = net.ReadString()
		local _id = net.ReadString()

		local _p = player.GetBySteamID( _id );

		if !_p or !IsValid(_p) or !_p:IsPlayer() then
			return end

		_p:setFlag("knownReputations", util.JSONToTable(_tb), true );

	end)

end

function _pMeta:SetReputations( rep ) 

	self:setFlag("knownReputations", rep , true );

	if SERVER then
		ReplicateReputationToClients(self)
	end
	
	if SERVER then
		self:SaveReputations()
	end

	return true;
	
end

function _pMeta:DiscoverReputation( id )

	local _reputations = self:GetReputations()

	if !_reputations[id] then
		
		_reputations[id] = {PlayerReputations.config.Reputations[id].levels[PlayerReputations.config.Reputations[id].startlv][2],1};

		self:SetReputations( _reputations );


		return true;
	end

	return false;
end

function _pMeta:GetReputation( id )

	local _reputations = self:GetReputations()

	if !self || !IsValid( self ) || !self:IsPlayer() then return false end;
	// Return the default reputation if we dont know it.
	if !self:KnowsReputation( id ) then return PlayerReputations.config.Reputations[id].levels[PlayerReputations.config.Reputations[id].startlv][2], true end

	if _reputations[id] then
		
		_repAmount = _reputations[id][1];
		
		//local _RepLevel = PlayerReputations.GetReputationConfig( id , _repAmount );

		return _repAmount, false;

	end

	return PlayerReputations.config.Reputations[id].levels[PlayerReputations.config.Reputations[id].startlv][2], true;
end

function _pMeta:GetReputationBracket( id )

	local _RepAmount, defaulted = self:GetReputation( id );

	if defaulted then return PlayerReputations.GetReputationConfig( id , _RepAmount ), true end
	
	local _RepBracket = PlayerReputations.GetReputationConfig( id , _RepAmount ),false;

	return _RepBracket;

end

function _pMeta:SetReputation( id , amount )

	if !isnumber(id) then return false end
	
	local _reputations = self:GetReputations()

	if !_reputations[id] then return false end
	
	if !amount then 

		_reputations[id][1] = PlayerReputations.config.Reputations[id].levels[PlayerReputations.config.Reputations[id].startlv][2]
			
	else

		_reputations[id][1] = amount;

	end

	self:SetReputations( _reputations );

	return true;

end

function _pMeta:SetRepMultiplier( id , amount )

	if !isnumber(id) then return false end
	
	local _reputations = self:GetReputations()

	if !_reputations[id] then return false end
	
	if !amount then 

		_reputations[id][2] = 1;
			
	else

		_reputations[id][2] = math.max( 1, amount );

	end

	self:SetReputations( _reputations );

	return true;

end

function _pMeta:AddReputation( id , amount )

	if !isnumber(id) || !isnumber(amount) then return false end
	
	local _reputations = self:GetReputations()
	local _RepAmount, defaulted = self:GetReputation( id );
	local shouldAttempt = false;

	if defaulted == true then 

	
		local _discovered = self:DiscoverReputation(id)

		if _discovered then
			
			shouldAttempt = true;

		end

	else

		shouldAttempt = true;

	end	
	
	if shouldAttempt == false then 

		return false 

	end
		
	local _multiplier = _reputations[id][2] || 1;
	local _total =  _RepAmount + (amount*_multiplier);
	local _totalAfterMult = (amount*_multiplier); 

	self:SetReputations( _reputations );

	local _xtraTxt = "";

	if _totalAfterMult > amount then
		
		_xtraTxt = "(+" .. (_totalAfterMult-amount) .. ".00 Bonus)";

	end

	self:ChatPrint( "You have received +" .. _totalAfterMult .. ".00 " .. PlayerReputations.config.Reputations[id].name .. " Reputation. " .. _xtraTxt )

	return true, amount, _totalAfterMult;
end

function _pMeta:KnowsReputation( id ) 

	local _reputations = self:GetReputations()

	if !self || !IsValid( self ) || !self:IsPlayer() then return false end;

	if !_reputations || !_reputations[id] then return false end;

	if _reputations[id] then
		
		return true;

	end

	return false;
end

