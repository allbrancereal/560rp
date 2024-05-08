//
//	- Josh 'Acecool' Moser
//


//
//
//
COOLDOWN_DEFAULT_DURATION = 3;
local META_ENTITY = FindMetaTable('Entity')
//
// Returns whether or not a cooldown exists; optionally allows creating one ( 1 line anti-spam instead of 2 )
//
 //
// Returns whether or not a cooldown exists; optionally allows creating one ( 1 line anti-spam instead of 2 )
//
function META_ENTITY:HasCooldown( _name, _duration )
	local _data = self:GetCooldown( _name );

	// Does cooldown data exist?
	local _bHasCooldownData = ( _data && istable( _data ) ) && true || false;

	// Is the cooldown expired, if we have cooldown data...
	-- local _bIsCooldownExpired = ( self:GetCooldownTimeRemainingFraction( _data ) == 0 ) && true || false;
	local _timeRemaining = self:GetCooldownTimeRemaining( _name );

	// Does a valid cooldown exist? We need cooldown data and it can't be expired...
	local _bHasCooldown = ( _bHasCooldownData && _timeRemaining > 0 ) && true || false;

	// If the cooldown is expired, we need to remove it...
	if ( _timeRemaining == 0 ) then
	self:RemoveCooldown( _name );
	end

	// If we have to create one, do so...
	local _bCreateCooldown = ( isnumber( _duration ) || _duration == true ) && true || false;
	if ( _bCreateCooldown && !_bHasCooldown ) then
		self:SetCooldown( _name, ( isnumber( _duration ) && _duration || COOLDOWN_DEFAULT_DURATION ) );
	end


	// Return the data prior to created so that the if statement will not fail...
	return _bHasCooldown, _timeRemaining, _data;
end


//
// Creates a cooldown for a specific duration
//
function META_ENTITY:RemoveCooldown( _name )
	self:SetCooldown( "CD_" .. _name, nil );
end


//
// Creates a cooldown for a specific duration
//
function META_ENTITY:GetCooldown( _name )
	return istable( _name ) && _name || self:getFlag( "CD_" .. _name, nil, true );
end


//
// Creates a cooldown for a specific duration
//
function META_ENTITY:SetCooldown( _name, _duration )
	local _data = ( isnumber( _duration ) && { started = CurTime( ), duration = _duration } || nil );
	self:setFlag( "CD_" .. _name, _data, true );
end


//
// Returns the Cooldown start-time
//
function META_ENTITY:GetCooldownStartTime( _name )
	local _data = self:GetCooldown( _name );
	return ( _data ) && _data.started || 0;
end


//
// Returns the Cooldown duration
//
function META_ENTITY:GetCooldownDuration( _name )
	local _data = self:GetCooldown( _name );
	return ( _data ) && _data.duration || 0;
end


//
// Elapsed = ( CurrentTime - StartedTime )
//
function META_ENTITY:GetCooldownTimeElapsed( _name )
	// Math.min to ensure the value never goes above GrowTime ( counting up means only worry about one way )
	return math.min( ( CurTime( ) - self:GetCooldownStartTime( _name ) ), self:GetCooldownDuration( _name ) );
end


//
// Returns a fraction, 0 to 1, where 1 means 100% of duration of time has elapsed...
//
function META_ENTITY:GetCooldownTimeElapsedFraction( _name )
	// Math.min to ensure the value never goes above GrowTime ( counting up means only worry about one way )
	return math.min( self:GetCooldownTimeElapsed( _name ) / self:GetCooldownDuration( _name ), 1 );
end


//
// Returns the fraction representation of time-spent-to-completion.. ie 1 to 0 with 0 being Cooldown is finished...
//
function META_ENTITY:GetCooldownTimeRemainingFraction( _name )
	return math.max( 1 - self:GetCooldownTimeElapsedFraction( _name ), 0 );
end


//
// Remaining = ( GrowTime - Elapsed ) or ( GrowTime - ( CurrentTime - StartedTime ) )
//
function META_ENTITY:GetCooldownTimeRemaining( _name )
	// Math.max to ensure the value never goes below 0 ( counting down means only worry about one way )
	return math.max( self:GetCooldownDuration( _name ) - self:GetCooldownTimeElapsed( _name ), 0 );
end