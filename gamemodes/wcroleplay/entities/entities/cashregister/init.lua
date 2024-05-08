AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString( "cashRegister" )
/*
fsrp.config.DefaultStallType = 'general';
fsrp.config.StallStartLevel = 1;
fsrp.config.StallTypes = {	
	['armor'] = "models/mosi/fallout4/workshop/vendor/armorstand0%d.mdl",
	['bar'] = "models/mosi/fallout4/workshop/vendor/barstand0%d.mdl",
	['clinic'] =  "models/mosi/fallout4/workshop/vendor/clinicstand0%d.mdl",
	['clothing'] = "models/mosi/fallout4/workshop/vendor/clothingstand0%d.mdl",
	['general'] = "models/mosi/fallout4/workshop/vendor/generalstand0%d.mdl",
	['weapon'] = "models/mosi/fallout4/workshop/vendor/weaponstand0%d.mdl",
};
*/
function ENT:Initialize()
	self:SetModel(string.format( fsrp.config.StallTypes[fsrp.config.DefaultStallType] , fsrp.config.StallStartLevel ) )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	local _itemTb = {};
	for i=1, (fsrp.config.ShopItemsPerColumn*fsrp.config.ShopItemColumns) do
		_itemTb[i] = false;
	end 

	self:setFlag("shopItems", _itemTb)
	self:setFlag("stallStatus", 0)//
	self:setFlag("stallType", fsrp.config.DefaultStallType )
	self:setFlag("stallLevel", fsrp.config.StallStartLevel )
	self:setFlag("stallMessage","")
	self.Entity:GetPhysicsObject():Wake();
end

function ENT:RefreshStallModel()
	local _type = self:getFlag("stallType", fsrp.config.DefaultStallType )
	local _currentLevel = self:getFlag("stallLevel", fsrp.config.StallStartLevel )
	local _isOpen = self:getFlag("stallStatus", 0);

	if _isOpen == 0 then

		self:SetModel(string.format( fsrp.config.StallTypes[_type] , _currentLevel ) );

	end
	
end

function ENT:SetStallProperties( level , type )
	local _typeToSet = type && type || self:getFlag("stallType", fsrp.config.DefaultStallType );
	local _levelToSet = math.min(3,level) || self:getFlag("stallLevel", fsrp.config.StallStartLevel );

	self:setFlag("stallType", fsrp.config.DefaultStallType )
	self:setFlag("stallLevel", fsrp.config.StallStartLevel )

	self:RefreshStallModel()
end

function ENT:AddStallItemFromPlayer( client )
	local _isOpen = self:getFlag("stallStatus", 0);

	if _isOpen then return client:Notify("You may not add an item to your stall while it's running shop!"); end
	

end
function ENT:KickManager(  )
	local _ownerID = self:getFlag("ownedBy", "");
	local _owner
	for k , v in pairs( player.GetAll() ) do
		if _ownerID == v:SteamID() then
			_owner = v;
		end
	end

	if _owner then
		local _p = _owner;
		local _ent = self;
		_p:UnLock()
		_p:GodDisable()
		_p:Freeze(false)
		

		
		local _stallIndex = _p:getFlag("occupyingStall", -1);

		if _stallIndex == -1 && _p.Stall then
			_p.Stall = nil
			return;
		end
		if !Entity(_stallIndex) then return _p:Notify("Couldn't find stall in question.") end
		
		local _ent = ents.GetByIndex(_stallIndex) || nil;

		if _ent && _ent:getFlag("ownedBy","") == _p:SteamID() then
			local _occupyingPlayers = {};
			for k , v in pairs( player.GetAll() ) do
				if v:getFlag("occupyingStall", -1) == _stallIndex then
					table.insert(_occupyingPlayers, v);
				end
			end
			net.Start("cashRegister")
				net.WriteInt(4,8)
			net.Send(_occupyingPlayers)

			_ent:setFlag("stallStatus",0);
			_ent:setFlag("stallLock",nil);
			_p.Stall = nil;

			local _entItems = _ent:getFlag("shopItems",{})

			if _entItems && istable(_entItems) then
				local _returned = 0;

				for k , v in pairs( _entItems ) do
					
					if v && v.ID then
					
						for i=1,v.Amount do
							_p:AddItemByID(v.ID);
							_returned = _returned + 1;
						end		

					end

				end
				_p:Notify("You have been forced out of your stall.")
				if _returned > 0 then
					_p:Notify("Your ".. _returned.. " items have been returned to you.")
				end
			end
			_ent:Remove();
		end
		_p:setFlag("occupyingStall", nil );

		return true
	end
end
hook.Add("Move", "FreezeStallPlayers", function(ply, mdata)
	if ply:getFlag("occupyingStall",nil) != nil then 
		return true
	end
end)

function ENT:SetStallManager( activator )

		// we send in 1 because its the owner
		local OurPosition = self:GetPos();
		local RelativeOffset = (self:GetAngles():Forward() * 32 );
		local EntAngles = OurPosition:Angle();
		local AcEyeAng = activator:GetPos():Angle();

		self:SetPos(OurPosition+RelativeOffset);

		
		local _lookat = (activator:EyePos() - self:GetPos() ):Angle()- Angle(0,180,0);
		//_lookat:RotateAroundAxis( self:GetAngles():Forward(), 180)

		activator:SetEyeAngles( Angle(_lookat.r,_lookat.y,_lookat.r) )
		self:setFlag("stallMessage" , activator:getFirstName() .. " is selling items at a discount!")
	
		activator:Notify("You have started your stall.")
		self:setFlag("ownedBy",activator:SteamID() )
		net.Start( "cashRegister" )
			net.WriteInt( 1, 8 )
			net.WriteInt( self:EntIndex(), 16 )
		net.Send( activator ) 
		activator:setFlag("occupyingStall", self:EntIndex() );
		activator:GodEnable();

end

function ENT:ReturnItemsFromStallToPlayer()

	local _owner = self:getFlag("ownedBy","");
	local _p;
	for k , v in pairs( player.GetAll() ) do
		
		if v:SteamID() == _owner then
			_p = v;

		end
	end

	if _p then
		


	end
end

function ENT:Use(activator,caller)
	if self.Entity:getFlag("useDelay", 0 ) and self.Entity:getFlag("useDelay", 0 ) > CurTime() then return false; end
		
	self.Entity:setFlag("useDelay", CurTime() + 1)
		
	if activator:KeyDown( IN_WALK ) then
			
		
		if activator:SteamID() != self:getFlag( "ownedBy" ,"" )  then return false; end

		activator:EmitSound("items/ammocrate_open.wav")
		activator:AddItemByID(158 )

		
		self:Remove();

		return

	end
	local _act = activator:setFlag("occupyingStall", nil);

	if _act then return activator:Notify("You are already occupying a stall!") end
	if self:getFlag("stallLock", false) == true then
		return activator:Notify("You can't go in a locked stall!")
	end
	activator:Freeze( true )
	activator:Lock()

	if self:getFlag("ownedBy", "") == activator:SteamID() then
		
	else
			// we send 0 because its the buyer
		net.Start( "cashRegister" )
			net.WriteInt( 0, 8 )
			net.WriteInt( self:EntIndex(), 16 )
		net.Send( activator ) 
		activator:setFlag("occupyingStall", self:EntIndex() );

	end

end


net.Receive("cashRegister", function(_l, _p )

	local _e = net.ReadInt(8);


	if _e == 0 then
		
		_p:UnLock()
		_p:GodDisable()
		_p:Freeze(false)
		
		local _stallIndex = _p:getFlag("occupyingStall", -1);

		if _stallIndex == -1 && _p.Stall then
			_p.Stall = nil
			return;
		end
		if !Entity(_stallIndex) then return _p:Notify("Couldn't find stall in question.") end
		
		local _ent = ents.GetByIndex(_stallIndex) || nil;

		if _ent && _ent:getFlag("ownedBy","") == _p:SteamID() then
			local _occupyingPlayers = {};
			for k , v in pairs( player.GetAll() ) do
				if v:getFlag("occupyingStall", -1) == _stallIndex then
					table.insert(_occupyingPlayers, v);
				end
			end
			net.Start("cashRegister")
				net.WriteInt(4,8)
			net.Send(_occupyingPlayers)

			_ent:setFlag("stallStatus",0);
			_ent:setFlag("stallLock",nil);
			_p.Stall = nil;

			local _entItems = _ent:getFlag("shopItems",{})

			if _entItems && istable(_entItems) then
				local _returned = 0;

				for k , v in pairs( _entItems ) do
					
					if v && v.ID then
					
						for i=1,v.Amount do
							_p:AddItemByID(v.ID);
							_returned = _returned + 1;
						end		

					end

				end
				if _returned > 0 then
					_p:Notify("Your ".. _returned.. " items have been returned to you.")
				else
					_p:Notify("You have ended your stall.")
				end
			end
			_ent:Remove();
		end
		_p:setFlag("occupyingStall", nil );

	elseif _e == 2 then
		
		local _String = net.ReadString();
		if _String == "" then return end
		local _stallIndex = _p:getFlag("occupyingStall", nil);
		local _ent = ents.GetByIndex(_stallIndex);
		if !_ent then return _p:Notify("Couldn't find stall.") end 
		local _stallOwner = _ent:getFlag("ownedBy","");

		if !_ent then return _p:Notify("You are not occupying a stall!") end;

		local _colorAuthor = Color(56,56,56)
		local _colorText = Color(128,128,128);

		if _stallOwner == _p:SteamID() then
			_colorAuthor = Color(85,56,56)
			_colorText = Color(145,128,128)
		end
		local _occupyingPlayers = {};
		for k , v in pairs( player.GetAll() ) do
			if v:getFlag("occupyingStall", -1) == _stallIndex then
				table.insert(_occupyingPlayers, v);
			end
		end
		net.Start("cashRegister")
			net.WriteInt(2,8)
			net.WriteColor(_colorAuthor)
			net.WriteColor(_colorText)
			net.WriteString( _p:SteamID() )
			net.WriteString( _String )
		net.Send(_occupyingPlayers)

	elseif _e == 3 then
		// 1 - toggle modify
		// 2 - toggle lock		
		local _IntendedAction = net.ReadInt(3);
		local _stallIndex = _p:getFlag("occupyingStall", nil);
		local _ent = ents.GetByIndex(_stallIndex);
		local _stallOwner = _ent:getFlag("ownedBy","");
		if !_ent then return _p:Notify("Couldn't find stall.") end 
		if _p:SteamID() != _stallOwner then return _p:Notify("You cannot modify someone else's stall!") end
		
		local _status = _ent:getFlag("stallStatus", 0)

		local _occupyingPlayers = {};
		for k , v in pairs( player.GetAll() ) do
			if v:getFlag("occupyingStall", -1) == _stallIndex then
				table.insert(_occupyingPlayers, v);
			end
		end
		local _targetStatus = 0;

		if _IntendedAction == 1 then

			local _lock = _ent:getFlag("stallLock", false) 
			if _lock != false then
				_ent:setFlag("stallLock",false);
				_p:Notify("Your stall has been unlocked.")
			end

			if _status == 0 then
				_targetStatus = 1;
				_p:Notify("You have opened your stall.")
			else
				_p:Notify("You have closed your stall.")
			end
			_ent:setFlag("stallStatus",_targetStatus);

		elseif _IntendedAction == 2 then

			local _lock = _ent:getFlag("stallLock", false) 
			_ent:setFlag("stallLock", !_lock);
			_targetStatus = _ent:getFlag("stallStatus",0);
			if _ent:getFlag("stallLock", false) == true  then
				
				_p:Notify("You have locked your stall.")

			else 

				_p:Notify("You have unlocked your stall.")

			end

		end
		net.Start("cashRegister")
			net.WriteInt(3,8)
			net.WriteInt(_targetStatus,2);
			net.WriteBool( _ent:getFlag("stallLock", false) )
		net.Send(_occupyingPlayers)

	elseif _e == 4 then
		
		local _stallIndex = _p:getFlag("occupyingStall", nil);
		local _ent = ents.GetByIndex(_stallIndex);
		local _stallOwner = _ent:getFlag("ownedBy","");
		if _p:SteamID() != _stallOwner then return _p:Notify("You cannot modify someone else's stall!") end
		if !_ent then return _p:Notify("Couldn't find stall.") end 
		local _status = _ent:getFlag("stallStatus", 0)

		local _occupyingPlayers = {};
		for k , v in pairs( player.GetAll() ) do
			if v:getFlag("occupyingStall", -1) == _stallIndex then
				table.insert(_occupyingPlayers, v);
			end
		end

		local _str = net.ReadString();

	
		_ent:setFlag("stallMessage",_str or "");

		net.Start("cashRegister")
			net.WriteInt(5,8)
			net.WriteString(string.sub(_str,1,72))
		net.Send(_occupyingPlayers)

	elseif _e == 5 then
		
		local _stallIndex = _p:getFlag("occupyingStall", nil);
		local _ent = ents.GetByIndex(_stallIndex);
		local _stallOwner = _ent:getFlag("ownedBy","");
		if _p:SteamID() != _stallOwner then return _p:Notify("You cannot modify someone else's stall!") end
		if !_ent then return _p:Notify("Couldn't find stall.") end 
		local _status = _ent:getFlag("stallStatus", 0)
		if _status != 0 then return _p:Notify("You can not modify the stall while it's running shop.") end

		local _occupyingPlayers = {};
		for k , v in pairs( player.GetAll() ) do
			if v:getFlag("occupyingStall", -1) == _stallIndex then
				table.insert(_occupyingPlayers, v);
			end
		end

		local _InventoryItem = net.ReadInt(16)
		local _StallRow = net.ReadInt(8)
		local _Amount = net.ReadInt(32);
		local _Price = math.Clamp(net.ReadInt(32),0,2^32)

		//_p:Notify( _InventoryItem .. "\t" .. _StallRow)

		local _PlayerInventory = LoadStringToInventory( _p:getFlag("inventory", "" ))
		local _ItemID= _PlayerInventory[_InventoryItem].ID;

		if !_ItemID then return _p:Notify("Couldn't find item in question!"); end
		
		if _PlayerInventory[_InventoryItem].Amount < _Amount then
			return _p:Notify("You do not have that many " .. ITEMLIST[_ItemID].Name )
		end

		local _itemTb = _ent:getFlag("shopItems",nil);
		
		if _itemTb then
			
			if _Amount > 0 then
				local _Basket = _itemTb
				local _Inventory = _PlayerInventory;
				local _Slot = _InventoryItem;

				local _AmountInSlot = _Inventory[_Slot].Amount;
				local _ItemIDToGive = _Inventory[_Slot].ID;
				
				if _AmountInSlot - _Amount <= 0 then
					
					if _AmountInSlot-_Amount > 0 then
						
						_Inventory[_Slot] =  _AmountInSlot-_Amount;
						
						if _Inventory[_Slot] < 0 then
							
							_Inventory[_Slot] = nil
								
						end
							
					else
					
								
						table.remove( _Inventory, _Slot )
					end
					
				else
				
					_Inventory[_Slot].Amount = _AmountInSlot - _Amount;
				
				end	

				if !_Basket[_StallRow] then
					_Basket[_StallRow] = {ID = _ItemIDToGive  , Amount = _Amount,Price = _Price}
					_ent:setFlag("shopItems", _Basket)
					//PrintTable(_Basket)
					_p:setFlag("inventory", CompileInventoryToString( _Inventory ) )
					net.Start( "inventorySync" )
						net.WriteString( CompileInventoryToString( _Inventory ) )
					net.Send( _p )
					_p:Notify("Inserted " .. _Amount .. " " .. ITEMLIST[_ItemIDToGive].Name .. " to the row.") 
					net.Start("cashRegister")
						net.WriteInt(6,8)
						net.WriteTable(_Basket)
					net.WriteInt(_ent:EntIndex(),16)
					if #player.GetAll() > 0 then
						net.Broadcast()
					end

					return
				else

					if _Basket[_StallRow].ID ==_ItemID then
						
						_Basket[_StallRow].Amount = _Basket[_StallRow].Amount+_Amount;
						_p:Notify("You have added an additional " .. _Amount .. " " .. ITEMLIST[_Basket[_StallRow].ID].Name .. " to the row.")

					else
						
						for i=1,_Basket[_StallRow].Amount do
							_p:AddItemByID(_Basket[_StallRow].ID);
						end
						_Basket[_StallRow].Amount = _Amount;
						_Basket[_StallRow].Price = _Price;
						_p:Notify("Your items in the row have been returned.")

					end

				end
						
				_p:setFlag("inventory", CompileInventoryToString( _Inventory ) )
				net.Start( "inventorySync" )
					net.WriteString( CompileInventoryToString( _Inventory ) )
				net.Send( _p )
				if _Basket && _Basket[_StallRow] && _Basket[_StallRow].Price && _Basket[_StallRow].Price != _Price then
					_Basket[_StallRow].Price = _Price; 
				end
				_ent:setFlag("shopItems", _Basket)
					
				net.Start("cashRegister")
					net.WriteInt(6,8)
					net.WriteTable(_Basket)
					net.WriteInt(_ent:EntIndex(),16)
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
				return
			end

			_itemTb = _ent:getFlag("shopItems",nil);
		
			if _itemTb && _itemTb[_StallRow] && _itemTb[_StallRow].Price && _itemTb[_StallRow].Price != _Price then
				_itemTb[_StallRow].Price = _Price; 
			end
			_ent:setFlag("shopItems", _itemTb)

			net.Start("cashRegister")
				net.WriteInt(6,8)
				net.WriteTable(_itemTb)
				net.WriteInt(_ent:EntIndex(),16)
			if #player.GetAll() > 0 then
				net.Broadcast()
			end
		end

	elseif _e == 6 then
		
		local _stallIndex = _p:getFlag("occupyingStall", nil);
		local _ent = ents.GetByIndex(_stallIndex);
		local _stallOwner = _ent:getFlag("ownedBy","");
		if _p:SteamID() != _stallOwner then return _p:Notify("You cannot modify someone else's stall!") end
		if !_ent then return _p:Notify("Couldn't find stall.") end 
		local _status = _ent:getFlag("stallStatus", 0)
		if _status != 0 then return _p:Notify("You can not modify the stall while it's running shop.") end
		
		local _occupyingPlayers = {};
		for k , v in pairs( player.GetAll() ) do
			if v:getFlag("occupyingStall", -1) == _stallIndex then
				table.insert(_occupyingPlayers, v);
			end
		end

		local _StallRow = net.ReadInt(8)
		local _Amount = net.ReadInt(32);
		local _Price = math.Clamp(net.ReadInt(32),0,2^32)

		local _itemTb = _ent:getFlag("shopItems",nil);

		if _itemTb[_StallRow] then
			
			local _rowInQ = _itemTb[_StallRow];

			if _rowInQ.ID then

				local _itemToRem = ITEMLIST[_rowInQ.ID];
				local _amountToRem = math.min(_Amount,_rowInQ.Amount);

				if _amountToRem >= _rowInQ.Amount then
					_itemTb[_StallRow] = false;
					_p:Notify("Row has been Cleared.")
				else
					_itemTb[_StallRow].Amount = _itemTb[_StallRow].Amount-_amountToRem;
					_p:Notify("Item's have been returned.")
				end

				for i=1,_amountToRem do
					_p:AddItemByID( _itemToRem.ID )
				end
				local _ps = player.GetBySteamID(_stallOwner);
				if _ps then
					local _lv = 1;
					if _ps:GetRotoLevel(14) then
						_lv = _ps:GetRotoLevel(14)[1]
					end
					_ps:AddRotoXP(14,RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel	*_lv))
				end
				_ent:setFlag("shopItems", _itemTb)

				net.Start("cashRegister")
					net.WriteInt(6,8)
					net.WriteTable(_itemTb)
					net.WriteInt(_ent:EntIndex(),16)
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
			end

		end

	elseif _e == 7 then
		
		local _stallIndex = _p:getFlag("occupyingStall", nil);
		local _ent = ents.GetByIndex(_stallIndex);
		local _stallOwner = _ent:getFlag("ownedBy","");
		if _p:SteamID() == _stallOwner then return _p:Notify("You cannot buy your own stall items!") end
		if !_ent then return _p:Notify("Couldn't find stall.") end 
		local _status = _ent:getFlag("stallStatus", 0)
		if _status == 0 then return _p:Notify("You cannot buy an item from a closed stall!") end
		local StallOwner;

		local _occupyingPlayers = {};
		for k , v in pairs( player.GetAll() ) do 
			if _ent:getFlag("ownedBy","") == v:SteamID() then
				StallOwner = v;
			end
			if v:getFlag("occupyingStall", -1) == _stallIndex then
				table.insert(_occupyingPlayers, v);
			end
		end
		if !IsValid(StallOwner) then return _p:Notify("You can't buy a stall item from no owner!") end
		
		local _itemTb = _ent:getFlag("shopItems",nil);
		local _StallRow = net.ReadInt(8)
		
		if _itemTb[_StallRow] && _itemTb[_StallRow].ID then
			local _toPay = _itemTb[_StallRow].Price

			if _p:canAfford(_toPay) then
				
				_p:addMoney(-_toPay)
				_p:Notify("You have bought x".. _itemTb[_StallRow].Amount .. " of ".. ITEMLIST[_itemTb[_StallRow].ID].Name .. " from " .. _p:getFirstName() )
				
				for i=1,_itemTb[_StallRow].Amount do
					_p:AddItemByID(_itemTb[_StallRow].ID);
				end


				StallOwner:Notify("You have sold x".. _itemTb[_StallRow].Amount .. " of ".. ITEMLIST[_itemTb[_StallRow].ID].Name .. " to " .. _p:getFirstName() )
				StallOwner:addMoney(_toPay)


				_itemTb[_StallRow] = false;
				_ent:setFlag("shopItems", _itemTb)

				net.Start("cashRegister")
					net.WriteInt(6,8)
					net.WriteTable(_itemTb)
					net.WriteInt(_ent:EntIndex(),16)
				if #player.GetAll() > 0 then
					net.Broadcast()
				end

			else
				_p:Notify("You can't afford this payment! ($" .. _toPay .. ")")
			end

		end
	end

end)

function ENT:OnRemove()
end