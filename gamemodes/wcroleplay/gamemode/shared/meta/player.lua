fsrp = fsrp || {}

fsrp.devprint("[WC-RP] - Loading Player Shared File" )

local _pMeta = FindMetaTable( "Player" )

function _pMeta:getRPName()
	if !IsValid(self) then return end
	
	return self:getFirstName() .. " " .. self:getLastName();
	
end

function _pMeta:AddClientBuddy ( uniqueID )
	if !IsValid(self) then return end
	if !uniqueID then return end;
	if self.__Buddies[tostring(uniqueID)] then return self:Notify("This person is a buddy already!") end
	
	table.insert(self.__Buddies, tostring(uniqueID) );
	
	self:setFlag( "buddies", self.__Buddies, true )
	
end
 
function _pMeta:RemoveClientBuddy( uniqueID )
	if !IsValid(self) then return end
	if !uniqueID then return end;
	
	for k, v in pairs(self.__Buddies ) do
		if (v == tostring(uniqueID)) then
			self.__Buddies[k] = nil; 
		end
	end
	
	self:setFlag( "buddies", self.__Buddies, true )
	
end

function _pMeta:HasBuddy ( otherPlayer )
	if !IsValid(self) then return end
	if (self == otherPlayer) then return true; end

	local _org1 = self:getFlag("organization",nil)
	local _org2 = otherPlayer:getFlag("organization",nil)

	for k, v in pairs(self.__Buddies) do
		if (v[2] && v[2] == tostring(otherPlayer:UniqueID())) then
			return true;
		end
	end

	if _org1 != nil && _org2 != nil && _org1 != 0 && _org2 != 0 then

		if tonumber(_org1) == tonumber(_org2) then

			return true

		end
		
	end
	
	return false;
end

function _pMeta:IsGovernmentOfficial() 

	if !IsValid(self) then return end
	return table.HasValue( {TEAM_MAYOR, TEAM_POLICE, TEAM_PARAMEDIC } , self:Team() )
	
end
function _pMeta:IsPolice() 

	if !IsValid(self) then return end
	return table.HasValue( {TEAM_SWAT, TEAM_POLICE } , self:Team() )
	
end
function _pMeta:getFirstName()
	if !IsValid(self) then return end

	return self:getFlag( "firstname", "John" );
	

end
function _pMeta:getLastName()
	if !IsValid(self) then return end

	return self:getFlag( "lastname", "Doe" );
	

end


function _pMeta:setFirstName( str )
	if !IsValid(self) then return end

	self:setFlag( "firstname" , str  )

end

function _pMeta:setLastName( str )
	if !IsValid(self) then return end


	self:setFlag( "lastname" , str  )

end

function _pMeta:setClientGender( int )
	if !IsValid(self) then return end

	self:setFlag( "gender" , int  )
	
end

function _pMeta:getGender()
	if !IsValid(self) then return end
	
	if self:Team() == TEAM_CIVILLIAN then
	
		local model = self:GetModel()
		local foundone = false
		for k , v in pairs( mdlTable[1] ) do
		
			if v.path == model then
			
				return 1
				
			end
			
		end
		
		for k , v in pairs( mdlTable[2] ) do
		
			if v.path == model then
			
				return 2;
				
			end
			
		end

	end
	
	return tonumber( self:getFlag( "gender" , 1 ))
end


function _pMeta:getClothes()
	if !IsValid(self) then return end

	return self.__mClothes;
	
end

function _pMeta:Notify( str )
	if !IsValid(self) then return end
	if !self or !self:IsValid() then return false; end
	if !str then return end
	if SERVER then
		net.Start("fsrp.notify")
		net.WriteString( tostring(str) )
		net.Send( self )
	else
		
		AddNotify(str, NOTIFY_GENERIC, 10, false);
	
	end
	
end

function _pMeta:getMoney()
	if !IsValid(self) then return end

	return self:getFlag( "money" , 0  ) || 0;

end

function _pMeta:getBank( )
	if !IsValid(self) then return end

	return self:getFlag( "bankmoney" , 0 )

end

if SERVER then
	
	util.AddNetworkString("bankMoneyNW")

	util.AddNetworkString("RefreshClientHUD");
end

if CLIENT then
	net.Receive("RefreshClientHUD", function()
		UpdateMoneyShow()
	end)
end

function _pMeta:setBank( int )
	if !IsValid(self) then return end
	int = math.Round(int,2);
	self:setFlag( "bankmoney" , int  )
	
	if SERVER then
		net.Start("bankMoneyNW")
			net.WriteInt( self:getBank() , 32 )	
		net.Send(self)
	end
	
end

if CLIENT then
	
	net.Receive("bankMoneyNW", function( _l, _p )
		local _am = net.ReadInt(32)

		LocalPlayer():setBank( _am )

	end )

end

function _pMeta:canAffordBank( int )
	if !IsValid(self) then return end

	if self:getBank() >= int then
	
		return true;
		
	else
	
		return false;
		
	end

end

function _pMeta:addBank( int )
	if !IsValid(self) then return end
	if CLIENT then UpdateMoneyShow() end
	self:setFlag( "bankmoney" , math.Clamp(self:getBank() + int,0, 2^32)  )
	
	if SERVER then
		net.Start("RefreshClientHUD")
		net.Send(self)
	end
	
	
end

	local _interest = {
		[0]= {0.25,0.25};
		[1] = {0.25,0.1};
		[2] = {0.05,0.25};
		[3] = {0.1, 0.1};
	};


function _pMeta:BankToMoney( int )
	if !IsValid(self) then return end
	local _act = self:getBankAccount() || 0;
	if _act == 0 then
		return self:Notify("You need to create a bank account to make transactions!");
	end
	
	local _interestPerc = _interest[_act][2];
	//print( int * 0.01)
	if (self:canAffordBank( (int))) then
		self:Notify("You have withdrawn $" .. math.ceil(int) .. " from your bank account.")
		int = int + (int * _interestPerc)
		
		self:Notify("(You paid $".. (int*_interestPerc) .. " on top as interest of the withdrawal.)")
		self:addBank( -int )
		self:addMoney( int - (int * _interestPerc) )
	else
		self:Notify("You do not have enough money for this transfer.")
	
	end

end

function _pMeta:MoneyToBank( int )
	if !IsValid(self) then return end
	if !self:getBankAccount() then return end
	
	if self:canAfford( (int) ) then
	
		self:addMoney( -(int) )
		self:addBank( (int-(int*_interest[self:getBankAccount()][1] )) )
		
	end

end
function _pMeta:setMoney( int )
	if !IsValid(self) then return end

	self:setFlag( "money", int )
	

end

function _pMeta:canAfford( int )
	if !IsValid(self) then return end

	if self:getMoney() >= int then
	
		return true
		
	else
	
		return false
		
	end

end

function _pMeta:addMoney( int )
	if !IsValid(self) then return end
	if !int || int == 0 then return print("Couldn't add " .. int .. " to " .. self:Nick() ) end 
	if CLIENT then UpdateMoneyShow() end
	
	self:setFlag("money", math.Clamp(self:getMoney() + int,0,2^32)  )
	
	if SERVER then
		net.Start("RefreshClientHUD")
		net.Send(self)
	end
	
end

function _pMeta:getLevel()
	if !IsValid(self) then return end

	return self:getFlag("level", 1 );

end

function _pMeta:setLevel( int )
	if !IsValid(self) then return end

	self:setFlag( "level" , int  );
	
end

function _pMeta:getBankAccount()
	if !IsValid(self) then return end

	return self:getFlag("bankaccountlevel", 0);
	
end
/*
hook.Add("SoundPlay_Call", "SoundPlay_Call_Implementation", function(name, pos,lv, pitch, vol) 
	hook.Run( "DirSoundDisp_Call", pos )

end )
*/
hook.Add("EmitSound_Call", "EmitSound_Call_Implementation", function(_p, weapon, name) 
	if _p && IsValid(_p) then
		print(name)
		hook.Run( "DirSoundDisp_Call", _p:GetPos() )
			end
end )

if SERVER then
	
	util.AddNetworkString("SoundCall")

else
	local impacts = {};

	function draw.Circle( x, y, radius, seg )
		local cir = {}

		table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
		for i = 0, seg do
			local a = math.rad( ( i / seg ) * -360 )
			table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
		end

		local a = math.rad( 0 ) -- This is needed for non absolute segment counts
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

		surface.DrawPoly( cir )
	end

	function ClientSoundCall(_v)
		local _soundDir = _v:GetNormalized()
		local _playerDir = (LocalPlayer():GetPos()-_v):GetNormalized()
		//print("Sound Position: " .. tostring( _soundDir:Angle() ))
		//print("Player Position: " .. tostring(LocalPlayer():GetPos():GetNormalized():Angle()))
		//print("PlayerPos-SoundPos: " .. tostring(_playerDir:Angle()))
		local _angOfImpact = (_soundDir-_playerDir):GetNormalized():Angle();
		local _curTime = os.time()
		local _lowestTime = _curTime;
		local _lowestIndex = 0;
			//print(_angOfImpact)
		if #impacts >14 then
			for k , v in pairs( impacts) do
				if v[1] < _lowestTime then
					_lowestTime = v[1]
					_lowestIndex = k;
				end		
			end	

			impacts[_lowestIndex] =  { _curTime ,_angOfImpact,_v};
		else
		
			table.insert( impacts , {_curTime ,_angOfImpact,_v})

		end
		
	end
	local _ang =360
	hook.Add("HUDPaint", "ShowDirectionOfSound", function()
		/*
		for k , v in pairs( impacts  ) do 
			local TimeLeft = impacts[k][1] + 2 - os.time();
			Alpha = (255 / 5) * TimeLeft;
			surface.SetDrawColor( 255, 255, 255, Alpha )
			local _Pos = v[3]
			local _PosScreen = {0,0,false};
			cam.Start3D(_Pos)
			_PosScreen = _Pos:ToScreen();
			cam.End3D()
			local _YDir = _PosScreen.x-v[2].y;
			local _PDir = _PosScreen.y-v[2].p;
			draw.Circle( _PDir,_YDir ,50,  25 )

			//surface.DrawRect( ScrW()/2+ v[2].y , ScrH()/2+ v[2].p , 100, 100 )
		end
		*/

	end)

	net.Receive("SoundCall", function()
		local _v = net.ReadVector() || Vector(0,0,0);
		ClientSoundCall(_v)
	end)
end

hook.Add("DirSoundDisp_Call", "DirSound", function( pos )

	if CLIENT then
		
		// no client call
	else

		net.Start("SoundCall")
		net.WriteVector(pos)
		net.SendPAS(pos)

		// if were on the server tell everyone a sound happened there, but only if they are near
	end

end )