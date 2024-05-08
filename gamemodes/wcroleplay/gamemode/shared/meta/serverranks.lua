
local _pMeta = FindMetaTable('Player');
local userGroupInfo = {};

userGroupInfo.Color = {

	[0] = Color( (math.sin(CurTime() * 5 ) + 1) / 3 * 235, 43, 255 - ((math.sin(CurTime() * 5) + 1) / 3 * 255), 255);
	
	[1] = Color(255, 0, 255, 150 + math.sin(RealTime() * 2) * 50 );
	
	[2] = Color( 25, 200+ math.sin(RealTime() * 2) * 50, 0, 255);
	
	[3] = Color( 128, 0, 128, 150 + math.sin(RealTime() * 2) * 50);
	
	[4] = Color( 150, 25 + math.sin(RealTime() * 2) * 50, 0, 255 );
	
	[5] = Color( 0,255,255, 255 );
	
	[6] = Color( 255, 120, 0, 255 );
	
	[7] = Color( 255, 0, 255, 255 );
	
	[8] = Color( 255, 200, 50, 255 );
	
	[9] = Color( 50, 50, 200, 255 );
	
	[10] = Color( 88, 88, 88, 255 );
	
}

userGroupInfo.MaxEnts = {

	[0] = -1,
	[1] = -1,
	[2] = -1,
	[3] = -1,
	[4] = 90,
	[5] = 90,
	[6] = 90,
	[7] = 10,
	[8] = 60,
	[9] = 60,
	[10] = 40,
	
}

userGroupInfo.Name = {

	[0] = "Council Member",
	[1] = "Developer",
	[2] = "Server Manager",
	[3] = "Super Administrator",
	[4] = "Administrator",
	[5] = "Super Moderator",
	[6] = "Moderator",
	[7] = "Banned",
	[8] = "VIP",
	[9] = "Respected",
	[10] = "Online Player",
	
}

userGroupInfo.DisguiseOnJoin = {

	[0] = true,
	[1] = true,
	[2] = true,
	[3] = true,
	[4] = false,
	[5] = false,
	[6] = false,
	[7] = false,
	[8] = false,
	[9] = false,
	[10] = false,

}

userGroupInfo.MaxBanLength = {

	[0] = 0,
	[1] = 0,
	[2] = 0,
	[3] = 604800 * 4,
	[4] = 604800 * 2,
	[5] = 604800,
	[6] = 86400,
	[7] = 3600,
	[8] = -1,
	[9] = -1,
	[10] = -1,

}

userGroupInfo.Weapons = {

	[0] = {
		"god_stick",
		"vc_spikestrip_wep",
		"vc_wrench",
		"weapon_physgun",
		"weapon_soapstone",
		"weapon_carving",
	},
	[1] = {
		"weapon_physgun",
		"god_stick",
		//"",
		//"",
	},
	[2] = {
		"god_stick",
		"weapon_physgun",
		//"",
		//"",
	},
	[3] = {
		"weapon_physgun",
		"god_stick_admin",
		//"",
		//"",
	},
	[4] = {
		"weapon_physgun",
		"god_stick_admin",
		//"",
		//"",
	},
	[5] = {
		"weapon_physgun",
		"god_stick_moderator",
		//"",
		//"",
	},
	[6] = {
		"god_stick_moderator",
		"weapon_physgun",
	},
	[7] = {
		"weapon_physgun",
		//"",
		//"",
	},
	[8] = {
		"weapon_physgun",
		"weapon_soapstone",
		"weapon_carving",
		//"",
		//"",
	},
	[9] = {
		"weapon_physgun",
		"weapon_soapstone",
		"weapon_carving",
		//"",
		//"",
	},

	[10] = {
		"weapon_physgun",
	},
}

function _pMeta:EquipUserGroupWeapons()
	if !SERVER then return end
	if !userGroupInfo.Weapons[ self:GetUserGroupRank() ] then return end
	
	for k , v in pairs( userGroupInfo.Weapons[ self:GetUserGroupRank() ] ) do
	
		self:Give( v )
		
	end

	return true

end
function UserGroupTable()

	return userGroupInfo
	
end


function _pMeta:GetUserGroupName()

	return userGroupInfo.Name[ self:GetUserGroup( ) ];

end

function fsrp.GetUserGroupName(x)
	return userGroupInfo.Name[ x ];
end

function _pMeta:GetUserGroupColor()

	return userGroupInfo.Color[ self:GetUserGroup( ) ];

end
function _pMeta:GetMaxEnts()
	return 70;
end

function _pMeta:GetMaxBanLength()

	return userGroupInfo.MaxBanLength[ self:GetUserGroup( ) ];

end


function _pMeta:IsCouncilMember() return tonumber(self:getFlag( "rank", 10  )) == 0 end
function _pMeta:IsDev() return tonumber(self:getFlag( "rank", 10  )) <= 1 end
function _pMeta:IsHeadAdmin() return tonumber(self:getFlag( "rank", 10  )) <= 2 end
function _pMeta:IsServerManager() return tonumber(self:getFlag( "rank", 10  )) <= 2 end
function _pMeta:IsSuperAdmin() return tonumber(self:getFlag( "rank", 10  )) <= 3 end
function _pMeta:IsAdmin() return tonumber(self:getFlag( "rank", 10  )) <= 4 end
function _pMeta:IsSuperModerator() return tonumber(self:getFlag( "rank", 10  )) <= 5 end
function _pMeta:IsModerator() return tonumber(self:getFlag( "rank", 10  )) <= 6 end
function _pMeta:IsVIP() return tonumber(self:getFlag( "rank", 10  )) <= 7 end
function _pMeta:IsRespected() return tonumber(self:getFlag( "rank", 10  )) <= 9 end

function _pMeta:IsDonator() return self:HasPublicTag( "donator" ) || self:IsAdmin() end
function _pMeta:IsPremium() return self:HasPublicTag( "donator_premium" ) || self:IsAdmin() end

function _pMeta:IsUser() return tonumber(self:getFlag( "rank", 10  )) == 10 end

function _pMeta:GetPrinterLimit()

	if self:IsUser() then
	
		return fsrp.config.MaxPrinters;
		
	elseif self:IsDonator() && !self:IsPremium() then
	
		return fsrp.config.MaxPrinters_DONATOR;
		
	elseif self:IsPremium() then
	
		return fsrp.config.MaxPrinters_PREMIUM;
		
	end

end
function _pMeta:GetCannabisPlantLimit()

	if self:IsUser() then
	
		return fsrp.config.MaxCannabisPlants;
		
	elseif self:IsDonator() && !self:IsPremium() then
	
		return fsrp.config.MaxCannabisPlants_DONATOR;
		
	elseif self:IsPremium() then
	
		return fsrp.config.MaxCannabisPlants_PREMIUM;
		
	end

end

function _pMeta:GetUserGroupRank() 

	return self:getFlag( "rank" , 10 )
	
end

function _pMeta:SetRank( _i )
	if !SERVER then return end;
	
	self:setFlag("rank", _i )
	
	fsdbUpdateAdminStatus( self )
	
	self:EquipUserGroupWeapons() 
	self:SetUserGroup( "rank_" .. _i )

end

function _pMeta:IsDisguised()

	return self:getFlag("disguised", false )
	
end

function _pMeta:ToggleDisguise()
	
	local _b =  self:IsDisguised( )
	
	self:setFlag( "disguised" , ( _b && false || !_b && true )  )

end

