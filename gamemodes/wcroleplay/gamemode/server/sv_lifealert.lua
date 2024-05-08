


local _pMeta = FindMetaTable( "Player" )

function _pMeta:BroadcastLifeAlert ( )
	local _zone = self:GetZoneName();
	local _ToldPeople = {};

	if (!_zone or self:Team() != TEAM_CIVILLIAN ) then return print(_zone) end
	for k , v in pairs( player.GetAll() ) do 

		if ( v:Team() == TEAM_PARAMEDIC || v == self ) && !_ToldPeople[v:SteamID()] then
			
			self:ChatMessage( "[Case:" .. math.random(1001,9999) .."|" .. self:getRPName() .. "][Life-Alert][Location:" .. _zone[1] .. "]",8);
			_ToldPeople[v:SteamID()] = {};
		end
		
	end
	
end

function _pMeta:IsWanted()
	return self:getFlag("warrent", false);
end

function _pMeta:ToggleWanted()
	local _pWanted = self:IsWanted()

	self:SetWanted(!_pWanted);

end
function _pMeta:SetWanted(isWanted)

	self:setFlag("warrent", isWanted)

	if isWanted == true then
	
		self:setFlag("Lastwarrent", CurTime())
		self:SetStars(1)
	else
		self:SetStars(0)
	end
	
	for k , v in pairs(player.GetAll()) do
		
		if v != self then

			if isWanted == true then

				v:ChatMessage( "[WANTED] " .. self:getRPName() .. " has been made wanted!", 8 )				

			else

				v:ChatMessage( "[UNWANTED] " .. self:getRPName() .. " warrent has expired, the police will no longer look for them.", 8 )
			end

		end

	end

end

function _pMeta:GetStars()
	return self:getFlag("warrent_stars", 0);
end
function _pMeta:AddStars(x)
	local _stars = self:GetStars()
	self:SetStars(math.min(5,_stars+x))
	return true;
end
function _pMeta:RemoveStar(x)
	local _stars = self:GetStars()
	self:SetStars(math.max(0,_stars-x))
end
function _pMeta:SetStars(amount)
	// set the warrant stars
	self:setFlag("warrent_stars", amount);

end