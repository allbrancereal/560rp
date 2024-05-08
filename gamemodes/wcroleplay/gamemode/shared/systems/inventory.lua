
ITEMLIST = ITEMLIST || {}
 
function SetupItem ( ItemTable )
	if !ItemTable.Illegal then 
		ItemTable.Illegal = false;
	
	end
	if !ItemTable.Tradable then
		ItemTable.Tradeable = true 
	
	end
	if ITEMLIST[ItemTable.ID] then
	
		ITEMLIST[ ItemTable.ID ] = nil
		
	end

	ITEMLIST[ ItemTable.ID ] = ItemTable
	
	 
	//print( "Setup #" .. ItemTable.ID .. " " .. ItemTable.Name ) 
end

  
local _pMeta = FindMetaTable( "Player" )


function _pMeta:GetInventoryTable()
 
	if !IsValid(self) then return end
	
	
	
	return self:getFlag("inventory", "" );
	
	
end

function CompileInventoryToString( _tb )

	if !_tb then return "" end
	local str = "";
	if #_tb > 0 then
	
		for k, v in pairs( _tb ) do
			
			if v and istable(v) and v.Amount && v.Amount > 0 then
			
				str = str .. v.ID .. "," .. v.Amount .. ";";
				
			end
			
		end
	
	end
	
	return str;
	
end
function LoadStringToInventory( str )
	if !isstring(str) then return {} end

	local itemInfo = string.Explode(";", string.Trim(str));
	local __Inventory = {};
	
	i = 1;
	for k, v in pairs(itemInfo) do
		local splitAgain = string.Explode(",", v);
		if (#splitAgain == 2) then
			__Inventory[i] 				= {}
			__Inventory[i].ID 	= tonumber(splitAgain[1]);
			__Inventory[i].Amount 	= tonumber(splitAgain[2]);
		end
		i = i + 1;
		
	end
	
	return __Inventory 
	
end

function _pMeta:CalculateInventoryWeight()

	if !self:GetInventoryTable() then return end
	local wt = 0;	
	for k , v in pairs(self:GetInventoryTable()) do
		
		wt = v.Amount * ITEMLIST[v.ID].Weight + wt;
	
	end
	
	return wt;
end

function _pMeta:RemoveItemByID( _id )
 
	local foundItemSlot = false;
	local _in = LoadStringToInventory(self:getFlag("inventory" , "" ))
	
	if #_in <= 0 then 
	
		return self:Notify("No item in inventory")
		
	end
	local _found = false;
	
	for k , v in pairs( _in ) do
	
		if v.ID == _id then
			if v.Amount - 1 <= 0 then
			
				table.remove( _in , k )
				_found = true;
				break
			else
			
				v.Amount = v.Amount - 1;
				_found = true;
				break
			end
		end
		
	end
	
	if SERVER then
		
		//self:setFlag("inventory", _in )
		
		
		self:setFlag("inventory", CompileInventoryToString(_in) ); 
		
		fsdb_saveClient( self );
		 
		net.Start( "inventorySync" )
			
			net.WriteString( CompileInventoryToString( _in ) )
		net.Send( self )
		
	end 
	
	return _found;
	
end

function _pMeta:AddItemByID( _id )
	if !_id then return print( "Couldn't add " .. _id ) end 
	if !ITEMLIST[ _id ] then return print("Item not found" .. _id ) end
	local foundItemSlot = false;
	local _in = LoadStringToInventory(self:getFlag("inventory" ,"" )) 
	local _maxStack = ITEMLIST[_id].MaxStack;
	local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots;
	
	if #_in > MAX_SLOTS then 
	
		self:Notify("You do not have any available inventory slots")
		
		return false;
	end
	
	if #_in > 0 then
	
		for k , v in pairs( _in ) do
		
			
			if v.ID == _id && v.Amount+1 <= ITEMLIST[v.ID].MaxStack then
				
				_in[k].Amount = _in[k].Amount+1;
				
				foundItemSlot = true;
				
				break
				
			end
		
		end
		
	end 
	
	if !foundItemSlot then
		table.insert(_in, {ID = _id , Amount = 1})
		
		
		
	end
	
	if SERVER then
		
		//self:setFlag("inventory", _in )

		
		self:setFlag("inventory", CompileInventoryToString(_in )); 
		
		
		
		net.Start( "inventorySync" )
			net.WriteTable( _in )
		net.Send( self )
		fsdb_saveClient( self );
		
	end
	
	//self:EmitSound("items/ammocrate_open.wav")
		
	return true;
	
end
if SERVER then
	// moved to sv_player
end 


if CLIENT then
 


end