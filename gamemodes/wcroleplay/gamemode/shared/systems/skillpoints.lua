
local _pMeta = FindMetaTable( 'Player' )


if SERVER then
	// moved to sv player
	
end


/*
	// Name: fsrp.skills.GetSkillTable( _p )
	// Desc: Makes a table of all the skill point types for the player
	// Returns: table _tbl
*/
function skillpoint_Helper_GetSkillTable( _p )

	local _tbl = {}; 
	
	for k , v in pairs( fsrp.skills.config.SkillTypes ) do
	
		_tbl[k] = tonumber( skillpoint_Helper_GetSkillPoint( _p , k ) )
		
	end
	
	return _tbl;

end

	
/*
	// Name: fsrp.skills.helper.GetSkillpointCost( _p )
	// Desc: Helper function to get the current cost of skill points
	// Return: /
*/
function skillpoint_Helper_GetSkillpointCost( _p )
		
	local _skillTable = _p:GetSkillTable()
		
	local _TotalPoints = 1;
		
	for k , v in pairs( _skillTable ) do
		
		_TotalPoints = _TotalPoints + v;
		
	end
	
	_TotalPoints = _TotalPoints + _p:GetFreeSkillPoints()
		
	local _cost = fsrp.skills.config.SkillpointCost * _TotalPoints;
		
	return _cost;

end
	
/*
	// Name: fsrp.skills.GetSkillPoint( Entity Player , String skillType )
	// Desc: Gets a players skill points
	// Returns: Integer Amount
*/
function skillpoint_Helper_GetSkillPoint( _p , skillType )

	return _p:getFlag( "skillPoints_" .. skillType , 0 );

end


/*
	Name: Player:CanBuySkillPoint()
	Desc: Returns whether the player can buy a skillpoint or not
	Return: boolean
*/
function _pMeta:CanBuySkillPoint( )
		
	local _MaxAvailablePoints = 0;
		
	for k , v in pairs( fsrp.skills.config.SkillTypes ) do
			
		_MaxAvailablePoints = v.MaxPoints + _MaxAvailablePoints
			
	end
	
	local _skillTable = self:GetSkillTable()
		
	local _TotalPoints = 1;
			
	for k , v in pairs( _skillTable ) do
			
		_TotalPoints = _TotalPoints + v;
			
	end
	
	_TotalPoints = _TotalPoints + self:GetFreeSkillPoints()
		
	if _TotalPoints + 1 != _MaxAvailablePoints then
		
		return true
			
	else
				
		return false
			
	end
		
end


/*
	// Name: Player:GetFreeSkillPoints()
	// Desc: Gets the free skill points
	// Returns: integer Amount
*/
function _pMeta:GetFreeSkillPoints()

	return tonumber( self:getFlag( "skillPoints_Free", 0 ) )
	
end

/*
	// Name: Player:GetSkillTable()
	// Desc: Retrieves the skill table from the given player
	// Returns: Table skillTable
*/
function _pMeta:GetSkillTable( )

	return skillpoint_Helper_GetSkillTable( self );
	
end

/*
	// Name: _pMeta:GetSkillPoint( String skillType )
	// Desc: Gets the current skill points from the player for the given string
	// Returns: integer Amount
*/
function _pMeta:GetSkillPoint( skillType ) 

	return skillpoint_Helper_GetSkillPoint( self , skillType )
	
end
