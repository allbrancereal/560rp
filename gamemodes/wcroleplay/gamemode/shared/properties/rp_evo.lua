

/*
local PROPERTY = PROPERTY ||{};

PROPERTY.ID = 1;
 
PROPERTY.Name = "Tiny Store";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small store with guard walls..";
PROPERTY.Mat	= 'TinyStore';

PROPERTY.Cost = 500;

PROPERTY.PrimaryOwner = PROPERTY.PrimaryOwner || nil;
PROPERTY.Doors = 	{ 
{Index = 476 , Vector(38, -1006, 54), '*29', 'name' },


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


SetupProperty(PROPERTY);

//
local PropertyTable = {}


PropertyTable[] = {};
PropertyTable[].ID 			= ;
PropertyTable[].Name 			= "";
PropertyTable[].Category 		= "";
PropertyTable[].Description 	= "";
PropertyTable[].Mat 			= "";
PropertyTable[].Cost 			= ;
PropertyTable[].PrimaryOwner 	= PropertyTable[].PrimaryOwner || nil;
PropertyTable[].Doors 			= {

};
PropertyTable[].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[].Name )
	

end;
PropertyTable[].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[].Name )


end; 




local PropertyTable = {}
PropertyTable[1] = {};
PropertyTable[1].ID 			= 1;
PropertyTable[1].Name 			= "Uptown Shop 4";
PropertyTable[1].Category 		= "Business";
PropertyTable[1].Description 	= "A shop in the corner of the city.";
PropertyTable[1].Mat 			= "uptownshop4";
PropertyTable[1].Cost 			= 1750;
PropertyTable[1].PrimaryOwner 	= PropertyTable[1].PrimaryOwner || nil;
PropertyTable[1].Doors 			= {
{ Index = 1384 ,Vector(-3992, -6441, 252.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[1].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[1].Name )
	

end;
PropertyTable[1].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[1].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[1].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[1].Name )


end; 


PropertyTable[2] = {};
PropertyTable[2].ID 			= 2;
PropertyTable[2].Name 			= "Uptown Shop 3";
PropertyTable[2].Description 	= "A shop adjascent to other shops in the cranny of the city.";
PropertyTable[2].Mat 			= "uptownshop3";
PropertyTable[2].Category 		= "Business";
PropertyTable[2].Cost 			= 2500;
PropertyTable[2].PrimaryOwner 	= PropertyTable[2].PrimaryOwner || nil;
PropertyTable[2].Doors 			= {
{ Index = 1383 ,Vector(-3992, -6049, 252.25), 'models/props_c17/door01_left.mdl', '' },


};
PropertyTable[2].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[2].Name )
	

end;
PropertyTable[2].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[2].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[2].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[2].Name )


end; 


PropertyTable[3] = {};
PropertyTable[3].ID 			= 3;
PropertyTable[3].Name 			= "Uptown Shop 2";
PropertyTable[3].Category 		= "Business";
PropertyTable[3].Description 	= "A shop close to the fire department, but not close enough to hear their banter.";
PropertyTable[3].Mat 			= "uptownshop2";
PropertyTable[3].Cost 			= 2750;
PropertyTable[3].PrimaryOwner 	= PropertyTable[3].PrimaryOwner || nil;
PropertyTable[3].Doors 			= {
{ Index = 1382 ,Vector(-3992, -5961, 252.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[3].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[3].Name )
	

end;
PropertyTable[3].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[3].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[3].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[3].Name )


end; 


PropertyTable[4] = {};
PropertyTable[4].ID 			= 4;
PropertyTable[4].Name 			= "Uptown Shop 1";
PropertyTable[4].Category 		= "Business";
PropertyTable[4].Description 	= "A shop right beside the fire department.";
PropertyTable[4].Mat 			= "uptownshop1";
PropertyTable[4].Cost 			= 3150;
PropertyTable[4].PrimaryOwner 	= PropertyTable[4].PrimaryOwner || nil;
PropertyTable[4].Doors 			= {
{ Index = 1381 ,Vector(-3992, -5569, 252.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[4].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[4].Name )
	

end;
PropertyTable[4].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[4].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[4].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[4].Name )


end; 

PropertyTable[5] = {};
PropertyTable[5].ID 			= 5;
PropertyTable[5].Name 			= "Business Office";
PropertyTable[5].Category 		= "Business";
PropertyTable[5].Description 	= "Decorative with multiple waterfalls.";
PropertyTable[5].Mat 			= "scraper";
PropertyTable[5].Cost 			= 31250;
PropertyTable[5].PrimaryOwner 	= PropertyTable[5].PrimaryOwner || nil;
PropertyTable[5].Doors 			= {
{ Index = 2046 ,Vector(-5539.5, -9255, 135), '*36', '' },
{ Index = 2045 ,Vector(-5539, -9315, 135), '*35', '' },
{ Index = 2104 ,Vector(-5145, -9153.98046875, 1662.2800292969), 'models/highrise/doors_glass_01.mdl', '' },
{ Index = 2103 ,Vector(-5175, -9154, 1662.2800292969), 'models/highrise/doors_glass_01.mdl', '' },
{ Index = 2116 ,Vector(-5031.0200195313, -9154, 1534.2800292969), 'models/highrise/doors_glass_01.mdl', '' },
{ Index = 2115 ,Vector(-5031.0200195313, -9378, 1534.2800292969), 'models/highrise/doors_glass_01.mdl', '' },
{ Index = 2114 ,Vector(-5031.0200195313, -9634, 1534.2800292969), 'models/highrise/doors_glass_01.mdl', '' },

};
PropertyTable[5].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[5].Name )
	

end;
PropertyTable[5].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[5].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[5].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[5].Name )


end; 

PropertyTable[6] = {};
PropertyTable[6].ID 			= 6;
PropertyTable[6].Name 			= "Izzies Palace";
PropertyTable[6].Category 		= "Business";
PropertyTable[6].Description 	= "A club that is in the back of downtown, only the richest of people may afford.";
PropertyTable[6].Mat 			= "izzies";
PropertyTable[6].Cost 			= 18500;
PropertyTable[6].PrimaryOwner 	= PropertyTable[6].PrimaryOwner || nil;
PropertyTable[6].Doors 			= {
{ Index = 2930 ,Vector(-7089, -12643, 135), '*174', '' },
{ Index = 2929 ,Vector(-6967, -12643, 135), '*173', '' },
{ Index = 2968 ,Vector(-7279, -14379, 135), '*177', '' },
{ Index = 2969 ,Vector(-7401, -14379, 135), '*178', '' },
{ Index = 2983 ,Vector(-7408, -14314, 135), '*179', '' },

};
PropertyTable[6].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[6].Name )
	

end;
PropertyTable[6].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[6].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[6].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[6].Name )


end; 
PropertyTable[7] = {};
PropertyTable[7].ID 			= 7;
PropertyTable[7].Name 			= "Amber Room";
PropertyTable[7].Category 		= "Business";
PropertyTable[7].Description 	= "A cafe decoratively placed near the apartments.";
PropertyTable[7].Mat 			= "amber";
PropertyTable[7].Type 			= 2;
PropertyTable[7].Cost 			= 1290999;
PropertyTable[7].PrimaryOwner 	= PropertyTable[7].PrimaryOwner || nil;
PropertyTable[7].Doors 			= {
{ RemoveDoor = false, Index = 3361 ,Vector(-10285.200195313, -10448, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },
{  RemoveDoor = false,Index = 3360 ,Vector(-10285.099609375, -10505.900390625, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },
{ RemoveDoor = false, Index = 3359 ,Vector(-10285.200195313, -10552, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },
{ RemoveDoor = false, Index = 3358 ,Vector(-10285.099609375, -10609.900390625, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },
{ RemoveDoor = true, Index = 3419 ,Vector(-10448, -10721, 151), '*234', '' },
{  RemoveDoor = true,Index = 3322 ,Vector(-10575.099609375, -10721.099609375, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },
{  RemoveDoor = true,Index = 3323 ,Vector(-10633, -10721.200195313, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },
{ RemoveDoor = true, Index = 3324 ,Vector(-10655.099609375, -10721.099609375, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },
{  RemoveDoor = true,Index = 3325 ,Vector(-10713, -10721.200195313, 126.28099822998), 'models/props_c17/door02_double.mdl', '' },

};

PropertyTable[7].ClubHouseInformation = {
	Desc = "A small cafe along the apartments near the park in Evo-City.";
	EnterLoc = {Vector(-10348.899414 ,-10497.227539,72.273346),Angle(0,-180 ,0.000000)};	
	ExitLoc = {Vector(-10214.606445, -10436.688477, 72.968750),Angle(0,24,0)};	
	Tag = "abm",
	DisplayProps = {
		/*
		{"EntityClass", Vector(Position), Angle(Angle), model,Nocollide};
		*//*
	};	
}
PropertyTable[7].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[7].Name )
	

end;
PropertyTable[7].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[7].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[7].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[7].Name )


end; 
PropertyTable[8] = {};
PropertyTable[8].ID 			= 8;
PropertyTable[8].Name 			= "Downtown Apartment Shop 1";
PropertyTable[8].Category 		= "Business";
PropertyTable[8].Description 	= "A shop with big ol' open windows.";
PropertyTable[8].Mat 			= "downtownapartmentshop1";
PropertyTable[8].Cost 			= 4000;
PropertyTable[8].PrimaryOwner 	= PropertyTable[8].PrimaryOwner || nil;
PropertyTable[8].Doors 			= {
{ Index = 3481 ,Vector(-10591, -10081, 126.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[8].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[8].Name )
	

end;
PropertyTable[8].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[8].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[8].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[8].Name )


end; 
PropertyTable[9] = {};
PropertyTable[9].ID 			= 9;
PropertyTable[9].Name 			= "Downtown Apartment Shop 2";
PropertyTable[9].Category 		= "Business";
PropertyTable[9].Description 	= "Adjacent to the other shop unit, this one is a little harder to spy in-to.";
PropertyTable[9].Mat 			= "downtownapartmentshop2";
PropertyTable[9].Cost 			= 4150;
PropertyTable[9].PrimaryOwner 	= PropertyTable[9].PrimaryOwner || nil;
PropertyTable[9].Doors 			= {
{ Index = 3371 ,Vector(-10575, -9697, 126.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[9].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[9].Name )
	

end;
PropertyTable[9].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[9].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[9].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[9].Name )


end; 
PropertyTable[10] = {};
PropertyTable[10].ID 			= 10;
PropertyTable[10].Name 			= "Downtown Apartment 1-1";
PropertyTable[10].Category 		= "Housing";
PropertyTable[10].Description 	= "A small suite with a big open window, one washroom, and a bedroom.";
PropertyTable[10].Mat 			= "downtowninnerapartment";
PropertyTable[10].Cost 			= 1300;
PropertyTable[10].PrimaryOwner 	= PropertyTable[10].PrimaryOwner || nil;
PropertyTable[10].Doors 			= {
{ Index = 3441 ,Vector(-10750.799804688, -10000.799804688, 254.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3436 ,Vector(-10604, -9889, 254.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3440 ,Vector(-10722.700195313, -9889, 254.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[10].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[10].Name )
	

end;
PropertyTable[10].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[10].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[10].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[10].Name )


end; 
PropertyTable[11] = {};
PropertyTable[11].ID 			= 11;
PropertyTable[11].Name 			= "Downtown Apartment 2-1";
PropertyTable[11].Category 		= "Housing";
PropertyTable[11].Description 	= "Just like the unit downstairs, with a moved washroom allowing a big open room.";
PropertyTable[11].Mat 			= "downtowninnerapartment";
PropertyTable[11].Cost 			= 1450;
PropertyTable[11].PrimaryOwner 	= PropertyTable[11].PrimaryOwner || nil;
PropertyTable[11].Doors 			= {
{ Index = 3375 ,Vector(-10602.799804688, -10201, 382.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3453 ,Vector(-10750.799804688, -10001, 382.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3480 ,Vector(-10722.900390625, -9888.91015625, 382.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[11].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[11].Name )
	

end;
PropertyTable[11].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[11].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[11].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[11].Name )


end; 
PropertyTable[12] = {};
PropertyTable[12].ID 			= 12;
PropertyTable[12].Name 			= "Downtown Penthouse Apartment (3-1)";
PropertyTable[12].Category 		= "Housing";
PropertyTable[12].Description 	= "A luxurious view with this apartment, allowing you to hang out on a dedicated balcony.";
PropertyTable[12].Mat 			= "downtownpenthouse";
PropertyTable[12].Cost 			= 3000;
PropertyTable[12].PrimaryOwner 	= PropertyTable[12].PrimaryOwner || nil;
PropertyTable[12].Doors 			= {
{ Index = 3476 ,Vector(-10747, -10081, 510.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3421 ,Vector(-10455.099609375, -10078.099609375, 510.28100585938), 'models/props_c17/door02_double.mdl', '' },
{ Index = 3422 ,Vector(-10513, -10078.200195313, 510.28100585938), 'models/props_c17/door02_double.mdl', '' },
{ Index = 3475 ,Vector(-10695, -9897, 510.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3457 ,Vector(-10831, -9896.990234375, 510.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[12].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[12].Name )
	

end;
PropertyTable[12].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[12].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[12].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[12].Name )


end; 
PropertyTable[13] = {};
PropertyTable[13].ID 			= 13;
PropertyTable[13].Name 			= "Downtown Apartment 2-2";
PropertyTable[13].Category 		= "Housing";
PropertyTable[13].Description 	= "One bedroom, one washroom, dedicated balcony and kitchen all in one.";
PropertyTable[13].Mat 			= "downtownouterapartment";
PropertyTable[13].Cost 			= 1800;
PropertyTable[13].PrimaryOwner 	= PropertyTable[13].PrimaryOwner || nil;
PropertyTable[13].Doors 			= {
{ Index = 3454 ,Vector(-10830.700195313, -9697, 382.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3455 ,Vector(-10603, -9616, 382.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3456 ,Vector(-10425, -9697, 382.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3326 ,Vector(-10413.099609375, -9641.9296875, 382.28100585938), 'models/props_c17/door02_double.mdl', '' },
{ Index = 3327 ,Vector(-10413.200195313, -9584, 382.28100585938), 'models/props_c17/door02_double.mdl', '' },

};
PropertyTable[13].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[13].Name )
	

end;
PropertyTable[13].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[13].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[13].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[13].Name )


end; 
PropertyTable[14] = {};
PropertyTable[14].ID 			= 14;
PropertyTable[14].Name 			= "Downtown Apartment 1-2";
PropertyTable[14].Category 		= "Housing";
PropertyTable[14].Description 	= "Unlike the suite above, this unit has no balcony.";
PropertyTable[14].Mat 			= "downtownouterapartment";
PropertyTable[14].Cost 			= 1375;
PropertyTable[14].PrimaryOwner 	= PropertyTable[14].PrimaryOwner || nil;
PropertyTable[14].Doors 			= {
{ Index = 3450 ,Vector(-10830.700195313, -9697, 254.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3452 ,Vector(-10416, -9503.7802734375, 254.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3451 ,Vector(-10471, -9512.9404296875, 254.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[14].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[14].Name )
	

end;
PropertyTable[14].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[14].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[14].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[14].Name )


end; 
PropertyTable[15] = {};
PropertyTable[15].ID 			= 15;
PropertyTable[15].Name 			= "Hotel 1-1";
PropertyTable[15].Category 		= "Housing";
PropertyTable[15].Description 	= "Cheap hotel housing allowing you to plan out your next move.";
PropertyTable[15].Mat 			= "hotel";
PropertyTable[15].Cost 			= 850;
PropertyTable[15].PrimaryOwner 	= PropertyTable[15].PrimaryOwner || nil;
PropertyTable[15].Doors 			= {
{ Index = 2261 ,Vector(-4129, -4676, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2292 ,Vector(-4163, -4729, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[15].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[15].Name )
	

end;
PropertyTable[15].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[15].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[15].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[15].Name )


end; 
PropertyTable[16] = {};
PropertyTable[16].ID 			= 16;
PropertyTable[16].Name 			= "Hotel 1-2";
PropertyTable[16].Category 		= "Housing";
PropertyTable[16].Description 	= "With a more further away placed unit, you get the luxury of less interruptions.";
PropertyTable[16].Mat 			= "hotel";
PropertyTable[16].Cost 			= 900;
PropertyTable[16].PrimaryOwner 	= PropertyTable[16].PrimaryOwner || nil;
PropertyTable[16].Doors 			= {
{ Index = 2293 ,Vector(-3820, -4729, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2264 ,Vector(-3785, -4676, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[16].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[16].Name )
	

end;
PropertyTable[16].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[16].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[16].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[16].Name )


end; 
PropertyTable[17] = {};
PropertyTable[17].ID 			= 17;
PropertyTable[17].Name 			= "Hotel 1-3";
PropertyTable[17].Category 		= "Housing";
PropertyTable[17].Description 	= "Furthest away on the right side.";
PropertyTable[17].Mat 			= "hotel";
PropertyTable[17].Cost 			= 1000;
PropertyTable[17].PrimaryOwner 	= PropertyTable[17].PrimaryOwner || nil;
PropertyTable[17].Doors 			= {
{ Index = 2294 ,Vector(-3476, -4729, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2266 ,Vector(-3448, -4676, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[17].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[17].Name )
	

end;
PropertyTable[17].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[17].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[17].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[17].Name )


end; 
PropertyTable[18] = {};
PropertyTable[18].ID 			= 18;
PropertyTable[18].Name 			= "Hotel 2-3";
PropertyTable[18].Category 		= "Housing";
PropertyTable[18].Description 	= "Furthest away on the left side.";
PropertyTable[18].Mat 			= "hotel";
PropertyTable[18].Cost 			= 1250;
PropertyTable[18].PrimaryOwner 	= PropertyTable[18].PrimaryOwner || nil;
PropertyTable[18].Doors 			= {
{ Index = 2265 ,Vector(-3448, -4540, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2295 ,Vector(-3476, -4533, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[18].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[18].Name )
	

end;
PropertyTable[18].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[18].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[18].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[18].Name )


end; 
PropertyTable[19] = {};
PropertyTable[19].ID 			= 19;
PropertyTable[19].Name 			= "Hotel 2-2";
PropertyTable[19].Category 		= "Housing";
PropertyTable[19].Description 	= "In the middle of everything, this room allows you no privacy.";
PropertyTable[19].Mat 			= "hotel";
PropertyTable[19].Cost 			= 750;
PropertyTable[19].PrimaryOwner 	= PropertyTable[19].PrimaryOwner || nil;
PropertyTable[19].Doors 			= {
{ Index = 2296 ,Vector(-3820, -4533, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2263 ,Vector(-3785, -4540, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[19].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[19].Name )
	

end;
PropertyTable[19].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[19].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[19].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[19].Name )


end; 
PropertyTable[20] = {};
PropertyTable[20].ID 			= 20;
PropertyTable[20].Name 			= "Hotel 2-1";
PropertyTable[20].Category 		= "Housing";
PropertyTable[20].Description 	= "Small but useful for the chap who doesn't want to spend a million bucks on a home.";
PropertyTable[20].Mat 			= "hotel";
PropertyTable[20].Cost 			= 600;
PropertyTable[20].PrimaryOwner 	= PropertyTable[20].PrimaryOwner || nil;
PropertyTable[20].Doors 			= {
{ Index = 2297 ,Vector(-4163, -4533, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2262 ,Vector(-4129, -4540, 254.28100585938), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[20].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[20].Name )
	

end;
PropertyTable[20].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[20].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[20].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[20].Name )


end; 

PropertyTable[21] = {};
PropertyTable[21].ID 			= 21;
PropertyTable[21].Name 			= "Downtown Store";
PropertyTable[21].Category 		= "Business";
PropertyTable[21].Description 	= "A nice little store with lots of windows.";
PropertyTable[21].Mat 			= "downtownshop";
PropertyTable[21].Cost 			= 5000;
PropertyTable[21].PrimaryOwner 	= PropertyTable[21].PrimaryOwner || nil;
PropertyTable[21].Doors 			= {
{ Index = 2989 ,Vector(-5432, -7768, 135), '*185', '' },
{ Index = 2988 ,Vector(-5432, -7890, 135), '*184', '' },

};
PropertyTable[21].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[21].Name )
	

end;
PropertyTable[21].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[21].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[21].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[21].Name )


end; 

PropertyTable[22] = {};
PropertyTable[22].ID 			= 22;
PropertyTable[22].Name 			= "Intersection Warehouse";
PropertyTable[22].Category 		= "Business";
PropertyTable[22].Description 	= "Leading to all districts, this is the ultimate warehouse for a taxi driver.";
PropertyTable[22].Mat 			= "intersectionwarehouse";
PropertyTable[22].Cost 			= 8799;
PropertyTable[22].PrimaryOwner 	= PropertyTable[22].PrimaryOwner || nil;
PropertyTable[22].Doors 			= {
{ Index = 1334 ,Vector(-3526.8000488281, 122.00199890137, 126.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1336 ,Vector(-3244, 318, 135), '*1', '' },
{ Index = 1335 ,Vector(-2228, 139.00199890137, 126.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[22].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[22].Name )
	

end;
PropertyTable[22].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[22].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[22].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[22].Name )


end; 
PropertyTable[23] = {};
PropertyTable[23].ID 			= 23;
PropertyTable[23].Name 			= "Malonesky Transportation LTD";
PropertyTable[23].Category 		= "Business";
PropertyTable[23].Description 	= "With 3 huge warehouses, you can supply over 20 people with works.";
PropertyTable[23].Mat 			= "milotrans";
PropertyTable[23].Cost 			= 42000;
PropertyTable[23].PrimaryOwner 	= PropertyTable[23].PrimaryOwner || nil;
PropertyTable[23].Doors 			= { 
{ Index = 3042 ,Vector(-720, 3488, 158), '*197', '' },
{ Index = 3024 ,Vector(-1036, 3488, 158), '*188', '' },
{ Index = 3022 ,Vector(-1420, 3488, 158), '*186', '' },
{ Index = 3023 ,Vector(-1804, 3488, 158), '*187', '' },
{ Index = 3025 ,Vector(-2058, 3074, 158), '*189', '' },
{ Index = 3026 ,Vector(-2058, 2882, 158), '*190', '' },
{ Index = 3044 ,Vector(-2058, 3288, 150), '*199', '' },
{ Index = 3041 ,Vector(-2238, 3744, 150), '*196', '' },
{ Index = 3143 ,Vector(-1936, 6268, 190), '*213', '' },
{ Index = 3152 ,Vector(-1552, 6268, 190), '*214', '' },
{ Index = 3153 ,Vector(-1552, 7062, 190), '*215', '' },
{ Index = 3154 ,Vector(-1936, 7062, 190), '*216', '' },
{ Index = 3048 ,Vector(-2582, 6193, 118), '*203', '' },
{ Index = 3045 ,Vector(-3051, 7189, 127), '*200', '' },
{ Index = 3046 ,Vector(-3173, 7189, 127), '*201', '' },
{ Index = 3047 ,Vector(-2972, 5825, 118), '*202', '' },
{ Index = 3055 ,Vector(-2972, 5505, 118), '*204', '' },
{ Index = 3056 ,Vector(-2972, 5085, 118), '*205', '' },
{ Index = 3125 ,Vector(-2076, 8338, 156), '*207', '' },
{ Index = 3126 ,Vector(-1788, 8338, 156), '*208', '' },
{ Index = 3128 ,Vector(-2254, 8600, 118.28099822998), 'models/props_warehouse/door.mdl', '' },
{ Index = 3127 ,Vector(-2566, 8425, 118), '*209', '' },


};
PropertyTable[23].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[23].Name )
	

end;
PropertyTable[23].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[23].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[23].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[23].Name )


end; 
PropertyTable[24] = {};
PropertyTable[24].ID 			= 24;
PropertyTable[24].Name 			= "Tall Warehouse";
PropertyTable[24].Category 		= "Business";
PropertyTable[24].Description 	= "With huge promises come bigger suprises.";
PropertyTable[24].Mat 			= "industrialstacker";
PropertyTable[24].Cost 			= 15000;
PropertyTable[24].PrimaryOwner 	= PropertyTable[24].PrimaryOwner || nil;
PropertyTable[24].Doors 			= {
{ Index = 3201 ,Vector(1844, 5890, 122.28099822998), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3200 ,Vector(1937.2800292969, 5889.8999023438, 122.28099822998), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1849 ,Vector(1332, 5890, 178), '*24', '' },
{ Index = 1851 ,Vector(1332, 6396, 178), '*26', '' },
{ Index = 1847 ,Vector(1336.5, 5403, 132), '*23', '' },

};
PropertyTable[24].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[24].Name )
	

end;
PropertyTable[24].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[24].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[24].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[24].Name )


end; 
PropertyTable[25] = {};
PropertyTable[25].ID 			= 25;
PropertyTable[25].Name 			= "Office Garage";
PropertyTable[25].Category 		= "Business";
PropertyTable[25].Description 	= "Hiding as a garage, slick floors and two windows. A nice place to be in.";
PropertyTable[25].Mat 			= "officewarehouse";
PropertyTable[25].Cost 			= 6000;
PropertyTable[25].PrimaryOwner 	= PropertyTable[25].PrimaryOwner || nil;
PropertyTable[25].Doors 			= {
{ Index = 3194 ,Vector(2805, 5507, 122.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3168 ,Vector(3440.0100097656, 5883, 130), '*224', '' },
{ Index = 3169 ,Vector(3312.0100097656, 5883, 130), '*225', '' },
{ Index = 3195 ,Vector(3181, 6395, 122.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[25].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[25].Name )
	

end;
PropertyTable[25].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[25].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[25].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[25].Name )


end; 
PropertyTable[26] = {};
PropertyTable[26].ID 			= 26;
PropertyTable[26].Name 			= "Garage";
PropertyTable[26].Category 		= "Business";
PropertyTable[26].Description 	= "With all these newfangled cars someone has to fix them? Right?";
PropertyTable[26].Mat 			= "garage";
PropertyTable[26].Cost 			= 4000;
PropertyTable[26].PrimaryOwner 	= PropertyTable[26].PrimaryOwner || nil;
PropertyTable[26].Doors 			= {
{ Index = 3170 ,Vector(4272, 6787, 122.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3165 ,Vector(3768, 5954.990234375, 130), '*223', '' },
{ Index = 3166 ,Vector(4055, 5759, 122.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3164 ,Vector(3831, 5381, 122.25), 'models/props_c17/door01_left.mdl', '' },


};
PropertyTable[26].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[26].Name )
	

end;
PropertyTable[26].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[26].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[26].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[26].Name )


end; 
PropertyTable[27] = {};
PropertyTable[27].ID 			= 27;
PropertyTable[27].Name 			= "Hidden Shop";
PropertyTable[27].Category 		= "Business";
PropertyTable[27].Description 	= "With a small back room, this is great for gun-traders.";
PropertyTable[27].Mat 			= "hiddenshop";
PropertyTable[27].Cost 			= 4500;
PropertyTable[27].PrimaryOwner 	= PropertyTable[27].PrimaryOwner || nil;
PropertyTable[27].Doors 			= {
{ Index = 1826 ,Vector(4238, 7077, 118.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1833 ,Vector(3774, 6941, 118.25), 'models/props_c17/door01_left.mdl', '' },


};
PropertyTable[27].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[27].Name )
	

end;
PropertyTable[27].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[27].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[27].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[27].Name )


end; 
PropertyTable[28] = {};
PropertyTable[28].ID 			= 28;
PropertyTable[28].Name 			= "Industrial Shop";
PropertyTable[28].Category 		= "Business";
PropertyTable[28].Description 	= "A small shop with see-through windows.";
PropertyTable[28].Mat 			= "industrialshop";
PropertyTable[28].Cost 			= 3500;
PropertyTable[28].PrimaryOwner 	= PropertyTable[28].PrimaryOwner || nil;
PropertyTable[28].Doors 			= {
{ Index = 1837 ,Vector(4238, 7461, 118.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1838 ,Vector(3766, 7325, 118.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[28].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[28].Name )
	

end;
PropertyTable[28].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[28].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[28].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[28].Name )


end; 


PropertyTable[29] = {};
PropertyTable[29].ID 			= 29;
PropertyTable[29].Name 			= "Beach House 1";
PropertyTable[29].Category 		= "Housing";
PropertyTable[29].Description 	= "Encased, no windows.";
PropertyTable[29].Mat 			= "beachhouse1";
PropertyTable[29].Cost 			= 3000;
PropertyTable[29].PrimaryOwner 	= PropertyTable[29].PrimaryOwner || nil;
PropertyTable[29].Doors 			= {
{ Index = 1315 ,Vector(-3453.1999511719, 13717, 240.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1317 ,Vector(-3508, 14171.799804688, 240.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1316 ,Vector(-3508, 14035.799804688, 240.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1318 ,Vector(-3444, 14171.799804688, 240.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[29].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[29].Name )
	

end;
PropertyTable[29].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[29].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[29].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[29].Name )


end;
PropertyTable[30] = {};
PropertyTable[30].ID 			= 30;
PropertyTable[30].Name 			= "Small Room 1";
PropertyTable[30].Category 		= "Housing";
PropertyTable[30].Description 	= "Squat in the worst of times, but at least you have a light.";
PropertyTable[30].Mat 			= "smallroom";
PropertyTable[30].Cost 			= 1000;
PropertyTable[30].PrimaryOwner 	= PropertyTable[30].PrimaryOwner || nil;
PropertyTable[30].Doors 			= {
{ Index = 1390 ,Vector(-499, -8015, 115), 'models/props_c17/door01_left.mdl', '' },


};
PropertyTable[30].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[30].Name )
	

end;
PropertyTable[30].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[30].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[30].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[30].Name )


end;
PropertyTable[31] = {};
PropertyTable[31].ID 			= 31;
PropertyTable[31].Name 			= "Small Room 2";
PropertyTable[31].Category 		= "Housing";
PropertyTable[31].Description 	= "You have a room to hide your wife in?";
PropertyTable[31].Mat 			= "smallroom2";
PropertyTable[31].Cost 			= 1250;
PropertyTable[31].PrimaryOwner 	= PropertyTable[31].PrimaryOwner || nil;
PropertyTable[31].Doors 			= {
{ Index = 1392 ,Vector(-1019, -8015.1801757813, 115), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[31].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[31].Name )
	

end;
PropertyTable[31].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[31].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[31].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[31].Name )


end;
PropertyTable[32] = {};
PropertyTable[32].ID 			= 32;
PropertyTable[32].Name 			= "Cityscape Warehouse";
PropertyTable[32].Category 		= "Business";
PropertyTable[32].Description 	= "With lots of windows to cover, this warehouse shows everything but nothing.";
PropertyTable[32].Mat 			= "cityscapewarehouse";
PropertyTable[32].Cost 			= 10000;
PropertyTable[32].PrimaryOwner 	= PropertyTable[32].PrimaryOwner || nil;
PropertyTable[32].Doors 			= {
{ Index = 2757 ,Vector(2716, -7633, 158), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[32].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[32].Name )
	

end;
PropertyTable[32].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[32].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[32].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[32].Name )


end;
PropertyTable[33] = {};
PropertyTable[33].ID 			= 33;
PropertyTable[33].Name 			= "Hersch Warehouse";
PropertyTable[33].Category 		= "Business";
PropertyTable[33].Description 	= "Lacking more than it can make up for.";
PropertyTable[33].Mat 			= "hersh";
PropertyTable[33].Cost 			= 22599;
PropertyTable[33].PrimaryOwner 	= PropertyTable[33].PrimaryOwner || nil;
PropertyTable[33].Doors 			= {
{ Index = 2720 ,Vector(4198, -8160, 158), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2722 ,Vector(4507, -8194, 174.5), '*152', '' },
{ Index = 2723 ,Vector(4397, -8194, 174.5), '*153', '' },
{ Index = 2725 ,Vector(5266, -8194, 174.5), '*155', '' },
{ Index = 2724 ,Vector(5376, -8194, 174.5), '*154', '' },
{ Index = 2721 ,Vector(5923.009765625, -7688, 156.5), '*151', '' },
{ Index = 2726 ,Vector(6271.009765625, -7688, 156.5), '*156', '' },
{ Index = 2727 ,Vector(6619.009765625, -7688, 156.5), '*157', '' },

};
PropertyTable[33].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[33].Name )
	

end;
PropertyTable[33].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[33].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[33].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[33].Name )


end;
PropertyTable[34] = {};
PropertyTable[34].ID 			= 34;
PropertyTable[34].Name 			= "Country House 1";
PropertyTable[34].Category 		= "Housing";
PropertyTable[34].Description 	= "Revealing as all hell.";
PropertyTable[34].Mat 			= "country1";
PropertyTable[34].Cost 			= 2500;
PropertyTable[34].PrimaryOwner 	= PropertyTable[34].PrimaryOwner || nil;
PropertyTable[34].Doors 			= {
{ Index = 1414 ,Vector(7472, 4246.7998046875, 58.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1416 ,Vector(7316, 4154.7998046875, 58.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1415 ,Vector(7316, 4338.7998046875, 58.25), 'models/props_c17/door01_left.mdl', '' },
};
PropertyTable[34].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[34].Name )
	

end;
PropertyTable[34].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[34].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[34].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[34].Name )


end;
PropertyTable[35] = {};
PropertyTable[35].ID 			= 36;
PropertyTable[35].Name 			= "Country House 2";
PropertyTable[35].Category 		= "Housing";
PropertyTable[35].Description 	= "Without anyone being able to see me, I would be happier.";
PropertyTable[35].Mat 			= "country2";
PropertyTable[35].Cost 			= 2750;
PropertyTable[35].PrimaryOwner 	= PropertyTable[35].PrimaryOwner || nil;
PropertyTable[35].Doors 			= {
{ Index = 1407 ,Vector(8164, 3925.1999511719, 58.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1408 ,Vector(8320, 3833.1999511719, 58.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1409 ,Vector(8320, 4017.1999511719, 58.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[35].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[35].Name )
	

end;
PropertyTable[35].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[35].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[35].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[35].Name )


end;
PropertyTable[36] = {};
PropertyTable[36].ID 			= 36;
PropertyTable[36].Name 			= "Country House 3";
PropertyTable[36].Category 		= "Housing";
PropertyTable[36].Description 	= "This is the one at the entrance.";
PropertyTable[36].Mat 			= "country3";
PropertyTable[36].Cost 			= 3000;
PropertyTable[36].PrimaryOwner 	= PropertyTable[36].PrimaryOwner || nil;
PropertyTable[36].Doors 			= {
{ Index = 1400 ,Vector(8329.2001953125, 3278, 58.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1401 ,Vector(8237.2001953125, 3122, 58.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1402 ,Vector(8421.2001953125, 3122, 58.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[36].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[36].Name )
	

end;
PropertyTable[36].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[36].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[36].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[36].Name )


end;
PropertyTable[37] = {};
PropertyTable[37].ID 			= 37;
PropertyTable[37].Name 			= "Country House 4";
PropertyTable[37].Category 		= "Housing";
PropertyTable[37].Description 	= "You get some flex with this one I admit.";
PropertyTable[37].Mat 			= "country4";
PropertyTable[37].Cost 			= 3400;
PropertyTable[37].PrimaryOwner 	= PropertyTable[37].PrimaryOwner || nil;
PropertyTable[37].Doors 			= {
{ Index = 2780 ,Vector(9930, 3365.0100097656, 61), '*158', '' },
{ Index = 2774 ,Vector(9853.2001953125, 3124, 58.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2775 ,Vector(10077.200195313, 3176, 58.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[37].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[37].Name )
	

end;
PropertyTable[37].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[37].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[37].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[37].Name )


end;
PropertyTable[38] = {};
PropertyTable[38].ID 			= 38;
PropertyTable[38].Name 			= "Country Church";
PropertyTable[38].Category 		= "Business";
PropertyTable[38].Type 		= 1;
PropertyTable[38].Description 	= "Beaten little thing, hope people will still come to it.";
PropertyTable[38].Mat 			= "countrychurch";
PropertyTable[38].Cost 			= 1400000;
PropertyTable[38].PrimaryOwner 	= PropertyTable[38].PrimaryOwner || nil;
PropertyTable[38].Doors 			= {
{ Index = 1424 ,Vector(9463, 4517, 73), '*3', '' },
{ Index = 1423 ,Vector(9463, 4441, 73), '*2', '' },


};

PropertyTable[38].BusinessInformation = {
	
	Type = 2;	
	Scalar = 1;	
	EnterLoc = {Vector(9574.627930, 4485.715820 ,15.053741),Angle(0,0 ,0.000000)};	
	ExitLoc = {Vector( 9437.098633, 4484.623047 ,13.968750),Angle(0,-180,0)};	
	DisplayProps = {
		/*
		{"EntityClass", Vector(Position), Angle(Angle), model,Nocollide};
		*//*
	};	
	Tag = "cchurch",
	BusinessInitIdentifier = "dtstr";
	Upgrades = {
	};
}
PropertyTable[38].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[38].Name )
	

end;
PropertyTable[38].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[38].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[38].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[38].Name )


end;
PropertyTable[39] = {};
PropertyTable[39].ID 			= 39;
PropertyTable[39].Name 			= "Suburban House 1";
PropertyTable[39].Category 		= "Housing";
PropertyTable[39].Description 	= "Luxurious as all hell, but also super spacious. Look at that garden!";
PropertyTable[39].Mat 			= "suburbs4";
PropertyTable[39].Cost 			= 5500;
PropertyTable[39].PrimaryOwner 	= PropertyTable[39].PrimaryOwner || nil;
PropertyTable[39].Doors 			= {
{ Index = 1644 ,Vector(5374, 13623.5, 119.5), '*13', '' },
{ Index = 1691 ,Vector(5483.5, 14118, 111.09999847412), '*20', '' },
{ Index = 1650 ,Vector(5274, 13872, 144), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1649 ,Vector(5101, 13657.900390625, 144), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1651 ,Vector(5171, 13753, 144), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1652 ,Vector(4759, 13817, 144), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1654 ,Vector(4671, 13889, 144), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1653 ,Vector(4571, 13817, 144), 'models/props_c17/door01_left.mdl', '' },


};
PropertyTable[39].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[39].Name )
	

end;
PropertyTable[39].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[39].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[39].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[39].Name )


end;
PropertyTable[40] = {};
PropertyTable[40].ID 			= 40;
PropertyTable[40].Name 			= "Suburban House 2";
PropertyTable[40].Category 		= "Housing";
PropertyTable[40].Description 	= "Revealing more of the property, but having the biggest garden. Sexy";
PropertyTable[40].Mat 			= "suburbs1";
PropertyTable[40].Cost 			= 8800;
PropertyTable[40].PrimaryOwner 	= PropertyTable[40].PrimaryOwner || nil;
PropertyTable[40].Doors 			= {
{ Index = 1686 ,Vector(2237.2099609375, 13281, 111.09999847412), '*17', '' },
{ Index = 1620 ,Vector(2752, 13346.5, 120), '*10', '' },
{ Index = 1602 ,Vector(2858, 13796, 112.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1599 ,Vector(2820, 14050, 48.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1600 ,Vector(2820, 14248, 48.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1603 ,Vector(2690, 14108, 176.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1604 ,Vector(2736, 14172, 176.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1601 ,Vector(2984, 13796, 112.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1602 ,Vector(2858, 13796, 112.25), 'models/props_c17/door01_left.mdl', '' },


};
PropertyTable[40].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[40].Name )
	

end;
PropertyTable[40].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[40].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[40].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[40].Name )


end;


PropertyTable[41] = {};
PropertyTable[41].ID 			= 41;
PropertyTable[41].Name 			= "Suburban House 3";
PropertyTable[41].Category 		= "Housing";
PropertyTable[41].Description 	= "An antique, but you have a garage nonetheless";
PropertyTable[41].Mat 			= "suburbs3";
PropertyTable[41].Cost 			= 4500;
PropertyTable[41].PrimaryOwner 	= PropertyTable[41].PrimaryOwner || nil;
PropertyTable[41].Doors 			= {
{ Index = 1647 ,Vector(5120.2001953125, 11335.700195313, 177), '*16', '' },
{ Index = 1646 ,Vector(5008.2001953125, 11335.700195313, 177), '*15', '' },
{ Index = 1581 ,Vector(4276.2001953125, 11000.200195313, 116), '*5', '' },
{ Index = 1583 ,Vector(4444.2001953125, 11107.200195313, 116), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1582 ,Vector(4511.2001953125, 11220.200195313, 116), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[41].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[41].Name )
	

end;
PropertyTable[41].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[41].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[41].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[41].Name )


end;
PropertyTable[42] = {};
PropertyTable[42].ID 			= 42;
PropertyTable[42].Name 			= "Suburban House 4";
PropertyTable[42].Category 		= "Housing";
PropertyTable[42].Description 	= "Decorated with a nice garden and lots of rooms, this one has multiple stories too.";
PropertyTable[42].Mat 			= "suburbs2";
PropertyTable[42].Cost 			= 8500;
PropertyTable[42].PrimaryOwner 	= PropertyTable[42].PrimaryOwner || nil;
PropertyTable[42].Doors 			= {
{ Index = 1689 ,Vector(2589.9699707031, 11877.200195313, 111.09999847412), '*18', '' },
{ Index = 1595 ,Vector(2537, 11724, 113), '*9', '' },
{ Index = 1693 ,Vector(2084, 11610, 112.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1626 ,Vector(2382, 11604, 112.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1625 ,Vector(2588, 11480, 176.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1628 ,Vector(2276, 11824, 240.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1627 ,Vector(2388, 11808, 240.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[42].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[42].Name )
	

end;
PropertyTable[42].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[42].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[42].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[42].Name )

 
end;

PropertyTable[43] = {};
PropertyTable[43].ID 			= 43;
PropertyTable[43].Name 			= "Blue Store";
PropertyTable[43].Category 		= "Business";
PropertyTable[43].Description 	= "A shop with blue wallpaper, dedicated to class.";
PropertyTable[43].Mat 			= "bluedowntownshop";
PropertyTable[43].Cost 			= 6500;
PropertyTable[43].JPGOverride	= true;
PropertyTable[43].PrimaryOwner 	= PropertyTable[43].PrimaryOwner || nil;
PropertyTable[43].Doors 			= {
{ Index = 3377 ,Vector(-10296, -8858, 126.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[43].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[43].Name )
	

end;
PropertyTable[43].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[43].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[43].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[43].Name )


end;
PropertyTable[44] = {};
PropertyTable[44].ID 			= 44;
PropertyTable[44].Name 			= "Red Store";
PropertyTable[44].Category 		= "Business";
PropertyTable[44].Description 	= "The red wallpaper makes it unique.";
PropertyTable[44].Mat 			= "reddowntownshop";
PropertyTable[44].Cost 			= 8200;
PropertyTable[44].JPGOverride	= true;
PropertyTable[44].PrimaryOwner 	= PropertyTable[44].PrimaryOwner || nil;
PropertyTable[44].Doors 			= {
{ Index = 3376 ,Vector(-10296, -9114, 126.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3387 ,Vector(-10831, -9249, 126.25), 'models/props_c17/door01_left.mdl', '' },
};
PropertyTable[44].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[44].Name )
	

end;
PropertyTable[44].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[44].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[44].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[44].Name )


end;
PropertyTable[45] = {};
PropertyTable[45].ID 			= 45;
PropertyTable[45].Name 			= "Studio Loft";
PropertyTable[45].Category 		= "Housing";
PropertyTable[45].Description 	= "Quite a ridiculus price for such small space.";
PropertyTable[45].Mat 			= "downtownluxurysuit2";
PropertyTable[45].JPGOverride	= true;
PropertyTable[45].Cost 			= 11000;
PropertyTable[45].PrimaryOwner 	= PropertyTable[45].PrimaryOwner || nil;
PropertyTable[45].Doors 			= {
{ Index = 3378 ,Vector(-10840, -9002, 301.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3388 ,Vector(-10711, -8972, 301.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[45].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[45].Name )
	

end;
PropertyTable[45].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[45].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[45].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[45].Name )


end;

PropertyTable[46] = {};
PropertyTable[46].ID 			= 46;
PropertyTable[46].Name 			= "Downtown Shop";
PropertyTable[46].Category 		= "Business";
PropertyTable[46].Description 	= "Less windows, but also more space.";
PropertyTable[46].Mat 			= "downtownstore";
PropertyTable[46].Cost 			= 5600;
PropertyTable[46].PrimaryOwner 	= PropertyTable[46].PrimaryOwner || nil;
PropertyTable[46].Doors 			= {

{ Index = 2496 ,Vector(-6454, -10258, 127.5), '*64', '' },


};
PropertyTable[46].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[46].Name )
	

end;
PropertyTable[46].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[46].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[46].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[46].Name )


end;

PropertyTable[47] = {};
PropertyTable[47].ID 			= 47;
PropertyTable[47].Name 			= "Beach House 2";
PropertyTable[47].Category 		= "Housing";
PropertyTable[47].Description 	= "No windows, but you got a parking spot.";
PropertyTable[47].Mat 			= "beachhouse2";
PropertyTable[47].Cost 			= 4000;
PropertyTable[47].PrimaryOwner 	= PropertyTable[47].PrimaryOwner || nil;
PropertyTable[47].Doors 			= {
{ Index = 1305 ,Vector(-4413.2001953125, 13717, 240.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1308 ,Vector(-4404, 14171.799804688, 240.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1307 ,Vector(-4468, 14171.799804688, 240.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1306 ,Vector(-4468, 14035.799804688, 240.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[47].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[47].Name )
	

end;
PropertyTable[47].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[47].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[47].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[47].Name )


end;
PropertyTable[48] = {};
PropertyTable[48].ID 			= 48;
PropertyTable[48].Name 			= "Beach House 3";
PropertyTable[48].Category 		= "Housing";
PropertyTable[48].Description 	= "With much improvement to other houses nearby, you get a frame.";
PropertyTable[48].Mat 			= "beachhouse3";
PropertyTable[48].Cost 			= 5000;
PropertyTable[48].PrimaryOwner 	= PropertyTable[48].PrimaryOwner || nil;
PropertyTable[48].Doors 			= {
{ Index = 1564 ,Vector(-4486.7998046875, 12153, 286.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1562 ,Vector(-4612, 11658.200195313, 286.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1563 ,Vector(-4612, 11754.200195313, 286.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[48].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[48].Name )
	

end;
PropertyTable[48].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[48].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[48].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[48].Name )


end;
PropertyTable[49] = {};
PropertyTable[49].ID 			= 49;
PropertyTable[49].Name 			= "Beach House 4";
PropertyTable[49].Category 		= "Housing";
PropertyTable[49].Description 	= "True to the frame of its neighbor, standing still tall.";
PropertyTable[49].Mat 			= "beachhouse4";
PropertyTable[49].Cost 			= 5500;
PropertyTable[49].PrimaryOwner 	= PropertyTable[49].PrimaryOwner || nil;
PropertyTable[49].Doors 			= {
{ Index = 1573 ,Vector(-3654.8000488281, 12153, 286.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1572 ,Vector(-3780, 11754.200195313, 286.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1571 ,Vector(-3780, 11658.200195313, 286.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[49].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[49].Name )
	

end;
PropertyTable[49].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[49].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[49].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[49].Name )


end;
PropertyTable[50] = {};
PropertyTable[50].ID 			= 50;
PropertyTable[50].Name 			= "Beach House 5";
PropertyTable[50].Category 		= "Housing";
PropertyTable[50].Description 	= "Much closer to the beach, allowing a great view.";
PropertyTable[50].Mat 			= "beachhouse5";
PropertyTable[50].Cost 			= 6000;
PropertyTable[50].PrimaryOwner 	= PropertyTable[50].PrimaryOwner || nil;
PropertyTable[50].Doors 			= {
{ Index = 1327 ,Vector(-5846.7998046875, 13132, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1325 ,Vector(-5972, 12637.200195313, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1326 ,Vector(-5972, 12733.200195313, 288.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[50].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[50].Name )
	

end;
PropertyTable[50].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[50].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[50].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[50].Name )


end;
PropertyTable[51] = {};
PropertyTable[51].ID 			= 51;
PropertyTable[51].Name 			= "Beach House 6";
PropertyTable[51].Category 		= "Housing";
PropertyTable[51].Description 	= "Lots of view, and a big ol' pond.";
PropertyTable[51].Mat 			= "beachhouse6";
PropertyTable[51].Cost 			= 6500;
PropertyTable[51].PrimaryOwner 	= PropertyTable[51].PrimaryOwner || nil;
PropertyTable[51].Doors 			= {
{ Index = 1725 ,Vector(-6131.2001953125, 14444, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1724 ,Vector(-6006, 14842.799804688, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1723 ,Vector(-6006, 14938.799804688, 288.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[51].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[51].Name )
	

end;
PropertyTable[51].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[51].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[51].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[51].Name )


end;
PropertyTable[52] = {};
PropertyTable[52].ID 			= 52;
PropertyTable[52].Name 			= "Beach House 7";
PropertyTable[52].Category 		= "Housing";
PropertyTable[52].Description 	= "Hidden in the side of the lake, you get a huge view and decent home.";
PropertyTable[52].Mat 			= "beachhouse7";
PropertyTable[52].Cost 			= 7000;
PropertyTable[52].PrimaryOwner 	= PropertyTable[52].PrimaryOwner || nil;
PropertyTable[52].Doors 			= {
{ Index = 1732 ,Vector(-9704, 11616.799804688, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1733 ,Vector(-9704, 11520.799804688, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1734 ,Vector(-9829.2001953125, 11122, 288.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[52].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[52].Name )
	

end;
PropertyTable[52].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[52].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[52].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[52].Name )


end;
PropertyTable[53] = {};
PropertyTable[53].ID 			= 53;
PropertyTable[53].Name 			= "Beach House 8";
PropertyTable[53].Category 		= "Housing";
PropertyTable[53].Description 	= "Hidden way further down the path is this house, tight by its neighbors side.";
PropertyTable[53].Mat 			= "beachhouse8";
PropertyTable[53].Cost 			= 9000;
PropertyTable[53].PrimaryOwner 	= PropertyTable[53].PrimaryOwner || nil;
PropertyTable[53].Doors 			= {
{ Index = 1752 ,Vector(-13236, 10881.799804688, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1751 ,Vector(-13634.799804688, 11007, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1750 ,Vector(-13730.799804688, 11007, 288.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[53].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[53].Name )
	

end;
PropertyTable[53].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[53].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[53].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[53].Name )

 
end;
PropertyTable[54] = {}; 
PropertyTable[54].ID 			= 54;
PropertyTable[54].Name 			= "Beach House 9";
PropertyTable[54].Category 		= "Housing";
PropertyTable[54].Description 	= "The furthest down the path of the road by the lake.";
PropertyTable[54].Mat 			= "beachhouse9";
PropertyTable[54].Cost 			= 10000;
PropertyTable[54].PrimaryOwner 	= PropertyTable[54].PrimaryOwner || nil;
PropertyTable[54].Doors 			= {
{ Index = 1743 ,Vector(-13711.200195313, 11890, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1741 ,Vector(-13586, 12384.799804688, 288.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1742 ,Vector(-13586, 12288.799804688, 288.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[54].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[54].Name )
	

end;
PropertyTable[54].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[54].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[54].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[54].Name )


end;/*
PropertyTable[55] = {};
PropertyTable[55].ID 			= ;
PropertyTable[55].Name 			= "";
PropertyTable[55].Category 		= "";
PropertyTable[55].Description 	= "";
PropertyTable[55].Mat 			= "";
PropertyTable[55].Cost 			= ;
PropertyTable[55].PrimaryOwner 	= PropertyTable[55].PrimaryOwner || nil;
PropertyTable[55].Doors 			= {

};
PropertyTable[55].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[55].Name )
	

end;
PropertyTable[55].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[55].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[55].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[55].Name )


end;*//*
PropertyTable[56] = {};
PropertyTable[56].ID 			= 56;
PropertyTable[56].Name 			= "Studio Loft 2";
PropertyTable[56].Category 		= "Housing";
PropertyTable[56].Description 	= "With very much spacious room, and huge windows it's great to live at.";
PropertyTable[56].Mat 			= "downtownluxurysuit1";
PropertyTable[56].Cost 			= 8500;
PropertyTable[56].PrimaryOwner 	= PropertyTable[56].PrimaryOwner || nil;
PropertyTable[56].Doors 			= {
{ Index = 3379 ,Vector(-10840, -9082, 301.25), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3380 ,Vector(-10729, -9212, 301.25), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[56].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[56].Name )
	

end;
PropertyTable[56].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[56].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[56].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[56].Name )


end;
PropertyTable[57] = {};
PropertyTable[57].ID 			= 57;
PropertyTable[57].Name 			= "Industrial Shredding Warehouse";
PropertyTable[57].Category 		= "Business";
PropertyTable[57].Description 	= "Huge space but kinda expensive.";
PropertyTable[57].Mat 			= "industrialwarehouse";
PropertyTable[57].Cost 			= 34500;
PropertyTable[57].PrimaryOwner 	= PropertyTable[57].PrimaryOwner || nil;
PropertyTable[57].Doors 			= {
{ Index = 2186 ,Vector(3467, 4098, 117), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2172 ,Vector(3568.0100097656, 4102, 126), '*49', '' },
{ Index = 2171 ,Vector(3704.0100097656, 4102, 126), '*48', '' },

};
PropertyTable[57].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[57].Name )
	

end;
PropertyTable[57].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[57].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[57].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[57].Name )


end;
PropertyTable[58] = {};
PropertyTable[58].ID 			= 58;
PropertyTable[58].Name 			= "Industrial Compound";
PropertyTable[58].Category 		= "Business";
PropertyTable[58].Description 	= "Tow truck drivers love this one.";
PropertyTable[58].Mat 			= "industrialcompound";
PropertyTable[58].Cost 			= 15600;
PropertyTable[58].PrimaryOwner 	= PropertyTable[58].PrimaryOwner || nil;
PropertyTable[58].Doors 			= {
{ Index = 2781 ,Vector(1312, 4603, 144), '*159', '' },
{ Index = 2802 ,Vector(937, 4220, 136), '*165', '' },
{ Index = 2803 ,Vector(937, 4101, 136), '*166', '' },
{ Index = 2798 ,Vector(743, 4093, 126.28099822998), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2785 ,Vector(694, 4067, 136), '*161', '' },
{ Index = 2801 ,Vector(694, 3851, 136), '*164', '' },
{ Index = 2786 ,Vector(566, 4571, 126.28099822998), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2784 ,Vector(845, 4592, 126.28099822998), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2783 ,Vector(845, 4528, 126.28099822998), 'models/props_c17/door01_left.mdl', '' },

};
PropertyTable[58].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[58].Name )
	

end;
PropertyTable[58].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[58].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[58].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[58].Name )


end;
/*
PropertyTable[59] = {};
PropertyTable[59].ID 			= ;
PropertyTable[59].Name 			= "";
PropertyTable[59].Category 		= "";
PropertyTable[59].Description 	= "";
PropertyTable[59].Mat 			= "";
PropertyTable[59].Cost 			= ;
PropertyTable[59].PrimaryOwner 	= PropertyTable[59].PrimaryOwner || nil;
PropertyTable[59].Doors 			= {

};
PropertyTable[59].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[59].Name )
	

end;
PropertyTable[59].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[59].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[59].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[59].Name )


end;
PropertyTable[60] = {};
PropertyTable[60].ID 			= ;
PropertyTable[60].Name 			= "";
PropertyTable[60].Category 		= "";
PropertyTable[60].Description 	= "";
PropertyTable[60].Mat 			= "";
PropertyTable[60].Cost 			= ;
PropertyTable[60].PrimaryOwner 	= PropertyTable[60].PrimaryOwner || nil;
PropertyTable[60].Doors 			= {

};
PropertyTable[60].OnSold 			= function( _p )

	_p:Notify( "You have sold " .. PropertyTable[60].Name )
	

end;
PropertyTable[60].CanBuy 			= function( _p )

	return true; // No Restrictions

end; 
PropertyTable[60].PostCantBuy 	= function( _p , bool )
	if bool then // You bought it!

	else // You couldn't buy it!
	
	end
end
PropertyTable[60].OnBought 		= function( _p )

	_p:Notify( "You have bought " .. PropertyTable[60].Name )


end;
*//*
for k , v in pairs( PropertyTable ) do

	SetupProperty( v ) 

end
*/
//fsrp.PropertyTable = PropertyTable;
/*
for k , v in pairs( PropertyTable ) do 

	SetupOtherMapProperties(v, "rp_evocity_v33x")

end
*/