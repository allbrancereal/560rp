

function applyMatrixRowsToVec3(v, r1, r2, r3)
-- Let M be a matrix with rows r1, r2, and r3. Return M*v.
    return Vector(v:dot(r1), v:dot(r2), v:dot(r3))
end

surface.CreateFont("RuleBoardFont",{font = "Helvetica",size = 98,weight = 800,antialias = true})
surface.CreateFont("RuleBoardFontBold",{font = "Helvetica",size = 140,weight = 800,antialias = true})
surface.CreateFont("RuleBoardFontSmall",{font = "Helvetica",size = 70,weight = 800,antialias = true})

local Rules = {
"1) Grouping up in a organization will \nalways yield more profit.",
"2) The following keys are bound: \nF1, O, C, J, K, M, I, B.",
"3) You can purchase illegal businesses with\na computer.\n4) Do not use unrealistic means of killing players.\n",
"\n5) Bringing people to the server will guarantee\nyou rewards.",
}

function DrawRuleBoard()
	local Header = " Welcome to the WestCoastRP"
	local Header2 = "Four Main Guidelines"
/*	cam.Start3D2D( Vector(-7124, -9294, 415), Angle(180, 0, 270), 0.15 )
		draw.RoundedBox(1, -10, -20, 1625, 1610, Color(128,255,0,255))
		draw.RoundedBox(1, 0, -10, 1605, 1590, Color(0,0,0,255))
		draw.RoundedBox(1, 20, 120, 1560, 1440, Color(255,211,93,10))
		local Cos = math.abs(math.sin(CurTime() * 4))
		local Cos2 = math.abs(math.sin(CurTime() * 2))
		local Cos3 = math.abs(math.sin(CurTime() * 3))
		draw.DrawText(Header, "RuleBoardFont", 30, 0, Color( 50, 50, math.Clamp(150 * Cos, 75, 255), 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText("_________________________________", "RuleBoardFont", 16, 0, Color( 0, 0, math.Clamp(150 * Cos, 75, 255), 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText(Header2, "RuleBoardFont", 460, 190, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText("___________________", "RuleBoardFont", 447.5, 190, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
		local godown = 200
		for k, v in pairs(Rules) do
			godown = godown + 175
			draw.DrawText(v, "RuleBoardFont", 50, godown, Color(200,200,200,255), TEXT_ALIGN_LEFT )
		end
		draw.DrawText("- Read the rest of the rules in your F1 menu -", "RuleBoardFontSmall", 800, 1220, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText("www.560rp.com", "RuleBoardFontBold", 800, 1400, Color( math.Clamp(150 * Cos3, 0, 255), 0,75, 255 ), TEXT_ALIGN_CENTER )
    cam.End3D2D()
*/
	/*cam.Start3D2D( Vector(-2910.304199, -1783.331909 , 100), Angle(180, -90, 270), 0.15 )
		draw.RoundedBox(1, -10, -20, 1625, 1610, Color(25,25,25,255))
		draw.RoundedBox(1, 0, -10, 1605, 1590, Color(0,0,0,255))
		draw.RoundedBox(1, 20, 120, 1560, 1440, Color(128,128,128,10))
		local Cos = math.abs(math.sin(CurTime() * 4))
		local Cos2 = math.abs(math.sin(CurTime() * 2))
		local Cos3 = math.abs(math.sin(CurTime() * 3))
		draw.DrawText(Header, "RuleBoardFont", 45, 0, Color( 50, 50, math.Clamp(150 * Cos, 75, 255), 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText("_________________________________", "RuleBoardFont", 16, 0, Color( 0, 0, math.Clamp(150 * Cos, 75, 255), 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText(Header2, "RuleBoardFont", 420, 190, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText("___________________", "RuleBoardFont", 410, 190, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
		local godown = 200
		for k, v in pairs(Rules) do
			godown = godown + 175
			draw.DrawText(v, "RuleBoardFontSmall", 50, godown, Color(200,200,200,255), TEXT_ALIGN_LEFT )
		end
		draw.DrawText("- Apply for a staff position in the steam group! -", "RuleBoardFontSmall", 800, 1220, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText("You will most likely get more \nsupport if you help bring players about.", "RuleBoardFontSmall", 800, 1400, Color( 255,255, 255 ), TEXT_ALIGN_CENTER )
		//draw.DrawText("", "RuleBoardFontSmall", 800, 1350, Color( 255, 255, 255,255), TEXT_ALIGN_CENTER )
    cam.End3D2D()*/


end
//hook.Add("PostDrawOpaqueRenderables", "DrawRuleBoard", DrawRuleBoard);
function rotationVectors(u, angle)
-- Returns three 3D vectors corresponding to the rows of a matrix
-- implementing a rotation of the given angle around the given axis.
    local m = Matrix()
    m = m:rotate(angle, u.x, u.y, u.z)
    return  Vector(m[1], m[2], m[3]),
            Vector(m[5], m[6], m[7]),
            Vector(m[9], m[10], m[11])

--[[
    -- The following is pretty efficient, but using whole-matrix operations as is
    -- done above is faster still. Also, this expanded form requires a unit vector u.
    local c = math.cos(angle)
    local s = math.sin(angle)
    local d = 1-c
    local su = s*u
    local du = d*u
    local r1 = du.x*u + vec3(c, su.z, -su.y)
    local r2 = du.y*u + vec3(-su.z, c, su.x)
    local r3 = du.z*u + vec3(su.y, -su.x, c)
    return r1, r2, r3
]]--
end

function rotateVec3(v, u, angle)
--  Return vector v rotated angle degrees around vector u.
    return applyMatrixRowsToVec3(v, rotationVectors(u, angle))
end
function draw.Box(x, y, w, h, col)
	surface.SetDrawColor(col)
	surface.DrawRect(x, y, w, h)
end
//
// Delayed Chase / 3rdPerson Camera System - Written by Josh 'Acecool' Moser with and for Mario S. to serve as one of 2 or more Delayed Camera Positioning Tutorials ( One direct-line and one circular motion with some elasticity )
//

// So we have an accurate distance per second calculation, set up our distance units...
local UNITS_INCH		= 4/3;
local UNITS_FEET		= UNITS_INCH * 12;

// Camera Position Tracking
local __CAM_POS			= nil;

// Distance the Camera should be from the player ( behind them )
local CAM_DIST			= UNITS_FEET * 5;

// Camera corrections, since GetPos on Player is at their feet, add 72 units to z...
local CAM_HEIGHT		= Vector( 0, 0, 72 );

// Var Example - How fast does the camera try to catch up? ie speed per second
-- local CAM_CHASE_SPEED	= UNITS_FEET * 10;


//
// Func Example - How fast does the camera try to catch up? ie speed per second should be returned...
// Args: Player, Calcview Pos, Calcview Ang, CalcviewFOV, Current Camera Position, Current Camera Target, Player Forward Normal
//
function CAM_CHASE_SPEED( _p, _default_pos, _default_ang, _default_fov, _pos, _target, _normal )
	// Get the current distance the target is away from the current camera position
	local _dist = _pos:Distance( _target );
	if _p:GetMoveType() == MOVETYPE_NOCLIP then
		return UNITS_FEET * 100;
	end
	if ( _dist > CAM_DIST * 5 ) then
	
		return UNITS_FEET * 75;
		
	elseif ( _dist > CAM_DIST * 2 ) then
	
		return UNITS_FEET * 40;
		
	end

	// Default speed...
	return UNITS_FEET * 20;
end
local convarTP = CreateClientConVar( "wc_thirdperson", 0, true, false )
local crosshairBool = CreateClientConVar( "wc_crosshair", 1, true, false )

local _UpOffset = CreateClientConVar( "wc_thirdperson_upoffset", -5, true, true )
	
local _RightOffset = CreateClientConVar( "wc_thirdperson_rightoffset", 20, true, true )
	
local _ForwardOffset = CreateClientConVar( "wc_thirdperson_forwardoffset", 0, true, true )

local _Shoulder = CreateClientConVar( "wc_thirdperson_rightshoulders", 1, true, true ) --Change this to change shoulder
local lastShoulderSwitch = 0;
function IsInThirdperson()

	return convarTP:GetBool();

end

function toggleSwitchShoulder()
	if lastShoulderSwitch < CurTime() then return end
	if _Shoulder:GetBool() == true then
	
		_Shoulder:SetBool(false)
		lastShoulderSwitch = CurTime() + 1
		
	else
	
		_Shoulder:SetBool(true)
		lastShoulderSwitch = CurTime() + 1
	end

end
local function GetBool( var, ply )
	if CLIENT then return cvars.Bool(var) end
	return ply:GetInfo( var )=="1"
end
local function GetNum( var, ply )
	if CLIENT then return cvars.Number( var ) end
	return ply:GetInfoNum( var, 0 )
end
if !fsrp.config.Vehicle then

	fsrp.config.Vehicle = {}
	
end
local DealerCameraLocations = {
		
	[1] = { pos= Vector(-1387.651 , -6212.95 , -125.926 );
		ang=Angle(7.26 , 142.129 , 0 );
	 };
	[2] = { pos=Vector(-1675.984 , -6241.286 , -125.352 );
		ang=Angle(6.204 , 43.921 , 0 );};
	[3] = { pos=Vector(-1675.184 , -6559.198 , -125.149 );
		ang=Angle(2.144 , 72.073 , 0 ); };
	[4] = {  pos=Vector(-1719.721 , -5994.862 , -125.969 );
		ang=Angle(7.028 , -35.771 , 0 ); };
	[5] = { pos=Vector(-1418.142 , -5909.812 , -125.969 );
		ang=Angle(6.896 , -124.476 , 0 ); };
	[6] = {pos=Vector(-1319.692 , -6085 , -125.969 );
		ang=Angle(6.104 , 178.105 , 0 ); };

};

local VehicleCustomization = {

	[1] = {
	pos = Vector(-2100.584 , -6200.645 , -130.969  );
	ang = Angle(2.144 , -1.415 , 0 );
	};
	[2] = {
	pos = Vector(-1980 , -5900 , -130 );
	ang = Angle(0 , -90 , 0 );
	};
	[3] = {
	pos = Vector(-1760.24 , -6153.16 , -130.969 );
	ang= Angle(3.332 , 179.557 , 0 );
	};
	[4] = {
	pos = Vector(-1900 , -6392 , -130 );
	ang = Angle(0 , 90 , 0 );
	};
}
fsrp.VCustomizationCameras = VehicleCustomization
//
// Create the ThirdPerson Delayed Chase Camera Hook...
//
hook.Add( "CalcView", "My3rdPersonDelayedFollowCamera", function( _p, _pos, _ang, _fov )
	// Reference our Player
	local _p = LocalPlayer();
	if _p:InVehicle() then return end
	
	if IsValid(_p:GetActiveWeapon())&& _p:GetActiveWeapon():GetClass() == "selfportrait_camera"  then return end
	if LocalPlayer().FSpectate then return end
	if _p:IsInModelShop() && _p:getFlag("modelshop_WardrobeBooth", 0 ) != 0 && modelchanger.config.Wardrobes[game.GetMap()] then 
	
		local _wardRobeBasePos = ( modelchanger.config.Wardrobes[game.GetMap()][_p:getFlag("modelshop_WardrobeBooth", 1 ) ].PositionOfPlayerCamera )
		local _wardRobeBaseAng = modelchanger.config.Wardrobes[game.GetMap()][ _p:getFlag("modelshop_WardrobeBooth", 1 ) ].AngleOfPlayerCamera
		local view = {}

		view.origin = _wardRobeBasePos
		view.angles = _wardRobeBaseAng
		view.fov = _fov
		view.drawviewer = true
		
		
		return view
	
		
	end
		
	if LocalPlayer():getFlag("InVCustomization", false) == true && LocalPlayer():GetPos():Distance( Vector( -1965.469 , -6170.16 , -194.969 ) ) < 2000 then 
	
		local _basePos = VehicleCustomization[LocalPlayer():getFlag( "vehicleCustomCamera", 1 )].pos
		local _baseAng = VehicleCustomization[LocalPlayer():getFlag( "vehicleCustomCamera", 1 )].ang

		local _VecAdd = Vector(_p:getFlag("vCustomXOffset" , 0 ) , _p:getFlag("vCustomYOffset",0) , _p:getFlag("vCustomzOffset" , 0 ) )
		
		_basePos = _basePos + _VecAdd;
		
		local view = {}

		view.origin = _basePos
		view.angles = _baseAng
		view.fov = _fov
		view.drawviewer = true
		
		
		return view
	
		
	end	
	if LocalPlayer():getFlag("inVehicleShop", false) == true && LocalPlayer():GetPos():Distance( Vector( -1965.469 , -6170.16 , -194.969 ) ) < 2000 then 
	
		local _basePos = DealerCameraLocations[LocalPlayer():getFlag( "vehicleCamera", 1 )].pos
		local _baseAng = DealerCameraLocations[LocalPlayer():getFlag( "vehicleCamera", 1 )].ang

		local view = {}

		view.origin = _basePos
		view.angles = _baseAng
		view.fov = _fov
		view.drawviewer = true
		
		
		return view
	
		
	end
	
	if ply:getFlag("creatingCharacter" , false ) then
			
		local view = {}

		view.origin = _pos+( _ang:Forward()*80 ) - Vector(10,-10,10)
		view.angles = _ang - Angle( 0, 200 ,0 )
		view.fov = _fov
		view.drawviewer = true
				
			
			
		return view
			
	end
		
	if convarTP:GetBool() == false then return end
	local _p = LocalPlayer( );
	//if _p:KeyDown( IN_WALK ) then return end
	
	// Make sure they're actively in the game before running this...
	if ( !IsValid( _p ) || !_p:IsPlayer( ) ) then return; end

	// Init Tracked Position - this is where the camera position is...
	__CAM_POS = ( !__CAM_POS ) && _pos || __CAM_POS;
	__CAM_ANG = ( !__CAM_ANG ) && _ang || __CAM_ANG;

	// Helper - The direction the player is looking at without angles
	local _normal = _p:GetForward( ):GetNormal( );

	local _targetPos = _p:GetPos()
	local _targetAng = _angles 

	
	// This is where we want our camera to go...
	local _target = _targetPos + CAM_HEIGHT + _normal * -CAM_DIST;
	// Helper - Allow CAM_CHASE_SPEED to be used as a function so larger distance can speed it up, or a variable.
	
		 
	local _cam_chase_speed = ( isfunction( CAM_CHASE_SPEED ) && CAM_CHASE_SPEED( _p, _pos, _ang, _fov, __CAM_POS, _target, _normal ) || CAM_CHASE_SPEED );
 
	if _pos:Distance( _p:GetPos() )  < 50 && _p:KeyPressed( IN_DUCK ) then _cam_chase_speed = 0 end	
	
	local _Approach = FrameTime();
	
	
	
	if ( !_p:IsInModelShop() || !_p:getFlag("creatingCharacter" , false ) )  &&  __CAM_POS:Distance( _target ) < CAM_DIST * 10 then
		
		if _Approach > 0 then
		
			// Make the camera always approach the target position
			__CAM_POS.x = math.Approach( __CAM_POS.x, _target.x, _cam_chase_speed * _Approach );
			__CAM_POS.y = math.Approach( __CAM_POS.y, _target.y, _cam_chase_speed * _Approach );
			__CAM_POS.z = math.Approach( __CAM_POS.z, _target.z, _cam_chase_speed * _Approach );
		
		end
		
	else
		
		__CAM_POS = _target;
			
	end
		
	
	// Set up our view...
	local _view = {
		origin		= __CAM_POS;
		angles		= _angles;
		fov			= _fov;
		drawviewer	= true;

	};
	
		_view.origin = __CAM_POS + (_ang:Forward()*(- math.Clamp(GetNum("wc_thirdperson_forwardoffset", ply), -10, 100) )) +
				(_ang:Up()*( math.Clamp(GetNum("wc_thirdperson_upoffset", ply), -10, 100) )) +
				(_ang:Right()*(GetBool("wc_thirdperson_rightshoulders", ply) and 1 or (-1))*( math.Clamp(GetNum("wc_thirdperson_rightoffset", ply), 0, 100) ))
			
	
		local tr_wall = util.TraceLine( {start=ply:GetShootPos(), endpos=_view.origin, filter={ply, ents.GetByIndex( ply:getFlag("pickedUpEntityIndex", 1 ) )}, mask = MASK_SOLID} )
		if tr_wall.Hit and tr_wall.HitPos then
			_view.origin = tr_wall.HitPos + (ply:GetShootPos()-tr_wall.HitPos):GetNormal()*7
		end
	
	
	
	if _p:KeyDown( IN_WALK ) then 
		_p:setFlag("isInThirdPerson", false ) 
		return
	end
	
	_p:setFlag("isInThirdPerson", true ) 
	
	return _view;
end );


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
local alphaEnt = 0;
function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

local wepsToLookFor = {
	"god_stick";
	"god_stick_admin";
	"god_stick_moderator";

}
hook.Add( "PostDrawOpaqueRenderables", "PolygonCircleTest", function()
	if crosshairBool:GetBool() == false then return end
	
	local ang = LocalPlayer():EyeAngles()
	local pos;
	local _alpha = 0;
	
		
	local moreDist = 5 - LocalPlayer():GetPos():Distance( LocalPlayer():GetEyeTrace().HitPos );
	local percOff = moreDist / (5 - 10); 
	_alpha = ( percOff * 0.05  )  * -1   
	_alpha2 = ( percOff  )   
		
	//if LocalPlayer():GetPos():Distance( LocalPlayer():GetEyeTrace().HitPos ) < 500 || table.HasValue( wepsToLookFor , LocalPlayer():GetActiveWeapon():GetClass()) then
		
		
	pos = LocalPlayer():GetEyeTrace().HitPos
			
		
	//end
	
	
	if !pos then return end
	
	pos = pos + ang:Up() * 1 + ang:Right() * 1
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90)
	pos = pos + ang:Up() * 6 + ang:Right() * 1 - ang:Forward() * 1
	if IsInThirdperson() && !LocalPlayer():KeyDown( IN_WALK ) then
		
		pos = pos + ang:Forward() * 1
	
	end
	
	if LocalPlayer() && LocalPlayer():Alive() then
	
		if  IsValid( LocalPlayer():GetActiveWeapon()) then
/*
			if LocalPlayer():GetPos():Distance( Vector(-1407.470581, -424.555969 ,0)) < 1500 || table.HasValue( wepsToLookFor , LocalPlayer():GetActiveWeapon():GetClass()) then
					
				cam.Start3D2D( Vector(-1440.470581 ,-400.555969 ,-75.031250)  , Angle(0,90,90), 1 )
					
					surface.SetFont( "Trebuchet24" )
					local x , y = surface.GetTextSize( "Bank" );
					surface.SetDrawColor( 25 ,25,25, 128 )
					surface.DrawRect( _wMod * - 75 , _hMod * -10 , _wMod * 150 , _hMod * 20 )
					draw.SimpleText( "Bank", "Trebuchet24", 0,0,Color(255,255,255,Alpha),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				cam.End3D2D()
			
			elseif LocalPlayer():GetPos():Distance( Vector( -210.613922 ,410.533813 ,-65.51699)) < 1500 || table.HasValue( wepsToLookFor , LocalPlayer():GetActiveWeapon():GetClass()) then
					
				cam.Start3D2D( Vector( -210.613922 ,410.533813 ,-65.51699)  , Angle(0,180,90), 1 )
					surface.SetFont( "Trebuchet24" )
					local x , y = surface.GetTextSize( "Consumer Goods" );
					surface.SetDrawColor( 25 ,25,25, 128 )
					surface.DrawRect( _wMod * - 60 ,_hMod * -10 , _wMod * 120 , _hMod * 20 )
					draw.SimpleText( "Postal Guy's Facials", "Trebuchet24", 0,0,Color(255,255,255,Alpha),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				cam.End3D2D()

			end
			if LocalPlayer():GetPos():Distance( Vector( -962.186401, 957.223328 ,-75.45)) < 1500 || table.HasValue( wepsToLookFor , LocalPlayer():GetActiveWeapon():GetClass()) then
					
				cam.Start3D2D( Vector( -962.186401, 957.223328 ,-60.45)  , Angle(0,0,90), 1 )
					surface.SetFont( "Trebuchet24" )
					local x , y = surface.GetTextSize( "Consumer Goods" );
					surface.SetDrawColor( 25 ,25,25, 128 )
					surface.DrawRect( _wMod * - 87.5 ,_hMod * -10 , _wMod * 170 , _hMod * 20 )
					draw.SimpleText( "Mario's Warehouse", "Trebuchet24", 0,0,Color(255,255,255,Alpha),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				cam.End3D2D()
			
			end
			*/
		end
		
	end
	
	if LocalPlayer():InVehicle() then return end
	
	cam.Start3D2D( pos  , Angle(ang.p,ang.y,ang.r), 1 )
	
	if LocalPlayer():GetEyeTrace() && LocalPlayer():GetEyeTrace().Entity && IsValid(LocalPlayer():GetEyeTrace().Entity)  and LocalPlayer():Alive() then
	
		if LocalPlayer():GetActiveWeapon() && LocalPlayer():GetPos():Distance( LocalPlayer():GetEyeTrace().HitPos ) < 500 || table.HasValue( wepsToLookFor , LocalPlayer():GetActiveWeapon():GetClass()) then
		
			alphaEnt = Lerp( 0.05 , alphaEnt , 255 * _alpha2  )
			
		else
			alphaEnt = Lerp( 0.05 , alphaEnt , 0 )
		
		end
		alphaEnt = alphaEnt
	
		//surface.SetDrawColor( 0, 0, 0, _alpha2   )
		//draw.Circle( 0,0 , _wMod * 1 * _alpha , 10 )
	else
		alphaEnt = Lerp( 0.05 , alphaEnt , 0 )
		alphaEnt = alphaEnt 
		surface.SetDrawColor( 25, 25, 25, 255 - _alpha2  )
		draw.Circle( 0,0 , _wMod * 0.75 * _alpha, 10 )
	end
	surface.SetDrawColor( 255, 255, 255, alphaEnt  )
	draw.NoTexture()
	
	if IsInThirdperson() || LocalPlayer():getFlag("isInThirdPerson", false) == true then
	
		_mod = _wMod * 55;
		
	else
	
		_mod = 0;
	
	end
	draw.Circle( 0,0 , _wMod * 0.5 * _alpha, 10 )
		
	
	cam.End3D2D()
	--Usage:
	--draw.Circle( x, y, radius, segments )

end )
/*
	local _Direction = Angle( 0,_angles.y,0):Forward()
	local _DirectionInfluence = _Direction:Dot( _normalizedAngles )
	
	local _forwardVectorWorldCoords = Angle( 0 , _angles.y, 0 ):Forward() * _MoveForwardAxis
	local _rightVectorWorldCoords	= Angle( 0 , _angles.y, 0 ):Forward() * _MoveRightAxis
	local _normalizedAngles = _forwardVectorWorldCoords + _rightVectorWorldCoords
	_normalizedAngles = _normalizedAngles:Normalize()
	local _DirectionInfluence = _Direction:Dot( _normalizedAngles )
	local _rotatedVector = _normalizedAngles:Rotate( _angles ) 
	local _YawInput = _rotatedVector * _AdjustAngle;
	local _AdjustAngle = math.Clamp( engine.TickInterval() * _DirectionInfluence * _RotationInfluence, 0 , 1 )

	*/
function draw.OutlinedBox(x, y, w, h, col, bordercol)
	surface.SetDrawColor(col)
	surface.DrawRect(x + 1, y + 1, w - 2, h - 2)
	surface.SetDrawColor(bordercol)
	surface.DrawOutlinedRect(x, y, w, h)
end

local blur = Material('pp/blurscreen')
function draw.Blur(panel, amount) -- Thanks nutscript
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255, _alpha)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat('$blur', (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

local tipTable = {
	[1] = {
		tipString = {
			"You can earn more money if you got a bank account!",
		
		},
		fn = function( _p )
			if _p:IsPlayer() && IsValid( _p ) then
			
				return _p:getBankAccount()==0;
				
			end
		end,
	};

	[2] = {
		tipString = {
			"You can subscribe to the workshop content in the F1 menu";
		};
		fn = function( _p )
		
			if _p:IsPlayer() && IsValid( _p ) then
			
				return !steamworks.IsSubscribed("1458729804");
				
			end
		end,
	};

} || {};

local _tips = {
	"Hint: You can access your Inventory by pressing I!",
	"Hint: Certain items are extremely rare, collect them all!",
	"Hint: You have a warehouse that can delete items, visit the Bank!",
	"Hint: The Drug Dealer likes to move where he goes!",
	"Hint: Press F1 and go to options for any adjustable options!",
	"Hint: You can use a computer to mine coins, change clothes, manage money and more!",
	"Hint: Meth smoke colour indicates what you need to put in the mixture!",
	"Hint: For red smoke, put in paint!",
	"Hint: For green smoke, put in paint thinner!",
	"Hint: For blue smoke, put in bleach",
	"Hint: Investing in a zone increases your payday permanently!",
	"Hint: Investing in housing makes your property price cheaper!",
	"Hint: When you start a supply mission, you have to get the product from the dealer!",
	"Hint: When you start a delivery mission you have to selll the product to the dealer then launder the money to NPC's around town!",
	"Hint: The mayor makes $12,000 per payday. He can also change the salary for everyone!",
	"Hint: The Paramedic can revive people, as long as they get there in time",
};
local _c = 1;
for i = #tipTable+1 , #tipTable+#_tips do
	tipTable[i] = {tipString = {_tips[_c]};fn = function( _p ) return true end};
	_c = _c+1
end
local showTips = CreateConVar("wc_showtips", "1", {FCVAR_ARCHIVE})

hook.Add("PlayerFullyConnected", "hookTips", function( _p )
	local lastTip;
	PreCacheAllCivillianModels( )
	
	timer.Create("ThanksTips", 600, 0 , function( )
		giveLocalTip();
	end)

end)

local lastTip;
function giveLocalTip()

	local _p = LocalPlayer();
	
	local selectedTip = tipTable[math.random(1,#tipTable)];
	
	if selectedTip.fn then
	
		shouldShow = selectedTip.fn( _p )
	
	end
	
	if !shouldShow then
		
		selectedTip = tipTable[math.random(1,#tipTable)];
			
	end
		
		
	if selectedTip.fn then
	
		shouldShow = selectedTip.fn( _p )
	
	end
		
	if shouldShow then
		
		if GetConVar("wc_showtips") && GetConVar("wc_showtips"):GetBool() then
			
			for i = 1 , #selectedTip.tipString do
				
				timer.Simple( (i - (i*.25)) + 3, function()
				
					_p:Notify( selectedTip.tipString[i] )
				
				end)
				
			end
		end

	end


end

