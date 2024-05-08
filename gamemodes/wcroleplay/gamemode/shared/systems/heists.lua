 
fsrp.heists = {}
fsrp.heists.mission = {}
fsrp.heists.config = {}

fsrp.heists.config.PanelLocations = {
	[1] = {
		PropertyID 	= 12;
		Pos			= Vector(-10474.473 , -10323.125 , 521.09 );
		Ang			= Angle(-89.878 , -11.726 , -78.221 );
	};
	[2] = {
		PropertyID  = 6;
		Pos 		= Vector(-6653.915 , -14572.109 , 127.806 );
		Ang 		= Angle(-89.972 , -179.984 , 180 );

	};
	[3] = {
		PropertyID  = 5;
		Pos 		= Vector(-3635.996 , -9301.315 , 1544.436 );
		Ang 		= Angle(-90 , -180 , 180 );
	};
	[4] = {
		PropertyID  = 33;
		Pos 		= Vector(6954.067 , -7425.366 , 157.459 );
		Ang			= Angle(-89.868 , 101.373 , -101.361 );
	};
	[5] = {
		PropertyID  = 41;
		Pos 		= Vector(4478.787 , 11334.336 , 254.553 );
		Ang 		= Angle(-89.86 , 31.54 , 58.483 );
	};
	[6] = {
		PropertyID  = 40;
		Pos 		= Vector(2569.906 , 14205.76 , 51.485 );
		Ang 		= Angle(-90 , 0 , 180 );
	};
	[7] = {
		PropertyID  = 23;
		Pos 		= Vector(-2416.29 , 8632.901 , 124.017 );
		Ang			= Angle(-89.848 , 167.726 , 102.34 );
	};
	[8] = {
		PropertyID  = 24;
		Pos 		= Vector(1584.082 , 6118.524 , 633.053 );
		Ang			= Angle(-90 , -180 , 180 );
	};
	[9] = {
		PropertyID  = 7;
		Pos 		= Vector(-10521.541 , -10342.964 , 143.449 );
		Ang 		= Angle(-89.999 , -90 , 180 );
	};

}

function fsrp.heists.config.MakeHeistPanels()
	
	if SERVER then 
		
		for k , v in pairs( ents.FindByClass( "heistplanningpanel" ) ) do
		
			v:Remove()
			
		end
		
		for k ,v in pairs( fsrp.heists.config.PanelLocations ) do
				
			local _ent = ents.Create( "heistplanningpanel" )
			_ent:SetPos( v.Pos ) 
			_ent:SetAngles( v.Ang )
			_ent:setFlag( "planningPanelProperty", v.PropertyID )
			
			_ent:Spawn()
			//_ent:GetPhysicsObject():Sleep()
			
		end
		
	end
	
end

local missionLanguage = {

		Retrieval_Vehicle 			= { "Vehicle";  Color( 2 ,153 ,57 ) } ;
		Intelligence_Scout 			= { "Scouting Area"; Color( 221 ,225 ,3)   } ;
		Intelligence_Floorplans 	= { "Floor Plans"; Color( 2 ,153 ,57 ) } ;
		Item_Weapon 				= { "Weapon";  Color( 2 ,153 ,57 ) } ;
		Item_Clothes 				= { "Clothes";Color( 2 ,153 ,57 ) } ;
		Item_Hat 					= { "Hat";  Color( 25 ,200 ,25 ) } ;
		Rendevouz					= { "Rendevouz Point";  Color( 221 ,225 ,3) };
		DriveTo						= { "Drive to the";Color( 255 ,255 ,255) } ;
		Goto						= { "Go to"; Color( 255 ,255 ,255)} ;
		Enter						= { "Enter";Color( 255 ,255 ,255) } ;
		Plant						= { "Plant";Color( 255 ,255 ,255) } ;
		Detonate					= { "Detonate"; Color( 255 ,255 ,255) } ;
		Locate						= { "Locate"; Color( 255 ,255 ,255) } ;
		Steal						= { "Steal"; Color( 255 ,255 ,255) } ;
		Return						= { "Return" ; Color( 255 ,255 ,255) } ;
		Evade						= { "Evade" ; Color( 73 ,76 ,153) } ;
		Police						= { "Police (Hide)" ; Color( 73 ,76 ,153) } ;
		Safehouse						= { "Safehouse" ; Color( 0 ,0 ,225) } ;

}

// Mission Information Table
/*
missionInformation.ID = #;
missionInformation.Name = "Nexus";
missionInformation.Description = "Robbing Nexus?";
missionInformation.PotentialTake = 40000; // per player
missionInformation.MaxPlayers    = 3 // max players intheheist
missionInformation.RequiredSetupMission = {

	[1] = {
	
		["retrieval"] = { 
			type = "car";
			vehicleclass = "auditttdm";  
			possiblelocations = { 
				Vector(0,0,0), Angle(0,0,0); 
				Vector(0,0,0), Angle(0,0,0);
			};		
		};
		
		["retrieval"] = { 
			type = "item";
			model = "";
			possiblelocations = { 
				Vector(0,0,0), Angle(0,0,0); 
				Vector(0,0,0), Angle(0,0,0);
			};
		};
		
		["intelligence"] = { 
			type = "scout";
			locationStart = Vector(0,0,0); 
			possiblelocations = { 
				Vector(0,0,0), Angle(0,0,0}; 
				Vector(0,0,0), Angle(0,0,0);
			};
		};
		
		["intelligence"] = { 
			type = "floorplans" ;
			possiblelocations = { 
				Vector(0,0,0), Angle(0,0,0}; 
				Vector(0,0,0), Angle(0,0,0);
			};
		};
		
		["item"] = { 
			type = "hat" ; 
			accepted = { 155 };
		};
		
		["item"] = { 
			type = "clothes" ;
			male = { 1,  2 , 3 ,4 };
			female = { 1 , 2 ,3 , 4};
		};
		
		["item"] = { 
			type = "weapon" , 
			possiblelocations = { 
				Vector(0,0,0), Angle(0,0,0}; 
				Vector(0,0,0), Angle(0,0,0);
			}		;
			weaponID = 40;
		};
	
	};
	
};

missionInformation.MissionObjective = {
		
	[1] = {
		MissionType = "Quick and Quiet";
		Steps = {
			
			[1] = {
				Description = {
					[1] = missionLanguage.Goto ; 
					[2] = " your " ; 
					[3] = missionLanguage.Retrieval_Vehicle;
				};
			}
			[2] = {
				Description = {
					[1] = missionLanguage.DriveTo ; 
					[2] = "the" ; 
					[3] = missionLanguage.Rendevouz;
				};
			}
			[3] = {
				Description = {
					[1] = "Ready"; 
					[2] = "the" ; 
					[3] = { "Grenades" , Color( 255 ,255 ,255 ); };
				};
			}
			[4] = {		
				Description = {
					[1] = missionLanguage.Locate; 
					[2] = "the" ; 
					[3] = { "Ventilation System", Color( 255 ,255 ,255 ) };
				};		
			};
			[5] = {		
				Description = {
					[1] = "Use "; 
					[2] = "the " ; 
					[3] = { "Grenades", Color( 255 ,255 ,255 ) };
				};		
			};		
			[6] = {		
				Description = {
					[1] = missionLanguage.Steal; 
					[2] = "the" ; 
					[3] = { "Money", Color( 255 ,255 ,255 ) };
				};		
			};		
			[7] = {		
				Description = {
					[1] = missionLanguage.Evade; 
					[2] = "the" ; 
					[3] = missionLanguage.Police;
				};		
			};
			[8] = {		
				Description = {
					[1] = missionLanguage.Return; 
					[2] = " to your " ; 
					[3] = missionLanguage.Safehouse;
				};		
			};
		
		
		};
		
	};
	[2] = {
		MissionType = "Bold and Quick";
		Steps = {
			
			[1] = {
				Description = {
					[1] = missionLanguage.Goto ; 
					[2] = " your " ; 
					[3] = missionLanguage.Retrieval_Vehicle;
				};
			}
			[2] = {
				Description = {
					[1] = missionLanguage.DriveTo ; 
					[2] = "the" ; 
					[3] = missionLanguage.Rendevouz;
				};
			}
			[3] = {		
				Description = {
					[1] =  missionLanguage.Enter; 
					[2] = "the" ; 
					[3] = { "Bank", Color( 255 ,255 ,255 ) };
				};		
			};
			[4] = {		
				Description = {
					[1] = "Tie "; 
					[2] = "the " ; 
					[3] = { "Hostages", Color( 255 ,255 ,255 ) };
					[3] = "up";
				};		
			};		
			[5] = {		
				Description = {
					[1] = missionLanguage.Steal; 
					[2] = "the" ; 
					[3] = { "Money", Color( 255 ,255 ,255 ) };
				};		
			};		
			[6] = {		
				Description = {
					[1] = missionLanguage.Evade; 
					[2] = "the" ; 
					[3] = missionLanguage.Police;
				};		
			};
			[7] = {		
				Description = {
					[1] = missionLanguage.Return; 
					[2] = " to your " ; 
					[3] = missionLanguage.Safehouse;
				};		
			};
		
		
		};
		
	};
	
};
	
*/
local missionInformation = {};
missionInformation.ID = 1;
missionInformation.Name = "Nexus";
missionInformation.Description = "Robbing Nexus?";
missionInformation.PotentialTake = 40000; // per player
missionInformation.MaxPlayers    = 3 // max players intheheist
missionInformation.VehicleInfromation	= {
	[1] = {
		class = "auds4tdm";
		missionspawns = {
			[1] = {Vector(-6877.818 , -7816.844 , 64.361 );Angle(0.003 , 179.191 , 0.402 ) }; 
			[2] = {Vector(-3910.139 , -10597.353 , 71.361 ); Angle(0.003 , 174.871 , 0.403 ) };
		};
		amountToSpawn = 1;
	};
	[2] = {
		class = "350ztdm";
		missionspawns = {
			[1] = {Vector(-6898.22 , -8769.494 , -185.167 );Angle(0 , 88.238 , 0.125 )}; 
			[2] = {Vector(-3910.139 , -10597.353 , 71.361 ); Angle(0.003 , 174.871 , 0.403 ) };
		};
		amountToSpawn = 1;
	};

};

missionInformation.RequiredSetupMission = {
	[1] = {
	
		[1] = { 
			type = "car";
			index = 1;
			possiblelocations = { 
				[1] = {Vector(5091.306 , -3841.266 , 64.367 );Angle(0.003 , -93.181 , 0.405 ) }; 
				[2] = {Vector(9637.626 , 4754.934 , 6.085 );Angle(2.462 , -92.142 , 2.76 )};
			};
			Description = {
				[1] = missionLanguage.Steal[1] .. " the" ; 
				[2] = missionLanguage.Retrieval_Vehicle;
			};		
			StartStep = function( self )
				
			
			end;
		};
		
		[2] = { 
			type = "car";
			index = 2;
			possiblelocations = { 
				[1] = {Vector(-7305.754 , -7019.42 , 64.622 ); Angle(0.1 , -179.346 , 0.104 )}; 
				[2] = { Vector(-6920.192 , -9463.171 , -183.639 ); Angle(0.004 , 89.962 , 0.403 ) };
			};		
			Description = {
				[1] = missionLanguage.Steal[1] .. " the" ; 
				[2] = missionLanguage.Retrieval_Vehicle;
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[3] = { 
			type = "item";
			model = "models/props_c17/oildrum001.mdl";
			possiblelocations = { 
				[1] = {Vector(2855.479 , 6496.692 , 85.706 ), Angle(0,0,0) }; 
				[2] = {Vector(-10629.409 , 8929.559 , 87.363 ), Angle(0,0,0) };
			};	
			Description = {
				[1] = missionLanguage.Steal[1] .. " the" ; 
				[2] = { "Tear Gas" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[4] = { 
			type = "floorplans" ;
			possiblelocations = { 
				[1] = {Vector(-6484.944 , -9296.107 , 479.312 ), Angle(0,0,0) }; 
				[2] = {Vector(-7501.58 , -7695.418 , 87.964 ), Angle(0,0,0) };
			};
			Description = {
				[1] = "Retrive the " .. missionInformation.Name;
				[2] = { "Floor Plans" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[5] = { 
			type = "weapon" , 
			possiblelocations = { 
				[1] = {Vector(0,0,0), Angle(0,0,0) }; 
				[2] = {Vector(0,0,0), Angle(0,0,0) };
			}		;
			weaponID = 40;
			Description = {
				[1] = "Craft new";
				[2] = { "Weapons" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[6] = { 
			type = "hat" ; 
			accepted = { 155 };
			Description = {
				[1] = "Purchase a";
				[2] = { "Hat (Full Cover)" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[7] = { 
			type = "clothes" ;
			male = { 1,  2 , 3 ,4 };
			female = { 1 , 2 ,3 , 4};
			Description = {
				[1] = "Purchase new";
				[2] = { "Clothes" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
	
	};
	[2] = {
	
		[1] = { 
			type = "car";
			index = 1;
			possiblelocations = { 
				[1] = {Vector(0,0,0), Angle(0,0,0) }; 
				[2] = {Vector(0,0,0), Angle(0,0,0) };
			};		
			Description = {
				[1] = missionLanguage.Steal[1] .. " the" ; 
				[2] = missionLanguage.Retrieval_Vehicle;
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[2] = { 
			type = "scout";
			locationStart = Vector(-4786.261 , -7902.788 , 214.416 ); 
			possiblelocations = { 
				[1] = {Vector(-6660.887 , -8854.706 , 88.313 ) }; 
				[2] = {Vector(-7928.687 , -8661.355 , 86.149 ) };
			};
			Description = {
				[1] = "Chose an";
				[2] = { "Entry Method" , Color( 255 ,255 ,255 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[3] = { 
			type = "hat" ; 
			accepted = { 155 };
			Description = {
				[1] = "Purchase a";
				[2] = { "Hat (Full Cover)" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
		
		[4] = { 
			type = "car";
			index = 2;
			possiblelocations = { 
				[1] = {Vector(0,0,0), Angle(0,0,0) }; 
				[2] = {Vector(0,0,0), Angle(0,0,0) };
			};		
			Description = {
				[1] = missionLanguage.Steal[1] .. " the" ; 
				[2] = missionLanguage.Retrieval_Vehicle;
			};
			StartStep = function( self )
			
			
			end;
		};
		[5] = { 
			type = "weapon" , 
			possiblelocations = { 
				[1] = {Vector(0,0,0), Angle(0,0,0) }; 
				[2] = {Vector(0,0,0), Angle(0,0,0) };
			}		;
			weaponID = 40;
			Description = {
				[1] = "Craft new";
				[2] = { "Weapons" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
		[6] = { 
			type = "clothes" ;
			male = { 1,  2 , 3 ,4 };
			female = { 1 , 2 ,3 , 4};
			Description = {
				[1] = "Purchase new";
				[2] = { "Clothes" , Color( 2 ,153 ,57 ) };
			};
			StartStep = function( self )
			
			
			end;
		};
		
	};
	
};

missionInformation.MissionObjective = {
		
	[1] = {
		MissionType = "Quick and Quiet";
		Steps = {
			
			[1] = {
				Description = {
					[1] = missionLanguage.Goto[1] .. " your" ; 
					[2] = missionLanguage.Retrieval_Vehicle;
				};
				StartStep = function( self )
				
				
				end;
			};
			[2] = {
				Description = {
					[1] = missionLanguage.DriveTo[1] .. " the" ; 
					[2] = missionLanguage.Rendevouz;
				};
				StartStep = function( self )
				
				
				end;
			};
			[3] = {
				Description = {
					[1] = "Ready the";
					[2] = { "Grenades" , Color( 255 ,255 ,255 ); };
				};
				StartStep = function( self )
				
				
				end;
			};
			[4] = {		
				Description = {
					[1] = missionLanguage.Locate[1] .. " the" ; 
					[2] = { "Ventilation System", Color( 255 ,255 ,255 ) };
				};	
				StartStep = function( self )
				
				
				end;	
			};
			[5] = {		
				Description = {
					[1] = "Use the" ; 
					[2] = { "Grenades", Color( 255 ,255 ,255 ) };
				};	
				StartStep = function( self )
				
				
				end;	
			};		
			[6] = {		
				Description = {
					[1] = missionLanguage.Steal[1] .. " the" ; 
					[2] = { "Money", Color( 255 ,255 ,255 ) };
				};	
				StartStep = function( self )
				
				
				end;	
			};		
			[7] = {		
				Description = {
					[1] = missionLanguage.Evade[1] .. " the" ; 
					[2] = missionLanguage.Police;
				};	
				StartStep = function( self )
				
				
				end;	
			};
			[8] = {		
				Description = {
					[1] = missionLanguage.Return[1] .. " to your" ; 
					[2] = missionLanguage.Safehouse;
				};	
				StartStep = function( self )
				
				
				end;	
			};
		
		
		};
		
	};
	[2] = {
		MissionType = "Bold and Quick";
		Steps = {
			
			[1] = {
				Description = {
					[1] = missionLanguage.Goto[1] .. " your" ; 
					[2] = missionLanguage.Retrieval_Vehicle;
				};
				StartStep = function( self )
				
				
				end;
			};
			[2] = {
				Description = {
					[1] = missionLanguage.DriveTo[1] .. " the" ; 
					[2] = missionLanguage.Rendevouz;
				};
				StartStep = function( self )
				
				
				end;
			};
			[3] = {		
				Description = {
					[1] =  missionLanguage.Enter[1] .. " the" ; 
					[2] = { "Bank", Color( 25 ,255 ,25 ) };
				};	
				StartStep = function( self )
				
				
				end;	
			};
			[4] = {		
				Description = {
					[1] = "Tie " .. " the" ; 
					[2] = { "Hostages", Color( 255 ,25 ,25 ) };
					[3] = "up";
				};	
				StartStep = function( self )
				
				
				end;	
			};		
			[5] = {		
				Description = {
					[1] = missionLanguage.Steal[1] .. " the" ; 
					[2] = { "Money", Color( 25 ,255 ,25 ) };
				};	
				StartStep = function( self )
				
				
				end;	
			};		
			[6] = {		
				Description = {
					[1] = missionLanguage.Evade[1] .. " the" ; 
					[2] = missionLanguage.Police;
				};	
				StartStep = function( self )
				
				
				end;	
			};
			[7] = {		
				Description = {
					[1] = missionLanguage.Return[1] .. " to your" ; 
					[2] = missionLanguage.Safehouse;
				};		
				StartStep = function( self )
				
				
				end;
			};
		
		
		};
		
	};
	
};

function SetupHeistMission( missionInformation )
	
	if !fsrp.heists.mission[missionInformation.ID] then
	
		fsrp.heists.mission[missionInformation.ID] = {};
	
	end
	
	fsrp.heists.mission[missionInformation.ID] = missionInformation;

end 

SetupHeistMission( missionInformation );

local _pMeta = FindMetaTable( 'Player' )

if SERVER then
	
	util.AddNetworkString( "heistLobbyStart" )
	util.AddNetworkString( "heistSetupMissionStart" )
	util.AddNetworkString( "heistSetupMissionEnd" )
	util.AddNetworkString( "heistStart" )
	util.AddNetworkString( "heistEnd" )
	util.AddNetworkString( "objectiveMessage" )
	util.AddNetworkString( "networkHeistInformation" )

	function _pMeta:MessageHeistObjective( tb )
		//PrintTable( tb )
		for k,  v in pairs( player.GetAll() ) do
			
			if self.heist then
					
				if v != self && self.heist.Players[v:SteamID()] then
					
					net.Start( "objectiveMessage" )
						net.WriteTable( tb )
					net.Send( v )
				
				end
				
			end
			
		end
		
		net.Start( "objectiveMessage" )
			net.WriteTable( tb )
		net.Send( self )

	end
	
	function _pMeta:StartHeistLobby( id )
		
		local heist = { Leader = self:SteamID() , HeistID = id , Players = {} , CreationTime = os.time() };
		
		
		self:SetHeistInformation( heist )		
		
		self:SetHeistDirection( 1 );

		
	end
	
	function _pMeta:SetHeistDirection( direction )
	
		local _HeistInfo = self:getFlag("heistInformation",nil);
		
		if !_HeistInfo then return self:Notify( "Can't set heist information when you aren't in a heist lobby" ) end;
		
		if !fsrp.heists.mission[_HeistInfo.HeistID].RequiredSetupMission[direction] then return end;
		if !fsrp.heists.mission[_HeistInfo.HeistID].MissionObjective[direction] then return end;
		
		if _HeistInfo.Direction then
		
			if direction != _HeistInfo.Direction then
			
				_HeistInfo.Direction = direction;
		
				_HeistInfo.SetupStep = 0;
				
			end
		
		else
		
			_HeistInfo.Direction = direction;
		
			_HeistInfo.SetupStep = 0;
			
		end
		
		self:SetHeistInformation( _HeistInfo )		
			
	end
	
	function _pMeta:SetHeistInformation( _tb ) 
	
		self:setFlag("heistInformation", _tb )
	
		local _playerSlaves = {};
		
		for k , v in pairs( _tb.Players ) do
	
			if player.GetSteamID( k ) then
			
				table.insert( _playerSlaves , player.GetSteamID( k ) )
				
			end
			
		end
		
		table.insert( _playerSlaves , self );
		
		for k , v in pairs( _playerSlaves ) do
			
			net.Start( "networkHeistInformation" ) 
				net.WriteTable( _tb )
			net.Send( v )
			
		end

	end 
	
	local _typeTable = {
		["car"] = function( _Step , _p ) 
		
		
		end;
		["item"] = function( _Step , _p ) 
		
		end;
		["hat"] = function( _Step , _p ) 
		
		end;
		["clothes"] = function( _Step , _p ) 
		
		end;
		["weapon"] = function( _Step , _p ) 
		
		end;
	
	}
	hook.Add("StartedHeistStep", "HeistStepStarted", function( ID, Direction, Step, _p )
		
		local _Heist = fsrp.heists.mission[ID];
		local _SetupMissionTable = _Heist.RequiredSetupMission;
		local _Direction = _SetupMissionTable[Direction]
		local _Step = _Direction[Step];
		
		if !_Heist || !_SetupMissionTable || !_Direction || !_Step then return end
		
		local _PlayerInfo = _p:getFlag("heistInformation",nil);
		
		if !_PlayerInfo then return _p:Notify( "Can't set heist information when you aren't in a heist lobby" ) end;
		
		local _Accomplices = _PlayerInfo.Players;
		
		local _type = _Step.type;
		
		if _typeTable[_type] then
		
			_typeTable[_type]( _Step, _p );
		
		end
		
		_PlayerInfo.IsExecutingStep = true;
		
	end )
	
	function _pMeta:DoNextHeistSetupStep( )
	
		local _HeistInfo = self:getFlag("heistInformation",nil);
		
		if !_HeistInfo then return self:Notify( "Can't set heist information when you aren't in a heist lobby" ) end;
		
		local _heistID = _HeistInfo.HeistID;
		
		local _heist = fsrp.heists.mission[_heistID];
		local _RequiredMissionDirectionSteps = _heist.RequiredSetupMission[_HeistInfo.Direction];
		
		local _hCall = hook.Run( "CanStartHeistStep" , _heistID, self ,_HeistInfo.SetupStep ) || _HeistInfo.FinishedStep && _HeistInfo.FinishedStep;
		local _fCall = true;
		
		if _HeistInfo.SetupStep + 1 > #_RequiredMissionDirectionSteps then
			
			return self:Notify( "You can not advance any steps further" )
			
		else
		
			if _RequiredMissionDirectionSteps[_HeistInfo.SetupStep] && _RequiredMissionDirectionSteps[_HeistInfo.SetupStep].StartStep then
			
				_fCall = _RequiredMissionDirection[_HeistInfo.SetupStep].StartStep( self )
							
			end
			
			if _HeistInfo.IsExecutingStep && _HeistInfo.FinishedStep then
			
				return self:Notify( "you cant execute that" )
			
			end
			
			if _hCall && _fCall then
			
				_HeistInfo.SetupStep = _HeistInfo.SetupStep + 1
				self:MessageHeistObjective( _RequiredMissionDirectionSteps[_HeistInfo.SetupStep].Description )
			
				hook.Run( "StartedHeistStep" , _heistID, _HeistInfo.Direction, _HeistInfo.SetupStep, self )
			
			end
			
			/*
			for i = 1 , #_RequiredMissionDirectionSteps do
			
				local v = _RequiredMissionDirection[i];
				
				
			end		
			*/
			
		end
		
		self:SetHeistInformation( _HeistInfo );
		
	end
	
	function _pMeta:IsOnStep( heist )
		
		local _HeistInfo = self:getFlag("heistInformation",nil);
		
		if !_HeistInfo then return false end;
		
		return ( _HeistInfo.HeistID == heist && _HeistInfo.SetupStep ) && true, _HeistInfo.SetupStep || false;
	
	end
	
	function _pMeta:StartHeistMission( )
	
		local _HeistInfo = self:getFlag("heistInformation",nil);
		
		if !_HeistInfo then return self:Notify( "You are currently not involved in a heist" ) end;
		
		
	
	end
	
else

	local _w, _h = ScrW( ), ScrH( );
	
	local SCREEN_W, SCREEN_H = 2560, 1440;
	
	local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

	net.Receive( "networkHeistInformation" , function ( _l, _p ) 
	
		LocalPlayer():setFlag("heistInformation", net.ReadTable( ) )
	
	end )
	
	net.Receive( "objectiveMessage" , function ( _l, _p ) 
	
		createHeistNotification( net.ReadTable( ) )
	
	end )
	
	local function GetNotifySplit ( tb )
			
		local _tbl = {};
		local i = 1;
		
		for k , v in pairs( tb ) do
		
			if istable( v ) then
			
				_tbl[i] = v;
			
			else
				
				_tbl[i] = { v , Color( 255 ,255 ,255 ) };
				
			end
			
			i = i + 1
			
		end
		
		return _tbl;
		
	end
	
	function createHeistNotification( tb )
		
		if hook.GetTable()["HUDPaint"]["heistObjectiveMessage"] then
		
			hook.Remove( "HUDPaint" , "heistObjectiveMessage" )
		
		end
		
		surface.PlaySound( "Friends/friend_online.wav" )
		local _alpha = 0;
		local _doneAlphaBuffer = CurTime() + 15; // + CurTime() delay until we lose alpha
		local _objectiveDesc = tb;
		
		hook.Add( "HUDPaint" , "heistObjectiveMessage", function() 
				
			surface.SetFont("Trebuchet20")
			local ShopName = "Heist Planning Panel"
			local Width, Height = surface.GetTextSize(ShopName)
		
			if CurTime() < _doneAlphaBuffer then
			
				_alpha = Lerp( 0.1, _alpha , 255 )
			
			else
				
				_alpha = Lerp( 0.1 , _alpha , 0 )
				
				if _alpha >= 254 then
				
					DestroyHeistNotification()
					
				end
				
			end
			
			surface.SetDrawColor( 255 ,255 ,255, _alpha ) 
			//surface.DrawRect( _wMod * 1180 - Width, _hMod * 1300 , _wMod * 100, _hMod * 100 )
			//draw.SimpleText( ShopName, 'Trebuchet20', _wMod * 1180 , _hMod * 1300 + Height , Color(56, 56, 56, _alpha), 1, 1);
			local _ToShowNotify = GetNotifySplit( _objectiveDesc )
			local _totW = _wMod * -175
			//PrintTable( _ToShowNotify )
			local i = 0;
			local _text = "";
			local _oldTextSize = 0;
			
			for k , v in pairs( _ToShowNotify ) do
			
				surface.SetFont( "Trebuchet20" )
				local w = surface.GetTextSize( v[1] )
				_oldTextSize =  w + _oldTextSize
				
				if i == #_ToShowNotify then
				
					_add = "."
					
				else
					_add = " ";
					
				end
				draw.SimpleText( v[1] .. _add , "Trebuchet20", ScrW() * 0.5  + (  w  + _wMod * 15 ) * i, ScrH() - _hMod * 150, Color(v[2].r, v[2].g, v[2].b, _alpha), 2);
				
				
				i = i + 1
			end
			
			/*
			for k , v in pairs( _objectiveDesc ) do
				
				if istable( v ) then
	
					_StringTbl[i] = v 
					i = i + 1
					
					_resetString = true
					
				elseif isstring( v ) then
					
					if _resetString then
					
						_StringTbl[i] = { v , Color(255,255,255) }
						_resetString = false
						PrintTable( _StringTbl[i] )
						i = i + 1
						
					else
						
						_StringTbl[i-1][1] = _StringTbl[i-1][1] .. " " .. v
					
					end
				end
				
			end
			local _totW = _wMod * -175;
			
			for k , v in pairs( _StringTbl ) do
				local _str =  string.Explode( " " , v[1] );
				local _strToF = "";
				for x , y in pairs( _str ) do
				
					_strToF = _strToF .. " " .. y;
				
				end
								
				local _wSave = surface.GetTextSize( _strToF )
			
				_totW = _wSave + _totW;
				local _add = ""
				if v[2] != Color(255,255,255) then
					
					_totW = _totW - _wMod * 25 
					_add = "!"
				
				else
				
					_totW = _totW + _wMod * 50
					
				end
				draw.SimpleText( v[1] .. _add , 'Trebuchet20', _wMod * 1180 + _totW, _hMod * 1300 + Height , Color(v[2].r, v[2].g, v[2].b, _alpha), TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT);
			
			end
			*/
			
		end )
		
	end
	
	function DestroyHeistNotification()
		
		if hook.GetTable()["HUDPaint"]["heistObjectiveMessage"] then
		
			hook.Remove( "HUDPaint" , "heistObjectiveMessage" )
		
		end
		
	end
	
end

