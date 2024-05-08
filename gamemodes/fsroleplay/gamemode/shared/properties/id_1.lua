


local PROPERTY = PROPERTY ||{};

PROPERTY.ID = 1;

PROPERTY.Name = "Test Room!";
PROPERTY.Category = "Home";
PROPERTY.Description = "A large diner in the city.";

PROPERTY.Cost = 800;
PROPERTY.Owners = PROPERTY.Owners || {};
PROPERTY.PrimaryOwner = PROPERTY.PrimaryOwner || {};
PROPERTY.Doors = 	{
	{Vector(910, -358, -141.71875), 'models/props_c17/door01_left.mdl', "test_01"},
	{Vector(1004, -358, -141.71875), 'models/props_c17/door01_left.mdl', "test_02"},

					};
					
PROPERTY.OnSold = function( _p )

	_p:Notify( "You have sold " .. PROPERTY.Name )
	

end;
PROPERTY.CanBuy = function( _p )

	return true; // No Restrictions

end; 

PROPERTY.PostCantBuy = function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
					
PROPERTY.OnBought = function( _p )

	_p:Notify( "You have bought " .. PROPERTY.Name )


end;

if !string.find( game.GetMap(), "gm_" ) then
	fsrp.SetupProperty(PROPERTY);
end