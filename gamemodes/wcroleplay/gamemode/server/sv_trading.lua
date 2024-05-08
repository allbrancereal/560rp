
// FUCKING NETWORKING

local _pMeta = FindMetaTable('Player')

net.Receive("sendTradeEnd", function( _l, _p )
	local _tradePartner = player.GetBySteamID( _p:getFlag("tradingPartner", "" ) );
	
	
	if _tradePartner && _tradePartner:getFlag("tradingPartner",nil) == _p:SteamID() then
					
		_tradePartner:setFlag( "TradeConfirmState", false )
		_p:setFlag( "TradeConfirmState", false )
		_p:setFlag("tradeMoneyInQuestion", 0 );
		_tradePartner:setFlag("tradeMoneyInQuestion",0 );
		
		net.Start("closeTradingWindow")
		net.Send( _tradePartner )
	
		_p:Notify("You have cancelled your trade with " .. _tradePartner:getRPName() );
		
		_tradePartner:Notify( _p:getRPName() .. " has cancelled trading with you" );
		
		local _toGivePlayer1 = _p:getFlag("tradeItems", {} )
		local _toGivePlayer2 = _tradePartner:getFlag("tradeItems", {} )
		
		for k , v in pairs( _toGivePlayer1 ) do
		
			for i = 1 , v.Amount do
				
				_p:AddItemByID( v.ID )
				
			end
		
		end
		
		_p:Notify("Your items have been returned to your inventory");
		
		for k , v in pairs( _toGivePlayer2 ) do
		
			for i = 1 , v.Amount do
				
				_tradePartner:AddItemByID( v.ID )
			
			end
		
		end
		
		_tradePartner:Notify("Your items have been returned to your inventory");
		
	end 

end )

net.Receive( "sendTradeItemToBasket" , function( _l , _p )

	local _Slot = net.ReadInt( 16 )
	local _amount = net.ReadBool()
	local _MyAmount = net.ReadInt(16)
	
	_p:SendItemToBasket( _Slot , _amount )
	
end )


net.Receive("retrieveBucketTradeItem", function( _l , _p ) 

	local _ID = net.ReadInt(16)
	
	_p:RemoveItemFromBasket( _ID );
	
end )

net.Receive("tradeClientMoney", function( _l , _p )
	
	local _money = net.ReadInt( 32 )
	local _p2 = player.GetBySteamID( _p:getFlag("tradingPartner","") );
	
	if _p:canAfford( _money ) then
		
		net.Start( "updateClientTradeMoney" )
			net.WriteInt( _money , 32 )
			net.WriteBool( true );
		net.Send( _p )
		
		net.Start( "updateClientTradeMoney" )
			net.WriteInt( _money , 32 )
			net.WriteBool( false );
		net.Send( _p2 )
		
		_p:setFlag("tradeMoneyInQuestion", _money );

	end
	
end )

net.Receive( "sendTradeConfirmation", function( _l, _p )
	
	local _TradeConfirmState = net.ReadBool()
	
	local _p2 = player.GetBySteamID( _p:getFlag("tradingPartner","") );
	
	_p:setFlag( "TradeConfirmState", _TradeConfirmState )
	
	if _p:getFlag("TradeConfirmState", false) == true && _p2:getFlag("TradeConfirmState", false) == true then
	
			
		net.Start("closeTradingWindow")
		net.Send( _p )
		
		_p:Notify("You have finished your trade with " .. _p2:getRPName() )
		
		net.Start("closeTradingWindow")
		net.Send( _p2 )
		
		_p2:Notify( "You have finished your trade with " .. _p:getRPName() )
	
		local _toGivePlayer1 = _p2:getFlag("tradeItems", {} )
		local _toGivePlayer2 = _p:getFlag("tradeItems", {} )
		
		local _VehiclesToSort1 = {}; // GIVING TO 1 FROM 2
		local _VehiclesToSort2 = {}; // GIVING TO 2 FROM 1
		
		for k , v in pairs( _toGivePlayer1 ) do
		
			for i = 1 , v.Amount do
				
				_p:AddItemByID( v.ID )
				
				if ITEMLIST[v.ID].Vehicle then
				
					table.insert( _VehiclesToSort1, v.ID )
				
				end
				
			end
		
		end
		
		if #_VehiclesToSort1 > 0 then
		
			for k , v in pairs( _VehiclesToSort1 ) do
			
				local _listItem = ITEMLIST[v].ListVehicle
				
				_p2:HandVehicleInformationOver( _listItem , _p:SteamID() )
				
			end
		
		end
		
		for k , v in pairs( _toGivePlayer2 ) do
		
			for i = 1 , v.Amount do
				
				_p2:AddItemByID( v.ID )
			
				if ITEMLIST[v.ID].Vehicle then
				
					table.insert( _VehiclesToSort2, v.ID )
				
				end
				
			end
		
		end
		
		if #_VehiclesToSort2 > 0 then
		
			for k , v in pairs( _VehiclesToSort2 ) do
			
				local _listItem = ITEMLIST[v].ListVehicle
				
				_p:HandVehicleInformationOver( _listItem , _p2:SteamID() )
				
			end
		
		end
		
		local _toGiveMoneyP1 = 	_p2:getFlag("tradeMoneyInQuestion", 0 );
		local _toGiveMoneyP2 = 	_p:getFlag("tradeMoneyInQuestion", 0 );
		
		if _toGiveMoneyP1 > 0 then
		
			_p:Notify( "You have been given $" .. _toGiveMoneyP1 );
			
			_p2:addMoney( -_toGiveMoneyP1 )
			_p:addMoney( _toGiveMoneyP1 )
			
		end
		
		if _toGiveMoneyP2 > 0 then
		
			_p2:Notify( "You have been given $" .. _toGiveMoneyP2 );
		
			_p:addMoney( -_toGiveMoneyP2 )
			_p2:addMoney( _toGiveMoneyP2 )
			
		end

		_p:setFlag("tradeMoneyInQuestion", 0 );
		_p2:setFlag("tradeMoneyInQuestion", 0 );
		_p:getFlag("TradeConfirmState", false)
		_p2:getFlag("TradeConfirmState", false)
	else
		
		net.Start("broadcastConfirmation")
			net.WriteBool( true )
			net.WriteBool( _TradeConfirmState )
		net.Send( _p )
		
		net.Start("broadcastConfirmation")
			net.WriteBool( false )
			net.WriteBool( _TradeConfirmState )
		net.Send( _p2 )
		
	end
	
end )


function _pMeta:RemoveItemFromBasket( indexFound )

	local _basket = self:getFlag("tradeItems" , {} )
	if !_basket || !_basket[indexFound] then
	
		return
		
	end
	
	local _ItemID = _basket[indexFound].ID;
	
	if _basket[indexFound].Amount && _basket[indexFound].Amount - 1 != 0 then
	
		_basket[indexFound].Amount = _basket[indexFound].Amount - 1;
		
	else
	
		table.remove( _basket , indexFound )
	
	end
	
	// GIVE PLAYER ITEM BACK
	self:AddItemByID( _ItemID )
	
	self:setFlag("tradeItems", _basket)
	
	local _p2 = player.GetBySteamID( self:getFlag("tradingPartner","") );
	
	net.Start("getTradeUpdate")
		net.WriteTable( _basket )
		net.WriteBool( false )
	net.Send( _p2 )
	
	net.Start("getTradeUpdate")
		net.WriteTable( _basket )
		net.WriteBool( true )
	net.Send( self )

	self:setFlag("TradeConfirmState", false)
	_p2:setFlag("TradeConfirmState", false)
end

function _pMeta:SendItemToBasket( _Slot , _amount )
	local _p = self;
	
	local _Basket = _p:getFlag("tradeItems" , {} )
	local _trueAmount = _amount && 5 || 1;
	
	local _Inventory = LoadStringToInventory( _p:getFlag("inventory", "" ))
		
	local _maxSlots = fsrp.config.TradeSlots;
	
	local foundItemSlot = false
	
	// CHECK FOR ITEM AVAILABILITY & REMOVE PLAYER ITEMS HERE
	
	
	local _AmountInSlot = _Inventory[_Slot].Amount;
	local _ItemIDToGive = _Inventory[_Slot].ID;
	
	if _AmountInSlot - _trueAmount <= 0 then
		
		if _trueAmount == 5 && _trueAmount - _AmountInSlot > 0 then
			
			_Inventory[_Slot] =  _trueAmount - _AmountInSlot;
			
			if _Inventory[_Slot] < 0 then
				
				_Inventory[_Slot] = nil
					
			end
				
		else
		
					
			table.remove( _Inventory, _Slot )
		end
		
	else
	
		_Inventory[_Slot].Amount = _AmountInSlot - _trueAmount;
	
	end
	
	
	_p:setFlag("inventory", CompileInventoryToString( _Inventory ) )
	net.Start( "inventorySync" )
		net.WriteString( CompileInventoryToString( _Inventory ) )
	net.Send( _p )
	
	if #_Basket > _maxSlots then 
	
		self:Notify("You do not have any available inventory slots")
		
		return false;
		
	end
	for i = 1 , _trueAmount do
	
		if #_Basket > 0 then
		
			for k , v in pairs( _Basket ) do
			
				
				if v.ID == _ItemIDToGive && v.Amount+1 <= ITEMLIST[ _ItemIDToGive ].MaxStack then
					
					_Basket[k].Amount = _Basket[k].Amount+1;
					
					foundItemSlot = true;
					
					break
					
				end
			
			end
			
		end 
		
		if !foundItemSlot then
			table.insert(_Basket, {ID = _ItemIDToGive  , Amount = 1})
			
			
			
		end
	
		foundItemSlot = false;
	end
	
	_p:setFlag("tradeItems", _Basket)
	
	local _p2 = player.GetBySteamID( _p:getFlag("tradingPartner","") );
	
	_p:setFlag("TradeConfirmState", false)
	_p2:setFlag("TradeConfirmState", false)
	net.Start("getTradeUpdate")
		net.WriteTable( _Basket )
		net.WriteBool( false )
	net.Send( _p2 )
	
	net.Start("getTradeUpdate")
		net.WriteTable( _Basket )
		net.WriteBool( true )
	net.Send( _p )
	
	/*
	*/
	
	
	
end 
