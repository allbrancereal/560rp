
local _Binders = {
	"models/props_lab/bindergreenlabel.mdl";
	"models/props_lab/binderredlabel.mdl"; 
	"models/props_lab/bindergraylabel01b.mdl";
	"models/props_lab/bindergreen.mdl";
	"models/props_lab/bindergraylabel01a.mdl";
	"models/props_lab/binderbluelabel.mdl";
	"models/props_lab/binderblue.mdl";
}
local indexCount = 200;

function SetupRecipeItem( _tbl )
	local _RecipeItem = {}
	_RecipeItem.ID = indexCount;
				
	_RecipeItem.Category = "Recipe"
	_RecipeItem.Name = _tbl.Name .. " Recipe" 
	_RecipeItem.Quality = 0
	_RecipeItem.Description = "This recipe contains the schematics to craft " .. _tbl.Name
	_RecipeItem.Model	= _Binders[math.random( #_Binders )];
	_RecipeItem.Weight = 0.5;
	_RecipeItem.MaxStack = 1;
	_RecipeItem.Cost = 2500;
	_RecipeItem.CamPos = Vector(0, 0, 37.837837837838);
	_RecipeItem.LookAt = Vector(0, 0, 0);
	_RecipeItem.OnPickedUp = function( _p )

	end 
	_RecipeItem.RecipeID = _tbl.ID;

	_RecipeItem.CanUse = function( _p )
		return true 
	end

	_RecipeItem.OnUsed = function( _p )
		_p:LearnRecipe( _RecipeItem.ID )
	end

	_RecipeItem.OnDropped = function( _p )
		return true
	end 
			 
	 
	SetupItem( _RecipeItem )
	indexCount = indexCount + 1;
end  
fsrp.RecipeTable = fsrp.RecipeTable || {};

fsrp.RecipeTable.AllRecipeList = fsrp.RecipeTable.AllRecipeList || {};

function fsrp.functions.RegisterRecipe( _tbl )
	
	if !fsrp.RecipeTable then
	
		fsrp.RecipeTable = {} 
		
	end
	
	fsrp.RecipeTable.AllRecipeList[_tbl.ID] = _tbl;
		
	
	
	if !fsrp.RecipeTable.Known then
	
		fsrp.RecipeTable.Known = {} 
			
	end
	
	if !fsrp.RecipeTable.Unknown then
	
		fsrp.RecipeTable.Unknown = {} 
		 
	end
	
	if fsrp.RecipeTable.Known[_tbl.ID] then 

		fsrp.RecipeTable.Known[_tbl.ID] = _tbl;
	
	
	end
	
	if _tbl.IsUnknown && _tbl.IsUnknown == true then
				
		//if fsrp.RecipeTable.Unknown[_tbl.ID] then return end
	
		fsrp.RecipeTable.Unknown[_tbl.ID] = _tbl;
		SetupRecipeItem( _tbl )
		
		
	else

	 
		fsrp.RecipeTable.Known[_tbl.ID] = _tbl;
		
	
	end
	

end

local _pMeta = FindMetaTable( 'Player' );

function _pMeta:LearnRecipe( id )

	local _Recipes = self:GetKnownRecipes()
	
	if _Recipes == nil then print( "No recipes" ) end
	if _Recipes != nil && table.HasValue( _Recipes, id ) then 
		return end
	
	//if !fsrp.RecipeTable.Unknown[id] then return print("Did not add: " .. id .. " because it was not a real recipe / it is not unknown." ) end
	
	//if fsrp.RecipeTable.Known[id] then return print( "Did not add because this recipe is already known" ) end
			
	//if fsrp.RecipeTable.AllRecipeList[id] then
		
	local _sep = "";
			
	if _Recipes != "" then
			
		_sep = ";"
			
	end
			
	self:setFlag( "knownRecipes", self:getFlag( "knownRecipes", "" ) .. id .. _sep ) 
			
	self:Notify("Learned" .. fsrp.RecipeTable.AllRecipeList[id].Name )	
		 
	
end

function _pMeta:GetKnownRecipes()
	
	local _recipeString = self:getFlag( "knownRecipes", "" )
	
	if _recipeString == "" then return nil end
	
	local _RecipeSplit = string.Explode( ";" , _recipeString )
	
	local _ReturnTable = {}
	
	for k , v in pairs( _RecipeSplit ) do
	
		if v != "" then
		
			table.insert( _ReturnTable , v )
			
		end
		 
	end
	
	return _ReturnTable
	
end

function _pMeta:GetTotalAmountInv()

	return GetTotalInventoryAmount( self:getFlag("inventory", "") )
	
end

function _pMeta:SortInventoryTable( )

	return SortInventoryTable( self:GetTotalAmountInv() );
	
end
 
function GetTotalInventoryAmount( _tb )

	local _inv = LoadStringToInventory(_tb )
	//PrintTable( _inv )
	local _ReturnTable = {}
	local _foundIt = false
	
	local i = 1;
	
	for k , v in pairs( _inv ) do
		
		local _ItemID = ITEMLIST[ v.ID ];
		
		if _ReturnTable[v.ID] then
		
			_ReturnTable[v.ID].Amount = v.Amount + _ReturnTable[v.ID].Amount;
			
		else
		
			_ReturnTable[v.ID] = {};
			_ReturnTable[v.ID].ID = v.ID;
			_ReturnTable[v.ID].Amount = v.Amount;
		
		end
		i = i + 1
			
	end
		
	
	
		//PrintTable( _ReturnTable )
	return _ReturnTable;

end

if SERVER then

	util.AddNetworkString("sendCraftRequest")
	
	net.Receive("sendCraftRequest", function(_l , _p )
		local _int = net.ReadInt( 16 );
		
		_p:Craft( _int  )

		local _chance = math.random( 10000 )
		if _chance < 1501 then
			
			_p:AddFreeSkillPoints(1)
		end
	
	end )
	
end

function _pMeta:Craft( _RecipeID )

	// Need the recipe for the requirements.
	local _RecipeFromTable = fsrp.RecipeTable.AllRecipeList[_RecipeID];	

	local _PlayerInventory = self:GetTotalAmountInv( ) ;
	
	// Get our requirements
	if !_RecipeFromTable then return print("Could not craft because the recipe was invalid") end
	
	local _RequiredSkills = _RecipeFromTable.RequiredSkills || nil;
	local _RequiredPlaytime = _RecipeFromTable.RequiredPlaytime || nil;
	local _RequiredItems = _RecipeFromTable.RequiredItems || nil;
	local _RequiredLevel = _RecipeFromTable.RequiredLevel || nil;
	
	// Get what the player has.
	local _PlayTime = self:getFlag( "playTime", 0 );
	local _SkillPointTable = skillpoint_Helper_GetSkillTable( self );
	
	if !_RecipeID then return end
	if !_RequiredItems then return end
	if !_RequiredPlaytime then return end
	//PrintTable( _PlayerInventory )
	local _lv = 1;
	if _RequiredLevel then
		if self:GetRotoLevel(12) then
			_lv = self:GetRotoLevel(12)[1];
		end

		if _RequiredLevel > _lv then
			return
		end
	end
	for k , v in pairs( _RequiredItems ) do
		
		if !_PlayerInventory[v.id] then
			//PrintTable( _PlayerInventory )
			_RecipeFromTable.OnCrafted(self,false)
			
			return self:Notify("Could not meet the item requirements, you need " .. (v.amount ) .. " more " .. ITEMLIST[v.id].Name .. " to craft this." )
		
		elseif _PlayerInventory[v.id].Amount < v.amount then
			
			_RecipeFromTable.OnCrafted(self,false)
			
			return self:Notify("Could not meet the item requirements, you need " .. (v.amount - _PlayerInventory[v.id].Amount ) .. " more " .. ITEMLIST[v.id].Name .. " to craft this." )
			
		end
		
	end
	
	if _RequiredSkills then
		
		for k , v in pairs( _RequiredSkills ) do
		
			if ( tonumber(self:GetSkillPoint( v[1] )) < v[2] ) then
			
				_RecipeFromTable.OnCrafted(self, false)
				
				return self:Notify("Could not meet the skill requirements." )
			
			end
			
		end
		
	end
	
	
	for t = 1, #_RequiredItems  do
		
		for i = 1 , _RequiredItems[t].amount do
		
			self:RemoveItemByID( _RequiredItems[t].id )
			
		end
		
	end
	_RecipeFromTable.OnCrafted(self, true )
	
	self:AddRotoXP(12,RotoLevelSystem.config.InitialXPReq + (RotoLevelSystem.config.AdditionalXPPerLevel * _lv))
	self:AddItemByID( _RecipeFromTable.ToGive )
	self:Notify( "Successfully crafted: " .. _RecipeFromTable.Name )
end

