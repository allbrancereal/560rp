
/*
4925.018066 -4435.708496 63.383549
] lua_run print(Player(2):GetEyeTrace().Entity:GetPos())
> print(Player(2):GetEyeTrace().Entity:GetPos())...
5591.211914 -4449.832520 63.406013
] lua_run print(Player(2):GetEyeTrace().Entity:GetPos())
> print(Player(2):GetEyeTrace().Entity:GetPos())...
5553.317871 -3976.243408 63.458427

*/

local models = {
/*
["rp_downtown_2017"] = {
{ ang = Angle( 0.05473 , 89.97033 , 0.00099 ) , pos = Vector(-1336.15808,563.55261,12.06378) , mdl = 'models/hunter/blocks/cube075x3x075.mdl' },
{ ang = Angle( -0.0363 , -179.99271 , 0.00201 ) , pos = Vector(-1253.34265,633.99811,12.19305) , mdl = 'models/hunter/blocks/cube075x4x075.mdl' },
{ ang = Angle( -0.0363 , -179.99271 , 0.00201 ) , pos = Vector(-1253.3667,823.79828,12.18639) , mdl = 'models/hunter/blocks/cube075x4x075.mdl' },
{ ang = Angle( 89.99774 , 90.00699 , 180 ) , pos = Vector(-1194.03894,924.63922,71.5331) , mdl = 'models/hunter/blocks/cube3x3x025.mdl' },
{ ang = Angle( -0.00399 , -89.99218 , 2e-005 ) , pos = Vector(-1312.21411,924.604,54.42161) , mdl = 'models/props_c17/door01_left.mdl' },
{ ang = Angle( 89.99774 , 90.00699 , 180 ) , pos = Vector(-1383.38892,924.61615,71.5331) , mdl = 'models/hunter/blocks/cube3x3x025.mdl' },
{ ang = Angle( 89.97995 , 90.00699 , 180 ) , pos = Vector(-1288.93884,924.6048,124.93588) , mdl = 'models/hunter/blocks/cube075x1x025.mdl' },
{ ang = Angle( 89.99577 , -89.82068 , 180 ) , pos = Vector(-1170.30933,925.1637,160.50191) , mdl = 'models/hunter/blocks/cube075x8x025.mdl' },
{ ang = Angle( 88.99057 , 90.17835 , -179.99998 ) , pos = Vector(-1383.83325,924.56842,154.57156) , mdl = 'models/hunter/blocks/cube1x1x025.mdl' },
{ ang = Angle( 89.99774 , 90.00699 , 180 ) , pos = Vector(-1051.68896,924.65656,71.5331) , mdl = 'models/hunter/blocks/cube3x3x025.mdl' },
{ ang = Angle( 0.02099 , -159.63243 , -0.10342 ) , pos = Vector(-1188.17505,863.63226,15.40453) , mdl = 'models/props_wasteland/barricade001a.mdl' },
{ ang = Angle( 0.02236 , 173.07675 , 0.09759 ) , pos = Vector(-1120.5498,870.94849,15.3387) , mdl = 'models/props_wasteland/barricade001a.mdl' },
{ ang = Angle( -3e-005 , -173.65173 , 0.2775 ) , pos = Vector(-1056.63086,865.34283,15.43836) , mdl = 'models/props_wasteland/barricade001a.mdl' },
{ ang = Angle( 0 , -179.23012 , 180 ) , pos = Vector(-1284.89526,687.93079,220.94409) , mdl = 'models/props/de_nuke/nuclearfuelcontainer.mdl' },
{ ang = Angle( 0 , -90 , 90 ) , pos = Vector(-994.47705,960.34113,95.64344) , mdl = 'models/hunter/blocks/cube1x4x05.mdl' },
};
["rp_evocity_v33x"] = {*/
//{ ang = Angle( 0,90,0 ) , pos = Vector( -5331.162109, -7284.555664, 72.477997 ) , mdl = "models/props_combine/breendesk.mdl" };

//{ ang = Angle (0,0,0), pos = Vector(4925.018066, -4435.708496, 63.383549), mdl = "models/props_phx/construct/plastic/plastic_angle_360.mdl", scale = 4};
//{ ang = Angle (0,0,0), pos = Vector(5591.211914, -4449.832520, 63.406013), mdl = "models/props_phx/construct/plastic/plastic_angle_360.mdl", scale = 4};
//{ ang = Angle (0,0,0), pos = Vector(5553.317871, -3976.243408, 63.458427), mdl = "models/props_phx/construct/plastic/plastic_angle_360.mdl", scale = 4};
}

local _PreSpawnEntities = {
/*
["rp_downtown_2017"] = {
	{ ent = "furniture_lamp", pos = Vector(-1249.744 , 1111.178 , 12.202 ); ang = Angle(0.217 , 103.522 , 0.055 ); SpecialFunc = function( ent ) ent:setFlag("isOff", false) end; };
	{ ent = "furniture_lamp" , pos = Vector(-1088.199 , 1108.74 , 12.329 ); ang = Angle(0 , 0 , 0 ); SpecialFunc = function( ent ) ent:setFlag("isOff", false) end; };
};
*/
/*
["rp_evocity_v33x"]={

	{
	pos = Vector(-5331.434 , -7283.942 , 104.646 );
	ang = Angle(0 , 90 , 0 );
	ent = "fsrpmonitor";
	};
	{
	pos = Vector(-5365.55 , -7281.578 , 104.558 );
	ang = Angle(-0.001 , 80.002 , 0.493 );
	ent = "fsrpcomputer";
	};
	{
	pos = Vector(-5116.932 , -7159.927 , 84.31 ) - Vector( 0,0, 15 );
	ang = Angle(-0.363 , -5.599 , -0.606 );
	ent = "furniture_lamp";
	};
	{
	pos = Vector(-5126.538 , -5842.511 , 84.333  ) - Vector( 0,0, 15 );
	ang = Angle(-0.363 , -5.599 , -0.606 );
	ent = "furniture_lamp";
	};
	{
	pos = Vector(-5237.499 , -5841.943 , 84.245 ) - Vector( 0,0, 15 );
	ang = Angle(0.118 , -56.773 , 0.452 );
	ent = "furniture_lamp";
	};
	{
	pos = Vector(-4956.989 , -5842.491 , 84.366 ) - Vector( 0,0, 15 );
	ang = Angle(-0.363 , -5.599 , -0.606 );
	ent = "furniture_lamp";
	};
	{
	pos = Vector(-4890.801 , -6005.549 , 84.175 ) - Vector( 0,0, 15 );
	ang = Angle(-0.045 , 33.827 , -0.013 );
	ent = "furniture_lamp";
	};
};
*/

["rp_downtown_tits_v2"] = {

	{
	pos = Vector(-992.875 , 1233.053 , -151.618 );
	ang = Angle(0.112 , -65.772 , -0.245 );
	ent = "fsrpmonitor";
	};
	{
	pos = Vector(-1007.578 , 1236.378 , -195.511 );
	ang = Angle(0.042 , -90.166 , 0 );
	ent = "fsrpcomputer";
	};

};
}
/*
Vector(-5237.499 , -5841.943 , 84.245 );
Angle(0.118 , -56.773 , 0.452 );
Vector(-5126.538 , -5842.511 , 84.333 );
Angle(-0.216 , 0.372 , -0.064 );
Vector(-4956.989 , -5842.491 , 84.366 );
Angle(0.001 , 0.76 , 0.147 );
Vector(-4890.801 , -6005.549 , 84.175 );
Angle(-0.045 , 33.827 , -0.013 );

*/

local _SpawnedEntities = _SpawnedEntities || {}
local _fueltypes = {
	{	
		ent = "vc_fuel_station_petrol";
		pos = Vector(-6455.029 , -5992.84 , 72.447 );
		ang = Angle(0.002 , 0.815 , -0.123 );
	};
	{
		ent = "vc_fuel_station_diesel";
		pos = Vector(-6455.029 , -6287.227 , 72.431 );
		ang = Angle(0.004 , 0.008 , -0.007 );

	};
	{
		ent = "vc_fuel_station_electricity";
		pos = Vector(-6455.029 , -6583.323 , 72.445 );
		ang = Angle(0.001 , 0.676 , -0.132 );
	};
	{	
		ent = "vc_fuel_station_petrol";
		pos = Vector(10043.313 , 13586.366 , 66.748  );
		ang = Angle(0,0,0 );
	};
	{
		ent = "vc_fuel_station_diesel";
		pos = Vector(9808.752 , 13269.656 , 66.387  );
		ang = Angle(0,0,0 );

	};
	{
		ent = "vc_fuel_station_electricity";
		pos = Vector(10742.104 , 13269.106 , 66.382);
		ang = Angle(0,0,0 );
	};
};
local _fuelEnts= {"vc_fuel_station_electricity","vc_fuel_station_diesel","vc_fuel_station_petrol"};

function MakePreSpawnEntities( )

	for k , v in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
	
		v:setFlag("vehicleCustomizer", false )
		
		v:Remove()
		
	end
	
	
	local _randomCar = math.random( 1,30 ) + 300 
	if ITEMLIST[_randomCar] && ITEMLIST[_randomCar].Vehicle && list.Get("Vehicles")[fsrp.VehicleDatabase[ITEMLIST[_randomCar].ListVehicle].VehicleName] then
		
		local VehicleCustomization = ents.Create( "vehiclecustomizationpointer" );
		VehicleCustomization:SetModel( list.Get("Vehicles")[fsrp.VehicleDatabase[ITEMLIST[_randomCar].ListVehicle].VehicleName].Model )
		VehicleCustomization:Spawn()
		VehicleCustomization:setFlag("vehicleCustomizer", true )
		
	
	else

		local VehicleCustomization = ents.Create( "vehiclecustomizationpointer" );
		VehicleCustomization:SetModel( list.Get("Vehicles")[fsrp.VehicleDatabase[ITEMLIST[315].ListVehicle].VehicleName].Model )
		VehicleCustomization:Spawn()
		VehicleCustomization:setFlag("vehicleCustomizer", true )
		
		
	end

	if !_PreSpawnEntities[game.GetMap()] then return end;
	if #_SpawnedEntities > 0 then
		
		for k , v in pairs( _SpawnedEntities ) do
			
			if IsValid( v )then
			
				v:Remove()
			
			end
			
		end
		
	end
	
	for k , v in pairs( _fuelEnts ) do

		for x , y in pairs( ents.FindByClass(v) ) do

			y:Remove()

		end

	end

	/*
	for k , v in pairs( _fueltypes ) do

		x = ents.Create( v.ent );
		x:SetPos( v.pos );
		x:SetAngles( v.ang);
		x:Spawn()
	end
	*/

	for k , v in pairs( _PreSpawnEntities[game.GetMap()]  ) do
	
		
		local _CachedEnt = ents.Create( v.ent )
		if !IsValid(  _CachedEnt ) then return end

		_CachedEnt:SetPos( v.pos )
		_CachedEnt:SetAngles( v.ang )
		_CachedEnt:Spawn()
		if _CachedEnt:GetPhysicsObject() then
			_CachedEnt:GetPhysicsObject():Sleep()
		end
		
		_CachedEnt:SetMoveType( MOVETYPE_FLY )
		//print("made" .. v.ent )
		if v.SpecialFunc then
		
			v.SpecialFunc( _CachedEnt );
		
		end
		table.insert( _SpawnedEntities , _CachedEnt );
		
	end



end
hook.Add( "WeatherNight", "nightWeatherLamps", function( )

	for k , v in pairs( ents.FindByClass("furniture_lamp") ) do
		if v:getFlag("ownedBy","") == "" then 
		
			v:setFlag( "isOff", false );
		
		end
	end
	
end )
hook.Add( "WeatherDay", "nightWeatherLamps", function( )

	for k , v in pairs( ents.FindByClass("furniture_lamp") ) do
	
		if v:getFlag("ownedBy","") == "" then 
		
			v:setFlag( "isOff", true );
		
		end
		
	end
	
end )



function MakePropDisplay (Pos, Ang, Mod, scale, spindir )
	if !Pos	then return end
	if !Ang then return end
	if !Mod then return end
	local Dsp = ents.Create('displayprop');
	Dsp:SetPos(Pos);
	Dsp:SetAngles(Ang);
	Dsp:Spawn();
	if Mod then
	
	Dsp:SetModel(Mod);
	//Dsp:PhysicsInit(SOLID_VPHYSICS)
	if scale then
	
		Dsp:SetModelScale( scale )
		
		Dsp:setFlag("shouldSpin",true )
	end
	
	
	Dsp:setFlag("spinDirection",  spindir)
	Dsp:SetMoveType(MOVETYPE_NONE)
	Dsp:Activate()
	//Dsp:GetPhysicsObject():Sleep()
	Dsp:SetCollisionGroup(COLLISION_GROUP_NONE)
	
	end
	
	return Dsp;  
end 
function makePropDisplayFromTable()
	
	local _spinDir = -0.1
	if math.random( 100 ) < 50 then 
	
		_spinDir = .1
		
	end
	
	for k , v in pairs( models ) do
	
		if !v.mdl then
		
			MakePropDisplay( v.pos,v.ang,_spinDir )
		
		else
			MakePropDisplay( v.pos,v.ang,v.mdl,_spinDir)
		
		
		end
	end
	for k, v in pairs( ents.GetAll() ) do
	
		if v:GetClass() == "displayprop" || v:GetClass() == "cardisplay" && v:IsValid() then
		
			v:setFlag("mainCarDisplay",nil);
			v:setFlag("shouldSpin",nil )
			v:setFlag("spinDirection",  nil)
			v:Remove()
			
		end
	end
	
	for k , v in pairs( models ) do
		local scale = v.scale || false;
		
		MakePropDisplay( v.pos,v.ang,v.mdl, scale,_spinDir)
		
	end


	local _carDisplays = {
		{ pos=Vector(-1538.019 , -6095.655 , -185.969 );
			ang=Angle(0 , -161.111 , 0 );};

	
	} 
	local index = 1;
	
	local _randomCar = math.random( 1,30 ) + 300 
	for k , v in pairs( _carDisplays ) do
	
		local _car = ents.Create( "cardisplay" )
		_car:SetPos( v.pos )
		_car:SetAngles( v.ang )
		
		if index == 1 then
		
			_car:setFlag("mainCarDisplay",true);
			
		end
		
		_car:setFlag("shouldSpin",true )
		_car:setFlag("spinDirection",  _spinDir)
		//print( _randomCar )
		//if !ITEMLIST[_randomCar] then _randomCar = _randomCar +1  end
		local _preIndex = index;
		local spawned = false;

		if ITEMLIST[_randomCar] && ITEMLIST[_randomCar].Vehicle && list.Get("Vehicles")[fsrp.VehicleDatabase[ITEMLIST[_randomCar].ListVehicle].VehicleName] then
		
			_car:SetModel( list.Get("Vehicles")[fsrp.VehicleDatabase[ITEMLIST[_randomCar].ListVehicle].VehicleName].Model )
			_car:Spawn()
			index = index + 1
			spawned = true;

		end
		
		if index ==  _preIndex then
		
			local _itemKey = ITEMLIST[math.random(315,319)];

			if _itemKey then 

				_car:SetModel( list.Get("Vehicles")[fsrp.VehicleDatabase[_itemKey.ListVehicle].VehicleName].Model )
				_car:Spawn()
				index = index + 1
			
			end
				spawned = true;


		end
		
		if !spawned then

			_car:Spawn()
			
		end

		_randomCar = math.random( 1,30 ) + 300 
	end
	
	
end

local function HandlePostEntityCarDisplay()

	for k , v in pairs( ents.GetAll() ) do
	
		if v:GetModel() == "models/props_equipment/gas_pump.mdl" then
		
			v:Remove()
			
		end
		
	end
	
	MakePreSpawnEntities()
	makePropDisplayFromTable()

end

hook.Add( "InitPostEntity", "SpawnEntities", function( )
	
	HandlePostEntityCarDisplay()

end )