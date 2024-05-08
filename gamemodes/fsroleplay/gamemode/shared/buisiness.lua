
fsrp = fsrp || {}

BUISINESS_TABLE = BUISINESS_TABLE or {}

function fsrp.SetupBuisiness ( BuisinessTable )
	BUISINESS_TABLE[BuisinessTable.ID] = BuisinessTable;
	print("\t-> Loaded " .. BuisinessTable.Name .. ", [ID: " .. BuisinessTable.ID .. "]");

end

function getBuisinessInfo( id )

	for k , v in pairs( BUISINESS_TABLE ) do
	
		if v.ID == id then

			return BUISINESS_TABLE[id];
		
		end
		
	end
	
end

local _pMeta = FindMetaTable( "Player" )


function _pMeta:setShares( num, int, lv, xp )

	for k , v in pairs( BUISINESS_TABLE ) do
	
		if v.ID == num then
			//print( num )
			if !self.__BuisinessTable then
				self.__BuisinessTable = {};
			end
			self.__BuisinessTable[num]				= {};
			self.__BuisinessTable[num].id 				= v.ID
			self.__BuisinessTable[num].shares = int;
			self.__BuisinessTable[num].level = lv;
			self.__BuisinessTable[num].xp = xp;
			
			
			if SERVER then 
					
				fsrp.UpdateClientShares( self, self.__BuisinessTable[num].id , self.__BuisinessTable[num].shares, self.__BuisinessTable[num].level,  self.__BuisinessTable[num].xp)
			
			end
		end
		
	end
	
end


function _pMeta:getShares( num )
	if !self.__BuisinessTable || !self.__BuisinessTable[num] then return {shares = 0, id = 0}; end
	local oldTable = self.__BuisinessTable
	local newTable = {};
	for k , v in pairs( BUISINESS_TABLE ) do
	
		if v.ID == num && oldTable[num].id then
			
			newTable.id = oldTable[num].id
			newTable.shares = oldTable[num].shares
			newTable.value = oldTable[num].shares * v.Price;
			newTable.level = oldTable[num].level
			newTable.xp = oldTable[num].xp
			
			return newTable;
		
		end
		
	end
	
end

function _pMeta:BuisinessPayday()

	if !self.__BuisinessTable then return self:Notify("Because you do not own any buisiness shares, you have not gained any Buisiness Payday"); end
	
	local _accountLevel = self:getBankAccount();
	
	if _accountLevel == 3 then
		local totalgive = 0;
		
		for k , v in pairs( BUISINESS_TABLE ) do
			if !self.__BuisinessTable[v.ID] then return end
			if self.__BuisinessTable[v.ID].shares == 0 then return end
			if self.__BuisinessTable[v.ID].id == v.ID then
				if self:getBuisinessLevel( v.ID ) then 
				local _pshares = self.__BuisinessTable[v.ID].shares;
				local _calc =math.ceil(_pshares  *v.Payday *(self:getBuisinessLevel( v.ID )) )
				//print(_calc)
				self:addBank(_calc)
				totalgive = totalgive + _calc
				end
				
				
				if !self.__BuisinessTable[v.ID].level == 0 then return end
				if !v.XPTable[ tonumber(self.__BuisinessTable[v.ID].level) ] then return end
				if v.XPTable[ self.__BuisinessTable[v.ID].level ] >= self.__BuisinessTable[v.ID].xp then
					
					if (self.__BuisinessTable[v.ID].level + 1) <= BUISINESS_LEVEL_CAP && self.__BuisinessTable[v.ID].level > 0 then
					
						self:LvlUPBuisiness()
						
					end
					
				end
				
				if self.__BuisinessTable[v.ID].level >= 1 || self.__BuisinessTable[v.ID].level <= BUISINESS_LEVEL_CAP then
				
					//self:addBuisinessXP( v.ID , (v.PaydayXP * self.__BuisinessTable[v.ID].level) );
					self:setBuisinessXP( v.ID , (self:getBuisinessXP(v.ID) +v.PaydayXP * self.__BuisinessTable[v.ID].level)) 
					
				end
					
					
			end
			
		end
						self:Notify("You have been paid $" .. (totalgive) .. " for your Buisiness shares.")

	end
	
end

function _pMeta:addShares( num, int )
	
	
	local _shr = self:getShares( num ) || {};
			
	if !self.__BuisinessTable || !self.__BuisinessTable[num] then return end
	
	
	self.__BuisinessTable[num].shares = (_shr.shares + int);
	
	if SERVER then 
					
		fsrp.UpdateClientShares( self, num, int, self.__BuisinessTable[num].level,self.__BuisinessTable[num].xp  )
						
	end	
	
end

function _pMeta:LvlUPBuisiness( id )

	for k , v in pairs( BUISINESS_TABLE ) do
	
		if v.ID == id && self.__BuisinessTable[id].id == id then
		
			self:Notify( v.LevelUpString[ self.__BuisinessTable[id].level ] )
			self.__BuisinessTable[id].level = self.__BuisinessTable[id].level + 1
			self.__BuisinessTable[id].xp = 0;
			
			if SERVER then
				fsrp.UpdateClientShares( self, id,  self.__BuisinessTable[id].shares, self.__BuisinessTable[id].level,self.__BuisinessTable[id].xp  )
			end
			
		end
		
	end
	
end
		

function _pMeta:buyStock( num, amt )

	if !self then return end
	if !self:Alive() then 
		
		return self:Notify( "You can not buy stock while unconcious" ); 
		
	end
	
	if self:getBankAccount() != 3 then return self:Notify("You need to get a buisiness banking account before you can buy stock!"); end
	for k , v in pairs( BUISINESS_TABLE ) do
		
		if v.ID == num then
			if BUISINESS_TABLE[num].CanBuy( self, amt) then
				
			
				local _total = v.Price * amt;
				
				self:Notify( "You have been deducted $" .. _total .. " for buying x" .. amt .. " " .. v.Name .. " stock shares!" )
			
				self:addMoney( -_total )
				BUISINESS_TABLE[num].OnBought( self  )
				self:addShares( num , amt )
				BUISINESS_TABLE[num].PostCanBuy( self , true )
			else
			
				BUISINESS_TABLE[num].PostCanBuy( _p , false )
				
				
			end
		end
		
		
	end
	
end

function _pMeta:getAllBuisinesses()

	return self.__BuisinessTable;
	
end

local function initBuisinessFolder(  )
	local _filename = "buisiness/";

	// Create folder if it doesn't exist.
	local _folder = string.lower( ( GM or GAMEMODE ).Name ) .. _filename;
	if ( !file.Exists( _folder .. _filename, "DATA" ) ) then
		file.CreateDir( _folder );
	end

	return _folder;
end

function string.safe( text )
	text = string.gsub( text, "%W", "_" );
	return text;
end

function _pMeta:getBuisinessLevel( int )

	return self.__BuisinessTable[int].level || 1;

end

function _pMeta:getBuisinessXP( int )

	return self.__BuisinessTable[int].xp || 0;
	
end

function _pMeta:addBuisinessXP( int, xp )
	
	if !self.__BuisinessTable[int] && !self.__BuisinessTable[int].level || !self.__BuisinessTable[int].xp then 
	
		return print("[560Roleplay] Couldn't apply Buisiness XP to ".. self:Nick())
		
	else

		self.__BuisinessTable[int].xp 	= self.__BuisinessTable[int].xp + xp;
	
	end
	
	if SERVER then
	
		self:setShares( self.__BuisinessTable[int].ID, self.__BuisinessTable[int].shares, self.__BuisinessTable[int].level ,self.__BuisinessTable[int].xp )
	
	end
	
end

function _pMeta:setBuisinessXP( int , xp )

	if !self.__BuisinessTable[int] && !self.__BuisinessTable[int].level && !self.__BuisinessTable[int].xp then 
	
		return print("[560Roleplay] Couldn't apply Buisiness XP to ".. self:Nick())
		
	else
	
		self.__BuisinessTable[int].xp 	= xp;
	
	end
	
	if SERVER then
	
		self:setShares( self.__BuisinessTable[int].ID, self.__BuisinessTable[int].shares, self.__BuisinessTable[int].level ,self.__BuisinessTable[int].xp )
	
	end
	
end

function _pMeta:setBuisinessLevel( int , lv )

	if !self.__BuisinessTable[int] then
		
		self.__BuisinessTable[int] = {}
		self.__BuisinessTable[int].level 	= lv;
		self.__BuisinessTable[int].xp 	= 0;
	
	else
	
		self.__BuisinessTable[int].level 	= lv;
		self.__BuisinessTable[int].xp 	= 0;
	
	end
	
	if SERVER then
	
		self:setShares( self.__BuisinessTable[int].ID, self.__BuisinessTable[int].shares, self.__BuisinessTable[int].level ,self.__BuisinessTable[int].xp )
	
	end
	
end

if SERVER then
	
	function saveBuisinesses( _p )

		local _pBsnTbl = _p.__BuisinessTable
		
		if !_pBsnTbl then return end;
		for k , v in pairs( BUISINESS_TABLE ) do 
		
			if _pBsnTbl[k] then
				local _folder = initBuisinessFolder(  );

				file.Write( _folder .. string.safe( _p:SteamID( ) ) .. ".txt", util.TableToJSON(_pBsnTbl), "DATA" );
				//print(file.Write( _folder .. string.safe( _p:SteamID( ) ) .. ".txt", util.TableToJSON(_pBsnTbl), "DATA" ));
				loadBuisinesses(_p)
			end
			
		end
		
	end

	function loadBuisinesses( _p )
		
		if !IsValid( _p ) then return end;
		
			
		local _folder = initBuisinessFolder(  );
		local _tbl = file.Read( _folder .. string.safe( _p:SteamID( ) ) .. ".txt" ) 
		//print( _tbl )
		if _tbl then
		
		_p.__BuisinessTable = util.JSONToTable( _tbl ) || {};
		//PrintTable( _p.__BuisinessTable );
		
		for k , v in pairs(BUISINESS_TABLE) do
			if !_p.__BuisinessTable[k] then return end
			if v.ID == _p.__BuisinessTable[k].id then
				id = v.ID
				_p:setShares( id , _p.__BuisinessTable[id].shares, _p:getBuisinessLevel(v.ID ),_p.__BuisinessTable[id].xp )

			end
			
		end
			--net.Start("fsdb.setupClientBuisinessData")
				--net.WriteFloat( _p.__BuisinessTable[id].id , 8 )
				--net.WriteFloat( _p.__BuisinessTable[id].shares, 32 );
			--net.Send( _p )
		else
			setupClientBuisinessData( _p )
			
		end
		 
	end

	function setupClientBuisinessData( _p )
		_p.__BuisinessTable = {};	
		for k , v in pairs( BUISINESS_TABLE ) do 
			
			_p:setShares( k , 0, 1 , 0);
			
		end
		
		saveBuisinesses( _p )
			
		loadBuisinesses( _p )
	end
	
end	