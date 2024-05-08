if( SERVER ) then
   AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
    SWEP.PrintName = "El Pollo Diablo v3.1 (Moderator Edition)";
    SWEP.Slot = 0;
    SWEP.SlotPos = 5;
    SWEP.DrawAmmo = false;
    SWEP.DrawCrosshair = true;

    SWEP.FirstPersonGlowSprite = Material("sprites/light_glow02_add_noz");
    SWEP.ThirdPersonGlowSprite = Material("sprites/light_glow02_add");
end

SWEP.Author         = "Mario S."

SWEP.ViewModelFOV       = 62
SWEP.ViewModelFlip      = false
SWEP.AnimPrefix  = "stunstick"

SWEP.Spawnable      = true
SWEP.AdminSpawnable          = true
 
SWEP.NextStrike = 0;
  
SWEP.ViewModel = Model( "models/weapons/v_stunstick.mdl" );
SWEP.WorldModel = Model( "models/weapons/w_stunbaton.mdl" );
  
SWEP.Sound = Sound( "weapons/stunstick/stunstick_swing1.wav" );
SWEP.Sound1 = Sound( "npc/metropolice/vo/moveit.wav" );
SWEP.Sound2 = Sound( "npc/metropolice/vo/movealong.wav" );

SWEP.Primary.ClipSize      = -1                                   // Size of a clip
SWEP.Primary.DefaultClip        = 0                    // Default number of bullets in a clip
SWEP.Primary.Automatic    = false            // Automatic/Semi Auto
SWEP.Primary.Ammo                     = ""
 
SWEP.Secondary.ClipSize  = -1                    // Size of a clip
SWEP.Secondary.DefaultClip      = 0            // Default number of bullets in a clip
SWEP.Secondary.Automatic        = false    // Automatic/Semi Auto
SWEP.Secondary.Ammo               = ""
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then

				self.Gear = 1;
        
        end
		
		self:SetWeaponHoldType( "melee" );
        
end

local SLAP_SOUNDS = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
	"physics/body/body_medium_impact_soft5.wav",
	"physics/body/body_medium_impact_soft6.wav",
	"physics/body/body_medium_impact_soft7.wav"
}
 
 
/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end
 

local Gears = {};

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
		if !self.Owner:IsModerator() then
			self.Owner:Kick("Your plan was flawed.");
			return false;
		end
 
        self.Owner:SetAnimation( PLAYER_ATTACK1 );
		
		local col = self.Owner:GetColor()
		local r, g, b, a = col.r, col.b, col.b, col.a
		
		if a != 0 then
			self.Weapon:EmitSound( self.Sound );
		end
		
        self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );
 
        self.NextStrike = ( CurTime() + .3 );

        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
        if trace.Entity && trace.Entity:IsPlayer() && trace.Entity:IsAdmin() && !self.Owner:IsAdmin() then 
		
			//self.Owner:Kill()
			
		end
        local Ability = self.Owner:getFlag( "godStickAbility" , 1 ) or 1;
		
		
		
		Gears[Ability][4](self.Owner, trace);
  end
  

  local function AddGear ( Title, Desc, AdminStatus, Func )
	table.insert(Gears, {Title, Desc, AdminStatus, Func})
	table.SortByMember(Gears, 3, function(a, b) return a > b end)
  end
  
 AddGear("ENT Info", "Left Click to get Info of an Entity.", false,
function ( Player )
	local Eyes = Player:GetEyeTrace().Entity:GetPos();
	local Eyes2 = Player:GetEyeTrace().Entity:GetAngles();
	local Eyes3 = Player:GetEyeTrace().Entity:GetModel();
	
	local VecString = 'Vector(' .. math.Round(Eyes.x) .. ', ' .. math.Round(Eyes.y) .. ', ' .. math.Round(Eyes.z) .. ')'
	
	print(Eyes3)
	Player:PrintMessage(HUD_PRINTTALK, Eyes3);
	Player:PrintMessage(HUD_PRINTTALK, VecString .. ", " .. tostring(Eyes2));
end
);     
  
 AddGear("Get Entity Owner", "Aim at an entity to get its owner.", 1,
	function ( Player, Trace )
		if IsValid( Trace.Entity ) then
			if( Trace.Entity:IsVehicle() ) then
				local owner = Trace.Entity.owner or nil
				if( owner != nil ) then
					Player:ChatPrint( owner:Nick() .. " [" .. owner:GetRPName() .. "][" .. team.GetName( owner:Team() ) .. "] Owns this car!" )
				else
					Player:ChatPrint( "No one owns this car!" )
				end
			else
				local owner = Trace.Entity:GetTable().Owner or nil
				if( owner != nil ) then
					Player:ChatPrint( owner:Nick() .. " [" .. owner:GetRPName() .. "][" .. team.GetName( owner:Team() ) .. "] Owns this entity!" )
				else
					Player:ChatPrint( "No one owns this entity!" )
				end
			end
		end
	end
);


AddGear( "Get Player's money.", "Left click to retrieve a player's money.", false,
	function( Player, Trace )

		if ( IsValid( Trace.Entity ) ) then

			if ( !Trace.Entity:IsPlayer() ) then return; end

			Player:ChatPrint( "Wallet: " .. Trace.Entity:getMoney() .. " Bank: " .. Trace.Entity:getBank() );

		end
end 
);   

AddGear("Heal Player", "Aim at a player heal him and his legs, aim at anything else to heal yourself.", 2,
	function ( Player, Trace )
		if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
			Trace.Entity.__Crippled = false;
			local _runSpeed, _walkSpeed = Trace.Entity:FindMovementSpeed();
			Trace.Entity:SetWalkSpeed(_walkSpeed)
			Trace.Entity:SetRunSpeed( _runSpeed )
			Trace.Entity:SetHealth(100)
			Trace.Entity:Notify("You have been fully healed by an admin")
			Player:PrintMessage(HUD_PRINTTALK, "Player Healed.");
		end
	end
);


AddGear("Revive Player", "Aim at a player corpse to revive them.", 3,
	function ( Player, Trace )
		
		for k , v in pairs(DeadPlayers) do
			if v[1]:Distance(Trace.HitPos) < 100 then
				local _p = player.GetByUniqueID(k);

				Player:DefibPlayer(_p:SteamID());

			end
		end

	end
);
AddGear("Slap Player", "Aim at an entity to slap him.", 2,
	function ( Player, Trace )
				if !Trace.Entity:IsPlayer() then
					local RandomVelocity = Vector( math.random(5000) - 2500, math.random(5000) - 2500, math.random(5000) - (5000 / 4 ) )
					local RandomSound = SLAP_SOUNDS[ math.random(#SLAP_SOUNDS) ]
					
					Trace.Entity:EmitSound( RandomSound )
					Trace.Entity:GetPhysicsObject():SetVelocity( RandomVelocity )
					Player:PrintMessage(HUD_PRINTTALK, "Entity slapped.");
				else
					local RandomVelocity = Vector( math.random(500) - 250, math.random(500) - 250, math.random(500) - (500 / 4 ) )
					local RandomSound = SLAP_SOUNDS[ math.random(#SLAP_SOUNDS) ]
					
					Trace.Entity:EmitSound( RandomSound )
					Trace.Entity:SetVelocity( RandomVelocity )
					Player:PrintMessage(HUD_PRINTTALK, "Player slapped.");
				end
	end
);
AddGear("Return", "Returns you to your previous location", 2,
function (Player, Trace)
	
		Player:SetPos( Player:getFlag("ReturnPlace", Player:GetPos() ) )
			
	
end );


AddGear("Warn Player", "Aim at a player to warn him.", 2,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				Trace.Entity:Notify("You have caught the attention of an Administrator, you better stop what you are doing!");
				Player:PrintMessage(HUD_PRINTTALK, "Player warned.");
			end
	end
);

AddGear("Kick Player", "Aim at a player to kick him.", 1,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				Trace.Entity:Kick("Kicked by Administrator " .. Player:Nick() );
				Player:PrintMessage(HUD_PRINTTALK, "Player kicked.");
			end
	end
);

AddGear("Respawn Player", "Aim at a player to respawn him.", 1,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				Trace.Entity:Notify("An administrator has respawned you.");
				Trace.Entity:Spawn();
				Player:PrintMessage(HUD_PRINTTALK, "Player respawned.");
			end
	end
);


function SWEP:Think ( )
	if self.Floater and IsValid(self.Floater) then
			local trace = {}
			trace.start = self.Floater:GetPos()
			trace.endpos = trace.start - Vector(0, 0, 100000);
			trace.filter = { self.Floater }
			local tr = util.TraceLine( trace )
		
		local altitude = tr.HitPos:Distance(trace.start);
		
		local ent = self.Spazzer;
		local vec;
		
		if self.FloatSmart then
			local trace = {}
			trace.start = self.Owner:GetShootPos()
			trace.endpos = trace.start + (self.Owner:GetAimVector() * 400)
			trace.filter = { self.Owner, self.Weapon }
			local tr = util.TraceLine( trace )
			
			vec = trace.endpos - self.Floater:GetPos();
		else
			vec = Vector(0, 0, 0);
		end
		
		if altitude < 150 then
			if vec == Vector(0, 0, 0) then
				vec = Vector(0, 0, 25);
			else
				vec = vec + Vector(0, 0, 100);
			end
		end
		
		vec:Normalize()
		
		if self.Floater:IsPlayer() then
			local speed = self.Floater:GetVelocity()
			self.Floater:SetVelocity( (vec * 1) + speed)
		else
			local speed = self.Floater:GetPhysicsObject():GetVelocity()
			self.Floater:GetPhysicsObject():SetVelocity( (vec * math.Clamp((self.Floater:GetPhysicsObject():GetMass() / 20), 10, 20)) + speed)
		end

	end
end

function SWEP:DrawWorldModel()
    self:DrawModel()

    local attachment = self:GetAttachment(1)
    local curTime = CurTime()
    local scale = math.abs(math.sin(curTime) * 4)
    local alpha = math.abs(math.sin(curTime) / 4)
               
    self.ThirdPersonGlowSprite:SetFloat("$alpha", 0.7 + alpha)
             
    if (attachment and attachment.Pos) then
        cam.Start3D( EyePos(), EyeAngles() )
            render.SetMaterial(self.ThirdPersonGlowSprite)
            render.DrawSprite( attachment.Pos, 45 + scale, 45 + scale, self.Owner:GetUserGroupColor() )
        cam.End3D()
    end
end
 
function SWEP:ViewModelDrawn()
        if (self:IsCarriedByLocalPlayer()) then
            local viewModel = self.Owner:GetViewModel();
                       
            if (IsValid(viewModel)) then
                local attachment = viewModel:GetAttachment( viewModel:LookupAttachment("sparkrear") );
                local curTime = CurTime();
                local scale = math.abs(math.sin(curTime) * 4);
                local alpha = math.abs(math.sin(curTime) / 4);
                               
                self.FirstPersonGlowSprite:SetFloat("$alpha", 0.7 + alpha);
                self.ThirdPersonGlowSprite:SetFloat("$alpha", 0.5 + alpha);

                if (attachment and attachment.Pos) then
                    cam.Start3D( EyePos(), EyeAngles() );
                        render.SetMaterial(self.ThirdPersonGlowSprite);
                        render.DrawSprite( attachment.Pos, 45 + scale, 45 + scale,self.Owner:GetUserGroupColor() );
                                               
                        self.FirstPersonGlowSprite:SetFloat("$alpha", 0.5 + alpha);
                                               
                            for i = 1, 9 do
                                local attachment = viewModel:GetAttachment( viewModel:LookupAttachment("spark"..i.."a") );

                                if (attachment.Pos) then
                                     if (i == 1 or i == 2 or i == 9) then
                                        	render.SetMaterial(self.ThirdPersonGlowSprite);
                                        else
                                        	render.SetMaterial(self.FirstPersonGlowSprite);
                                        end         
                                            render.DrawSprite( attachment.Pos, 1, 1,self.Owner:GetUserGroupColor() );
                                        end
                                end
                                               
                                for i = 1, 9 do
                                    local attachment = viewModel:GetAttachment( viewModel:LookupAttachment("spark"..i.."b") );
                                        if (attachment.Pos) then
                                            if (i == 1 or i == 2 or i == 9) then
                                                	render.SetMaterial(self.ThirdPersonGlowSprite);
                                                else
                                                    render.SetMaterial(self.FirstPersonGlowSprite);
                                                end    
                                                    render.DrawSprite( attachment.Pos, 1, 1, self.Owner:GetUserGroupColor() );
                                                end
                                            end
                    			cam.End3D()
                    	end
                end
        end
end


 function MonitorWeaponVis ( )
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() and IsValid(v:GetActiveWeapon()) then
			local col = v:GetColor()
			local pr, pg, pb, pa = col.r, col.b, col.b, col.a
			local wcol = v:GetActiveWeapon():GetColor()
			local wr, wg, wb, wa = wcol.r, wcol.g, wcol.b, wcol.a
			
			if pa == 0 and wa == 255 then
				v:GetActiveWeapon():SetRenderMode(RENDERMODE_TRANSALPHA)
				v:GetActiveWeapon():SetColor(Color(wr, wg, wb, 0))
			elseif pa == 255 and wa == 0 then
				v:GetActiveWeapon():SetColor(Color(wr, wg, wb, 255))
			end
		end
		
		/*
		if v:InVehicle() and v:GetVehicle().CanFly then
			local t, r, a = v:GetVehicle();
			
			if IsValid(t) then
				local p = t:GetPhysicsObject();
				a = t:GetAngles();
				r = 180 * ((a.r-180) > 0 && 1 or -1) - (a.r - 180);
				p:AddAngleVelocity(p:GetAngleVelocity() * -1 + Angle(a.p * -1, 0, r));
			end
		end
		*/
	end
 end
 hook.Add('Think', 'MonitorWeaponVis', MonitorWeaponVis);
 
 function MonitorKeysForFlymobile ( Player, Key )
	if Player:InVehicle() and Player:GetVehicle().CanFly then
		local Force;
		
		if Key == IN_ATTACK then
			Force = Player:GetVehicle():GetUp() * 450000;
		elseif Key == IN_ATTACK2 then
			Force = Player:GetVehicle():GetForward() * 100000;
		end
		
		if Force then
			Player:GetVehicle():GetPhysicsObject():ApplyForceCenter(Force);
		end
	end
 end
 hook.Add('KeyPress', 'MonitorKeysForFlymobile', MonitorKeysForFlymobile);
 
 
 timer.Simple(.5, function () GAMEMODE.StickText = Gears[1][1] .. ' - ' .. Gears[1][2] end);
 
	AddGear( "Goto" , "Goes to the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _toGoto;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			Player:setFlag("ReturnPlace", Player:GetPos() )
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target then
				
					_toGoto = v;
					v:Notify( "You have been brought by " .. Player:Nick() )		
					Player:Notify( "You have brought " .. v:Nick() )
					
				end
				 
			end
			
			goto( Player , _toGoto )
		
	end );
	AddGear( "Kick" , "Kicks the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _targetPlayer;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target && !v:IsModerator() then
				
					_targetPlayer = v;
					
				end
				
			end
			if _targetPlayer then
			
				_targetPlayer:Kick("Kicked by Administrator - (Disconnected by Server)")
			
			end
			
			PrintAdmin( Player:Nick() .. " Attempted to kick " .. player.GetBySteamID( _target ) .. ".");
	end );
	AddGear( "Force Rename" , "Force Rename  the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _targetPlayer;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target && !v:IsModerator()  then
				
					v:ShowNameChangeMenu()
					v:Notify( "You are forced to rename by " .. Player:Nick() .. " (If you disagree and believe your name is fine, post to the forum!)" )		
					Player:Notify( "You have sent a re-name form to " .. v:Nick() )
					break
				end
				
			end
			
	end );
	AddGear( "Spawn" , "Force Revive  the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _targetPlayer;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target && !v:IsModerator() then
				
					v:Spawn()
					v:Notify( "You have been respawned by " .. Player:Nick() )		
					Player:Notify( "You respawned " .. v:Nick() )
					break
				end
				
			end
			
	end );
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()	
		if SERVER then return false; end
		
		local MENU = DermaMenu()
		local PlayerMenu= MENU:AddSubMenu( "Players" )
		for x , t in pairs( player.GetAll() ) do 
		
			_pm = PlayerMenu:AddSubMenu( t:Nick() .. " (" .. t:getRPName() .. ") " )

			for k, v in pairs(Gears) do
				if v[3] == 6 then
				_pm:AddOption(v[1], 	function()
						net.Start("sendTargetGodstickPlayer")
							net.WriteString( t:SteamID() )
						net.SendToServer()
						LocalPlayer():setFlag("targetGodstickPlayer", t:SteamID() )
									
						LocalPlayer():SetAdministrationAbility( k )
						LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
						GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
						
							
					
					
					
					end )
				end
			end
			
		end
		
		for k, v in pairs(Gears) do
			local Title = v[1];
			
			MENU:AddOption(Title, 	function()
										LocalPlayer():SetAdministrationAbility( k );
										
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
		end
		
		MENU:Open( 100, 100 )	
		timer.Simple( 0, function() gui.SetMousePos(110, 110) end )
	
  end 
  