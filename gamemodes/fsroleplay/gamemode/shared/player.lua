fsrp = fsrp || {}

fsrp.devprint("[560Roleplay] - Loading Player Shared File" )

local _pMeta = FindMetaTable( "Player" )

function _pMeta:getRPName()

	
	return self.__firstName .. " " .. self.__LastName || "John Doe";
	

end

function _pMeta:IsGovernmentOfficial()

	return table.HasValue( {TEAM_MAYOR, TEAM_POLICE, TEAM_PARAMEDIC } , self:Team() )
	
end
function _pMeta:getFirstName()

	return self.__firstName || "John";
	

end
function _pMeta:getLastName()

	return self.__LastName || "Doe";
	

end


function _pMeta:setFirstName( str )

	if str == nil || str == "" then
		str = "John"
	end
	self.__firstName = str;
	
	if SERVER then
	
		fsrp.UpdateClientFirstName( self , self.__firstName )
		
	end

end

function _pMeta:setLastName( str )

	if str == nil || str == "" then
		str = "Doe"
	end
	self.__LastName = str;
	
	if SERVER then
	
		fsrp.UpdateClientLastName( self , self.__LastName )
		
	end

end

function _pMeta:setClientGender( int )
	if SERVER && (int != 1 && int != 2) then return LoadPlayer( self ) end

	self.__mSex = int;
	
	if SERVER then
		print( self )
		print( int )
		fsrp.UpdateClientGender( self , int )
	
	end
	
end

function _pMeta:getGender()

	return self.__mSex;
	
end

function _pMeta:getClothes()

	return self.__mClothes;
	
end

function _pMeta:Notify( str )
	if !self or !self:IsValid() then return false; end
	if !str then return end
	if SERVER then
		net.Start("fsrp.notify")
		net.WriteString( str )
		net.Send( self )
	else
		
		AddNotify(str, NOTIFY_GENERIC, 10, false);
	
	end
	
end

function _pMeta:getMoney()

	return self.__Money || 0;

end

function _pMeta:getBank( )

	return self.__Bank || 0;

end

function _pMeta:setBank( int )
	int = math.ceil(int);
	self.__Bank = int || 5000;
	
	if SERVER then
	
		fsrp.UpdateClientBank( self , self.__Bank )
	
	end
	
end

function _pMeta:canAffordBank( int )

	if self.__Bank >= int then
	
		return true;
		
	else
	
		return false;
		
	end

end

function _pMeta:addBank( int )

	self.__Bank = self.__Bank + int;
	
	if self.__Bank <= 0 then
	
		self.__Bank = 0;
		
	end
	if SERVER then
	
		fsrp.UpdateClientBank( self , self.__Bank )
	
	end
	
end

function _pMeta:BankToMoney( int )
	local _act = self:getBankAccount() || 0;
	local _interest = 0;
	
	if _act == 0 then
		return self:Notify("You need to create a bank account to make transactions!");
	elseif _act == 1 then
		_interest = 0.25
	elseif _act == 2 then
		_interest = 0.05
	elseif _act == 3 then
		_interest = 0.1
	end
	//print( int * 0.01)
	if (self:canAffordBank( (int - (int* _interest) ))) then
		self:Notify("You have withdrawn $" .. math.ceil(int) .. " from your bank account.")
		int = int + (int * _interest)
		
		self:Notify("(You paid $".. (int*_interest) .. " on top as interest of the withdrawal.)")
		self:addBank( -int )
		self:addMoney( int - (int * _interest) )
	else
		self:Notify("You do not have enough money for this transfer.")
		print( "Tried to add to:" .. self:Nick() )
		print ( "Amount: " .. int .. " ( ".. int*_interest .. " )")
	end

	if SERVER then
	
		fsrp.UpdateClientMoney( self , self.__Money )
		fsrp.UpdateClientBank( self , self.__Bank )
		
	end
end

function _pMeta:MoneyToBank( int )

	if self:canAfford( int ) then
	
		self:addMoney( -int )
		self:addBank( int )
		
	end

end

function _pMeta:setMoney( int )

	self.__Money = int || 15000;
	
	if SERVER then
		
		fsrp.UpdateClientMoney( self , math.ceil(self.__Money) )
	
	end

end

function _pMeta:canAfford( int )

	if self:getMoney() >= int then
	
		return true
		
	else
	
		return false
		
	end

end

function _pMeta:addMoney( int )
	if !int || int == 0 then return print("Couldn't add " .. int .. " to " .. self:Nick() ) end 
	
	self.__Money = self:getMoney() + int;
	
	if self.__Money <= 0 then
	
		self.__Money = 0;
		
	end
	
	if SERVER then
	
		fsrp.UpdateClientMoney( self , math.ceil(self.__Money) )
	
	end
	
end

function _pMeta:getLevel()

	return self.__Level;

end

function _pMeta:setLevel( int )

	self.__Level = int;
	
	if SERVER then
		
		fsrp.UpdateClientLevel( self , self.__Level )
		
	end
	
end

function _pMeta:getBankAccount()

	return self.__BankAccountLevel || 0;
	
end

function _pMeta:setBankAccount( int )
	
	self.__BankAccountLevel = int;
	
	if SERVER then
	
		fsrp.UpdateClientBankAccountLevel( self , self.__BankAccountLevel )
		
	end
	
end

function _pMeta:Equip()
	if CLIENT then return end
	
	local _t = self:Team();
	
	if _t == TEAM_CIVILLIAN then

		_p:Give("weapon_physcannon")
		
	end

end

if SERVER then

	fsrp.devprint("[560Roleplay] - Fetched Shared Player Metatables" )
	
	function fsrp.UpdateClientFirstName( v , _name )
		if !IsValid( v ) then return end
	
		net.Start( "fsrp.networkClientFirstName" )
			net.WriteString( _name )
		net.Send( v )
		
	end
	
	function fsrp.UpdateClientLastName( v , _name )
		if !IsValid( v ) then return end
	
		net.Start( "fsrp.networkClientLastName" )
			net.WriteString( _name )
		net.Send( v )
		
	end
	
	function fsrp.UpdateClientMoney( v , _money )
		if !IsValid( v ) || !_money then return end
		
		//print( _money )
		net.Start( "fsrp.networkClientMoney" )
			net.WriteInt( _money , 32 );
		net.Send( v )
		
	end
	
	function fsrp.UpdateClientBank( v , _money )
		if !IsValid( v ) || !_money then return end
		//print( _money )

		net.Start( "fsrp.networkClientBank" )
			net.WriteInt( _money,32  );
		net.Send( v )
		
	end
	
	function fsrp.UpdateClientBankAccountLevel( v , int )
		if !IsValid( v ) then return end
		

		net.Start( "fsrp.networkClientBankLV" )
			net.WriteFloat( int );
		net.Send( v )
		
	end
	
	function fsrp.UpdateClientLevel( v , _level )
		if !IsValid( v ) then return end
	
		net.Start( "fsrp.networkClientLevel" )
			net.WriteInt( _level, 6 )
		net.Send( v )
		
	end
	
	function fsrp.UpdateClientShares( v , num, int, lv, xp )
		if !IsValid( v ) then return end
	
		net.Start( "fsrp.networkClientShares" )
			net.WriteFloat( num, 8 )
			net.WriteFloat( int, 32 )
			net.WriteInt( lv, 3 )
			net.WriteInt( xp, 32 )
		net.Send( v )
		
	end
	
	function fsrp.UpdateClientGender( v , _i )
		if !IsValid( v ) then return end
		local _b;
		if _i == 1 then
		
			_b = true
			
		elseif _i == 2 then
		
			_b = false;
			
		end
		
		net.Start( "networkClientSex" )
			net.WriteBool( _b )
		net.Send( v )
	end
	
	
	fsrp.devprint("[560Roleplay] - Fetched Shared Networking" )
end

if CLIENT then

	net.Receive( "fsrp.startUser" , function ( len , _p )
		
		fsrp.vgui_createPlayer( );
		
		 
	end ) 

	net.Receive( "fsrp.networkClientShares" , function ( len , _p )
		
		if !LocalPlayer().__BuisinessTable then
			LocalPlayer().__BuisinessTable = {};
		end
		
		num = net.ReadFloat()
		
		int = net.ReadFloat()
		
		level = net.ReadInt( 3 )
		xp = net.ReadInt( 32 )
		
		for k , v in pairs( BUISINESS_TABLE ) do
		
			if v.ID == num then
			
				LocalPlayer().__BuisinessTable[num] 				= {}
				LocalPlayer().__BuisinessTable[num].id 				= num
				LocalPlayer().__BuisinessTable[num].shares = int;
				LocalPlayer().__BuisinessTable[num].level = level;
				LocalPlayer().__BuisinessTable[num].xp = xp;
				
			end
			
		end

	end )
	net.Receive( "networkClientSex" , function ( len , _p )
		local _b = net.ReadBool()
		local _n;
		
		if _b then
		
			_n = 1
			
		elseif !_b then 
		
			_n = 2
			
		end
		
		LocalPlayer():setClientGender( _n );
		print(LocalPlayer( ).__mSex)
	
	end )

	net.Receive( "fsrp.networkClientFirstName" , function ( len , _p )

		LocalPlayer( ):setFirstName( net.ReadString( ) );

	end )

	net.Receive( "fsrp.networkClientLastName" , function ( len , _p )

		LocalPlayer( ):setLastName( net.ReadString( ) );

	end )

	net.Receive( "fsrp.networkClientLevel" , function ( len , _p )

		LocalPlayer( ):setLevel( net.ReadInt( ) );

	end )

	net.Receive( "fsrp.networkClientBankLV" , function ( len , _p )
		local int = net.ReadFloat( );
		
		LocalPlayer( ):setBankAccount( int );

	end )

	net.Receive( "fsrp.networkClientBank" , function ( len , _p )
		local _p = LocalPlayer()		
		
		_p:setBank( net.ReadInt(32)  );

	end )

	net.Receive( "fsrp.networkClientMoney" , function ( len , _p )
		local _p = LocalPlayer()
		_p:setMoney( net.ReadInt(32 )  );

	end )

end

fsrp.devprint("[560Roleplay] - Fetched Player Shared Files" )