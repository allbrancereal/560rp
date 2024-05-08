
RotoLevelSystem = RotoLevelSystem || {}
RotoLevelSystem.config = {}
RotoLevelSystem.config.InitialXPReq			= 1000;
RotoLevelSystem.config.AdditionalXPPerLevel = 30;
RotoLevelSystem.config.RewardXP				= 100;
RotoLevelSystem.config.RewardXPPerLevel		= 1;
local fl;
local DF_READ = 1
local DF_WRITE = 2
local DF_BOTH = 3
local _R = debug.getregistry()

local function DataField( ent, key, name, force, fl )
    fl = fl or DF_BOTH
    
    if bit.band( fl, DF_READ ) ~= 0 then
        ent[ "Get" .. name ] = function( e )
        	local res = e:GetSaveTable( )[ key ]
        
            if force == FORCE_NUMBER then 
            	return tonumber( res ) or 0
            elseif force == FORCE_STRING then
            	return tostring( res )
            elseif force == FORCE_BOOL then
            	return tobool( res )
            else
            	return res
            end
        end
        end
        if bit.band( fl, DF_WRITE ) ~= 0 then
        ent[ "Set" .. name ] = function( e, v )
        	if force == FORCE_NUMBER then
                e:SetSaveValue( key, tonumber( v ) or 0 )
            elseif force == FORCE_STRING then
                e:SetSaveValue( key, tostring( v ) )
            elseif force == FORCE_BOOL then
                e:SetSaveValue( key, tobool( v ) )
            else
                e:SetSaveValue( key, v )
            end
        end
    end
end

DataField( _R.Player, "m_flLastDamageTime", "LastDamagedTime", FORCE_NUMBER )

local function HealthRegen( ply )
		
		timer.Create("HealthRegen_"..ply:SteamID() , 1,0, function()
		//for k, v in pairs( player.GetAll( ) ) do
		local v = ply
		if v and v:Alive( ) and !v:InVehicle() and v:Health( ) < 100 and v:GetLastDamagedTime( ) <= -15 then

			local _skill = skillpoint_Helper_GetSkillPoint( v , "regeneration" );
			if tonumber(_skill) > 0 then
		       v:SetHealth( math.min( 100, v:Health( ) + (_skill*1) ) )
		       v:SetLastDamagedTime( 0 )
	     	end
	    end
		//end
	end)

end

local function RemHealthRegen( ply )
		
	timer.Destroy("HealthRegen_"..ply:SteamID())

end

local function MakeHealthRegenTimer(ply)
	HealthRegen(ply)
end 
hook.Add( "PlayerInitialSpawn", "HealthRegenTimer", MakeHealthRegenTimer )
local function RemoveHealthRegenTimer(ply)
	RemHealthRegen(ply)
end
hook.Add( "PlayerDisconnected", "HealthRegenTimerRem", RemoveHealthRegenTimer)

RotoLevelSystem.config.PerkTrees			= {
	[1] = {
		Name = "Stamina",
		Description ="Enhances your walking speed.",
	};
	[2] = {
		Name = "Lungs",
		Description ="Enhances your running speed.",
	};
	[3] = {
		Name = "Job",
		Description ="Increases your payday.",
	};
	[4] = {
		Name = "Hardiness",
		Description ="Reduces damage taken by weapons.",
	};
	[5] = {
		Name = "Lockpicking",
		Description ="Increases your chance of a successful pick.",
	};
	[6] = {
		Name = "Pistol",
		Description ="Increases your damage done with pistols.",
	};
	[7] = {
		Name = "Submachine Gun",
		Description ="Increases your damage done with submachine gun.",
	};
	[8] = {
		Name = "Shotgun",
		Description ="Increases your damage done with shotgun.",
	};
	[9] = {
		Name = "Rifle",
		Description ="Increases your damage done with rifle.",
	};
	[10] = {
		Name = "Sniper",
		Description ="Increases your damage done with sniper.",
	};
	[11] = {
		Name = "Manufacturing",
		Description ="Increases the amount of items you manufacture at any one time.",
	};
	[12] = {
		Name = "Crafting",
		Description ="Allows for crafting of certain special recipes.",
	};
	[13] = {
		Name = "Robbing",
		Description ="Increases the gain from a store robbery.",
	};
	[14] = {
		Name = "Bartering",
		Description ="Increases item value when trading NPCs.",
	};
	[15] = {
		Name = "Unarmed Combat",
		Description ="Enhances the damage you do to people with melee weapons or fists.",
	};
	[16] = {
		Name = "Mining",
		Description ="Allows for more yield when gathering with a pickaxe.",
	};
	[17] = {
		Name = "Digging",
		Description ="Allows for more yield when gathering with a shovel.",
	};
	[18] = {
		Name = "Logging",
		Description ="Allows for more yield when gathering with a axe.",
	};
	[19] = {
		Name = "Organization",
		Description ="Decreases the organization boost cost.",
	};
};

local _plyMeta = FindMetaTable("Player")
local _pMeta = FindMetaTable("Player")

function _plyMeta:GetRotoLevelData()
	return util.JSONToTable(self:getFlag("rotoleveldata",""))
end
function _plyMeta:GetRotoLevel(PerkTree)

	local _leveldata = self:GetRotoLevelData();

	if _leveldata && _leveldata[PerkTree] then
		return _leveldata[PerkTree]
	end

	return nil
end

function _plyMeta:SetRotoLevel(PerkTree,Level)

	local _leveldata = self:GetRotoLevelData();

	if _leveldata then
		
		if !_leveldata[PerkTree] then
			
			_leveldata[PerkTree] = {1,0,os.time()};

		end

		_leveldata[PerkTree][1] = Level
		_leveldata[PerkTree][2] = 0
		self:setFlag("rotoleveldata",util.TableToJSON(_leveldata))
		self:SavePermanentData( _leveldata , "proficiency" )

		return true;
	end

	return false;

end

function _plyMeta:AddRotoXP(PerkTree,AddXP,dontsv)

	if self.__Loaded and self.__Loaded == false then return end
	
	local _leveldata = self:GetRotoLevelData();

	if !_leveldata then
		_leveldata = {};
	end

	if _leveldata then
		
		if _leveldata[PerkTree] == nil then
			
			_leveldata[PerkTree] = {1,0,os.time()};

		end

		local _lv = _leveldata[PerkTree][1];
		local _xp = _leveldata[PerkTree][2];
		local _requirement = RotoLevelSystem.config.InitialXPReq + (RotoLevelSystem.config.AdditionalXPPerLevel * _lv);
		local _xptoadd = AddXP;
		local _levelup = false;
		
		if _xp+_xptoadd >= _requirement then

			//while(self:GetRotoLevelData()[PerkTree][2]+_xptoadd>=_requirement) do

			_levelup = true;

			_leveldata[PerkTree][1] = _leveldata[PerkTree][1] +1;
			_leveldata[PerkTree][2] = 0;
			
			//end

		elseif _xp+_xptoadd < _requirement then 

			_leveldata[PerkTree][2] = _xp+_xptoadd;

		end
		self:setFlag("rotoleveldata",util.TableToJSON(_leveldata))
		if _levelup == true then
			local _runSpeed,_walkSpeed = self:FindMovementSpeed();
			self:SetRunSpeed(_runSpeed)
			self:SetWalkSpeed(_walkSpeed)
		end
		
		self:SavePermanentData( util.TableToJSON(_leveldata) , "proficiency" )
		
		
		return true;
	end

	return false;
end 

if SERVER then
	/*
	hook.Add("Think","GetClientMovement",function(_p)
		if _LastCheck+1 < CurTime() then
			for k , _p in pairs(player.GetAll()) do
				if _p.__Loaded && _p.__Loaded == true and !_p:InVehicle() && _p:OnGround() && _p:GetVelocity():Length() > 0 then
					local _level = 1
					if _p:GetRotoLevel(1) then
						_level = _p:GetRotoLevel(1)[1]
					end
					
					local _val = (RotoLevelSystem.config.RewardXP+(math.min(5000,RotoLevelSystem.config.RewardXPPerLevel*_level)))/50;
					if _p:KeyDown(IN_SPEED) then
						_p:AddRotoXP(2,_val/2);
						_val = _val*2;
					end
					
					_p:AddRotoXP(1,_val);
					
				end			
			end
			_LastCheck = CurTime();
		end
	end)
	*/


	hook.Add("PaydayDistribution","JobXPForPayday",function()

		for k , _p in pairs(player.GetAll()) do

			if _p.__Loaded && _p.__Loaded == true and  _p:Team() != TEAM_CIVILLIAN or _p:Team() != TEAM_UNCONNECTED then
				
				local _level = 1
				if _p:GetRotoLevel(1) then
					_level = _p:GetRotoLevel(1)[1]
				end
				_p:AddRotoXP(3, (RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel*_level)/25));

				if _p:getFlag("organization","") != "" and _p:Team() == TEAM_CIVILLIAN then
					_p:AddRotoXP(19,RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel*_level));
				end

				_p:AddRotoXP(1,RotoLevelSystem.config.RewardXP+(math.min(5000,RotoLevelSystem.config.RewardXPPerLevel*_level)));
			end


		end
	end)

end


function _plyMeta:LoadRotoXP()
	local _data = self:GetPermanentData( "proficiency" );

	if _data && _data != nil then
		
		self:setFlag("rotoleveldata",_data);

	end
end

if SERVER then
	hook.Add("InitializePermanentData","DoProficiencyLoad",function(_p,_data)
		if _p then
			_p:LoadRotoXP();
		end
	end)
end

RotoLevelSystem.skill = {};
/*/ Meta Stuff for acessors \*/
RotoLevelSystem.skill.Endurance = RotoLevelSystem.config.PerkTrees[1];
function _pMeta:GetEnduranceProf()
	return self:GetRotoLevel(1)
end
RotoLevelSystem.skill.Lungs = RotoLevelSystem.config.PerkTrees[2];
function _pMeta:GetLungProf()
	return self:GetRotoLevel(2)
end
RotoLevelSystem.skill.Job = RotoLevelSystem.config.PerkTrees[3];
function _pMeta:GetJobProf()
	return self:GetRotoLevel(3)
end
RotoLevelSystem.skill.Hardiness = RotoLevelSystem.config.PerkTrees[4];
function _pMeta:GetHardinessProf()
	return self:GetRotoLevel(4)
end
RotoLevelSystem.skill.Lockpicking = RotoLevelSystem.config.PerkTrees[5];
function _pMeta:GetLockpickingProf()
	return self:GetRotoLevel(5)
end
RotoLevelSystem.skill.Pistol = RotoLevelSystem.config.PerkTrees[6];
function _pMeta:GetPistolProf()
	return self:GetRotoLevel(6)
end
RotoLevelSystem.skill.SubmachineGun = RotoLevelSystem.config.PerkTrees[7];
function _pMeta:GetSubmachineGunProf()
	return self:GetRotoLevel(7)
end
RotoLevelSystem.skill.Shotgun = RotoLevelSystem.config.PerkTrees[8];
function _pMeta:GetShogunProf()
	return self:GetRotoLevel(8)
end
RotoLevelSystem.skill.Rifle = RotoLevelSystem.config.PerkTrees[9];
function _pMeta:GetRifleProf()
	return self:GetRotoLevel(9)
end
RotoLevelSystem.skill.Sniper = RotoLevelSystem.config.PerkTrees[10];
function _pMeta:GetSniperProf()
	return self:GetRotoLevel(10)
end
RotoLevelSystem.skill.Manufacturing = RotoLevelSystem.config.PerkTrees[11];
function _pMeta:GetManufacturingProf()
	return self:GetRotoLevel(11)
end
RotoLevelSystem.skill.Crafting = RotoLevelSystem.config.PerkTrees[12];
function _pMeta:GetCraftingProf()
	return self:GetRotoLevel(12)
end
RotoLevelSystem.skill.Walking = RotoLevelSystem.config.PerkTrees[13];
function _pMeta:GetWalkingProf()
	return self:GetRotoLevel(13)
end
RotoLevelSystem.skill.Running = RotoLevelSystem.config.PerkTrees[14];
function _pMeta:GetRunningProf()
	return self:GetRotoLevel(14)
end
RotoLevelSystem.skill.Robbing = RotoLevelSystem.config.PerkTrees[15];
function _pMeta:GetRobbingProf()
	return self:GetRotoLevel(15)
end
RotoLevelSystem.skill.Bartering = RotoLevelSystem.config.PerkTrees[16];
function _pMeta:GetBarteringProf()
	return self:GetRotoLevel(16)
end
RotoLevelSystem.skill.UnarmedCombat = RotoLevelSystem.config.PerkTrees[17];
function _pMeta:GetUnarmedProfProf()
	return self:GetRotoLevel(17)
end
RotoLevelSystem.skill.Mining = RotoLevelSystem.config.PerkTrees[18];
function _pMeta:GetMiningProf()
	return self:GetRotoLevel(18)
end
RotoLevelSystem.skill.Digging = RotoLevelSystem.config.PerkTrees[19];
function _pMeta:GetDiggingProf()
	return self:GetRotoLevel(19)
end
RotoLevelSystem.skill.Logging = RotoLevelSystem.config.PerkTrees[20];
function _pMeta:GetLoggingProf()
	return self:GetRotoLevel(20)
end