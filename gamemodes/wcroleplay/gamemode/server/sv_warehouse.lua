
/*

fsrp.config.warehouses.SlotsUser = 100;
fsrp.config.warehouses.SlotsDonator = 300;
fsrp.config.warehouses.SlotsPremium = 500;
fsrp.config.warehouses.ItemWithdrawalFee = 10;
fsrp.config.warehouses.ItemDisposalFee = 50;
fsrp.config.warehouses.ItemDepositFee = 25;
fsrp.config.warehouses.RemoteWarehouseFeeIncrease = 2.5; // Times

*/

local _pMeta = FindMetaTable('Player');
util.AddNetworkString("sentVehiclePriceUpdate")
require( "mysqloo" )
local db = mysqloo.connect( "rotospacest.site.nfoservers.com", "rotospacest", "aXC7Q306GThRpkH", "rotospacest_eco", 3306 )

function db:onConnected()

    local q = self:query( "SELECT 5+5" )
    function q:onSuccess( data )

        print( "Vehicle DB Has connected!" )
        //PrintTable( data )
		LoadVehicleData()

    end

    function q:onError( err, sql )

        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )

    end

    q:start()

end

function db:onConnectionFailed( err )

    print( "Connection to database failed!" )
    print( "Error:", err )

end
hook.Add("InitPostEntity","PostEntityDBConnect",function()

	db:connect()

end)
hook.Add("PlayerInitialSpawn","UpdateVehiclePrices",function(_p)
	LoadVehicleData()
end)
function LoadVehicleData()

	local _q = db:query("SELECT * FROM `company_eco`")
	function _q:onSuccess(data)
		SetVehiclePrices(data)
		
		net.Start("sentVehiclePriceUpdate")
		net.WriteTable(data)
	
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
	end

	function _q:onError(err,sql)

        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )
	end
	_q:start()
end
hook.Add("PaydayDistribution","UpdateVehicles",LoadVehicleData)
net.Receive("endWarehouse", function( _l , _p )

	_p:setFlag( "warehouseAcessingRemotely", false )
	
end )

// home means we are clicking the warehouse item
net.Receive("WarehouseAction_Home", function( _l, _p )
	
	local _enum = net.ReadInt( 4 )
	local _slot = net.ReadInt( 16 )
	local deleteMultiple = net.ReadBool()
	local _crgExtra = _p:getFlag("warehouseAcessingRemotely", false)
	
	if !_p:NearNPC( "warehouse" ) && _crgExtra then return _p:Notify("You must be near a warehouse NPC to interact with them!") end
	
	if _enum == 1 then
	
		_p:WithdrawFromWarehouse( _slot , false, _crgExtra )
		
	elseif _enum == 2 then
	
		_p:WithdrawFromWarehouse( _slot , true, _crgExtra )
	
	elseif _enum == 3 then
		
		_p:DestroyInWarehouse( _slot, deleteMultiple ,  _crgExtra )
	
	end
	
end )

// inventory means we clicked a inventory item
net.Receive( "WarehouseAction_Inventory" , function( _l, _p )

	local _enum = net.ReadBool()
	local _slot = net.ReadInt( 16 ) 
	local _crgExtra = _p:getFlag("warehouseAcessingRemotely", false)
	
	if !_p:NearNPC( "warehouse" ) && _crgExtra then return _p:Notify("You must be near a warehouse NPC to interact with them!") end
	//_p:Notify( tostring(_crgExtra) )
	if _enum then
	
		_p:DepositToWarehouse( _slot , false , _crgExtra)
		
	else
	
		_p:DepositToWarehouse( _slot , true , _crgExtra )
	
	end

end )

function _pMeta:SaveWarehouse()

	local _toSave = self:getFlag("warehouseItems" , nil );

	if !_toSave then return false end

	self:SavePermanentData(util.TableToJSON(self:getFlag("warehouseItems" , _toSave )), "WRHS")

	return true;
end
function _pMeta:LoadWarehouse()
	local _data = self:GetPermanentData( "WRHS" )||"" ;

	local _tb = util.JSONToTable( _data )

	if istable(_tb) then
		
		self:setFlag("warehouseItems", _tb );

		return true 

	end
	
	return false;
end



function _pMeta:DepositToWarehouse( _Slot , _amount , chargeExtra )

	local _p = self;
	
	local _Basket = _p:getFlag("warehouseItems" , {} )
	local _trueAmount = _amount && 5 || 1;
	
	local _Inventory = LoadStringToInventory( _p:getFlag("inventory", "" ))
		
	local _maxSlots = self:IsPremium() && fsrp.config.warehouses.SlotsPremium || self:IsDonator() && fsrp.config.warehouses.SlotsDonator || fsrp.config.warehouses.SlotsUser; 
	
	local foundItemSlot = false
	
	// CHECK FOR ITEM AVAILABILITY & REMOVE PLAYER ITEMS HERE
	local _toCharge = _trueAmount * fsrp.config.warehouses.ItemDepositFee;
	
	local _AmountInSlot = _Inventory[_Slot].Amount;
	local _ItemIDToGive = _Inventory[_Slot].ID;
	
	if _AmountInSlot - _trueAmount <= 0 then
		
		if _trueAmount == 5 && _trueAmount - _AmountInSlot > 0 then
			
			_Inventory[_Slot] =  _trueAmount - _AmountInSlot;
			_toCharge = _trueAmount-_AmountInSlot * fsrp.config.warehouses.ItemDepositFee;
	
			if _Inventory[_Slot] < 0 then
				
				_Inventory[_Slot] = nil
					
			end
				
		else
		
			table.remove( _Inventory, _Slot )
			_toCharge = 1 * fsrp.config.warehouses.ItemDepositFee;
	
					
		end
		
	else
	
		_Inventory[_Slot].Amount = _AmountInSlot - _trueAmount;
		_toCharge = _trueAmount * fsrp.config.warehouses.ItemDepositFee;
	
	end
	if chargeExtra then
	
		_toCharge = _toCharge * fsrp.config.warehouses.RemoteWarehouseFeeIncrease;
		
	end
	
	if !self:canAffordBank( _toCharge ) then
	
		return self:Notify( "You can not afford this warehouse deposit" )
		
	end
	
	if _Inventory && #_Inventory > 0 then
	
	_p:setFlag("inventory", CompileInventoryToString( _Inventory ) )
	net.Start( "inventorySync" )
		net.WriteString( CompileInventoryToString( _Inventory ) )
	net.Send( _p )
	
	end
	
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
	
	_p:setFlag("warehouseItems", _Basket)
	
	net.Start("networkPlayerWarehouse")
		net.WriteTable( _Basket )
	net.Send( self )
	
	self:addBank( -_toCharge )
	self:Notify("Successfully deposited item(s) for $" .. _toCharge  .. ".")
	self:SaveWarehouse();

end

function _pMeta:DestroyInWarehouse( indexFound , _amount, chargeExtra )

	local _basket = self:getFlag("warehouseItems" , {} )
	if !_basket || !_basket[indexFound] then
	
		return
		
	end
	
	local _toCharge = 1 * fsrp.config.warehouses.ItemDisposalFee;
	
	if chargeExtra then
	
		_toCharge = _toCharge * fsrp.config.warehouses.RemoteWarehouseFeeIncrease;
		
	end
	
	if !self:canAffordBank( _toCharge ) then
	
		return self:Notify( "You can not afford this warehouse deposit" )
		
	end
	
	local _ItemID = _basket[indexFound].ID;
	
	local _trueAmount = _amount && 5 || 1;
	
	for i = 1 , _trueAmount do
		
		if _basket[indexFound].Amount && _basket[indexFound].Amount - 1 > 0 then
		
			_basket[indexFound].Amount = _basket[indexFound].Amount - 1;
					
		else
		
			table.remove( _basket , indexFound );
			
			break;
			
		end
	
	end
	
	
	 
	// CHARGE PLAYER
	
	self:addBank( -_toCharge )
	self:setFlag("warehouseItems", _basket)
	self:Notify("Successfully destroyed item for $" .. _toCharge .. ".")
	net.Start("networkPlayerWarehouse")
		net.WriteTable( _basket )
	net.Send( self )
	self:SaveWarehouse();
end

function _pMeta:WithdrawFromWarehouse( indexFound, _amount ,chargeExtra )

	local _basket = self:getFlag("warehouseItems" , {} )
	if !_basket || !_basket[indexFound] then
	
		return
		
	end
	local _actualRemoved = 0;
	local _trueAmount = _amount && 5 || 1;
	
	
	local _ItemID = _basket[indexFound].ID;
	
	for i = 1 , _trueAmount do
		
		if _basket[indexFound].Amount && _basket[indexFound].Amount - 1 > 0 then
		
			_basket[indexFound].Amount = _basket[indexFound].Amount - 1;
			
			self:AddItemByID( _ItemID  )
		
			_actualRemoved = _actualRemoved + 1;
		else
		
			table.remove( _basket , indexFound );
			
			self:AddItemByID( _ItemID  )
			
			_actualRemoved = _actualRemoved + 1;
			
			break;
			
		end
	
	end
	
	// CHARGE PLAYER
	
	local _toCharge = _actualRemoved * fsrp.config.warehouses.ItemWithdrawalFee;
	
	if chargeExtra then
	
		_toCharge = _toCharge * fsrp.config.warehouses.RemoteWarehouseFeeIncrease;
		
	end
	
	if !self:canAffordBank( _toCharge ) then
	
		return self:Notify( "You can not afford this warehouse deposit" )
		
	end
	
	self:setFlag("warehouseItems", _basket)
	
	self:addBank( -_toCharge )
	net.Start("networkPlayerWarehouse")
		net.WriteTable( _basket )
	net.Send( self )
	
	self:Notify("Successfully withdrawn item(s) for $" .. _toCharge ..".")
	self:SaveWarehouse();
end 