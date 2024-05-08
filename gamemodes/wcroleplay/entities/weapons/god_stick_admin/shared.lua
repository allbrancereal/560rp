if( SERVER ) then
 
        AddCSLuaFile( "shared.lua" );
 
end
 
if( CLIENT ) then
 
        SWEP.PrintName = "El Pollo Diabolo - Admin Edition";
		SWEP.Author = "Mario S.";
		SWEP.Purpose = "To slay the hackers and overlord noobs across all our lands";
        SWEP.Slot = 0;
        SWEP.SlotPos = 5; 
        SWEP.DrawAmmo = false;
        SWEP.DrawCrosshair = true;
		
    SWEP.FirstPersonGlowSprite = Material("sprites/light_glow02_add_noz");
    SWEP.ThirdPersonGlowSprite = Material("sprites/light_glow02_add");
end

// Variables that are used on both client and server
 
SWEP.Author               = "Fried Rice"
SWEP.Instructions       = "Left click to fire, right click to change"
SWEP.Contact        = "support@560rp.com"
SWEP.Purpose        = "Administrate with just a stick."
 
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
SWEP.DrawCrosshair = false
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

				self.Ability = 1;
        
        end
		if CLIENT then
		
		LocalPlayer():setFlag("targetGodstickPlayer","")
		LocalPlayer():SetAdministrationAbility( 0 );
		
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
 
 -- If True then you have to be a superadmin to use --
/*
SA = { KillPl = true, -- Kill Player
SlapPl = false, -- Slaps Player
SuperSlapPl = false, -- Super Slaps Player
WarnPl = false, -- Warns Player
KickPl = false, -- Kicks Player
UnlockDoor = false, -- Unlocks Target Door
LockDoor = false, -- Locks Target door.
IgniteEnt = true, -- Ignites Entity
Teleport = true, -- Teleports to target location
GodModeSelf = true, -- Enables Godmode on self
Remover = true, -- Removes any ENT, Not including doors and NPC's.
Strip = true, -- Strips all SWEPS from player.
Freeze = true, -- Freezes player.
RespawnPl = true, -- Respawns player (They keep their weapons)
ClearDecals = true, -- Uses ULX Cleardecals Command
Demote = true, -- Resets to default job.
HealPl = true, -- Target Player is healed, if not targeting player, it heals yourself.
GivePayday = true, -- Gives Payday
Arrest = true, -- Arrests targeted person.
Unarrest = true, -- Unarrests targeted person.
Want = true, -- Sets targeted player Wanted.
UnWant = true, -- Sets Targeted Player Un-Wanted
}
*/
/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end
 
function SWEP:DoFlash( ply )
 
        umsg.Start( "StunStickFlash", ply ); umsg.End();
 
end
 
local Abilities = {};

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
		if !self.Owner:IsAdmin() then
			self.Owner:Kick("Your plan was flawed. You shouldn't be using this.");
			return false;
		end
 
        self.Owner:SetAnimation( PLAYER_ATTACK1 );
		
		local r, g, b, a = self.Owner:GetColor();
		
		if a != 0 then
			self.Weapon:EmitSound( self.Sound );
		end
		
        self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );
 
        self.NextStrike = ( CurTime() + .3 );

        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
        
        local Ability = self.Owner:getFlag( "godStickAbility" , 1 );
		if !Abilities[Ability] then return end
		
		
			
		if Abilities[Ability][3] and !self.Owner:IsAdmin() then
			self.Owner:PrintMessage("This Ability requires admin status.");
			return false;
		end
		
		Abilities[Ability][4](self.Owner, trace);
  
		
		
  end
  

local function AddAbility ( Title, Desc, SA, Func)
		table.insert(Abilities, {Title, Desc, SA, Func});
end  
 
AddAbility("Kill Player", "Aim at a player to slay him.", 2,
	function ( Player, Trace )
		if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
			Trace.Entity:Kill();
			Player:PrintMessage(HUD_PRINTTALK, "Player killed.");
		end
	end
);

AddAbility("Heal Player", "Aim at a player to heal him.", 3,
	function ( Player, Trace )
		if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
		
			Trace.Entity:SetHealth( 100 );
			Trace.Entity.__Crippled = false;
			local _runSpeed, _walkSpeed = Trace.Entity:FindMovementSpeed();
			Trace.Entity:SetWalkSpeed(_walkSpeed)
			Trace.Entity:SetRunSpeed( _runSpeed )
			Player:PrintMessage(HUD_PRINTTALK, "Player healed.");
			
		else
		
			Player:SetHealth( 100 );
		
		end
	end
);

AddAbility("Revive Player", "Aim at a player corpse to revive them.", 3,
	function ( Player, Trace )
		
		for k , v in pairs(DeadPlayers) do
			if v[1]:Distance(Trace.HitPos) < 100 then
				local _p = player.GetByUniqueID(k);

				Player:DefibPlayer(_p:SteamID());

			end
		end

	end
);

AddAbility("Invisibility", "Left click to turn invisible. Left click again to return back to normal.", 2,
	function ( Player )
		local col = Player:GetColor()
		local r, g, b, a = col.r, col.b, col.b, col.a
		
		if a == 255 then
			Player:PrintMessage(HUD_PRINTTALK, "You are now invisible.");
			Player:SetRenderMode(RENDERMODE_TRANSALPHA)
			Player:SetColor(Color(50, 50, 50, 0))
		else
			Player:PrintMessage(HUD_PRINTTALK, "You are no longer invisible.");
			Player:SetColor(Color(255, 255, 255, 255))
		end
	end
);
AddAbility("Toggle Disguise", "Hit to toggle.", 2,
	function ( Player, Trace )
	
		if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
			Trace.Entity:ToggleDisguise()
		else
			Player:ToggleDisguise()
		end
	end
);

AddAbility("Slap Player", "Aim at an entity to slap him.", 2,
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



AddAbility("Warn Player", "Aim at a player to warn him.", 2,
        function ( Player, Trace )
                if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
                    Trace.Entity:PrintMessage(HUD_PRINTTALK, "A Council Member thinks you're something stupid, you should stop.");
                    //Trace.Entity.GAMEMODE:AddNotify("Obey the rules.", NOTIFY_GENERIC, 5);
					Player:PrintMessage(HUD_PRINTTALK, "Player warned.");
            end
        end
); 

AddAbility("Kick Player", "Aim at a player to kick him.", 2,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() and !Trace.Entity:IsAdmin() then
				Trace.Entity:Kick("Kicked by Administrator: " .. Player:Nick() );
				Player:PrintMessage(HUD_PRINTTALK, "Player kicked.");
			end
	end
);

/*
AddAbility("Cloak", "Turns you invisible.", false,
	function ( Player )
		local r, g, b, a = Player:GetColor();
		
		if a == 255 then
			Player:SetColor( Color(50, 50, 50, 0 ) )
			Player:PrintMessage(HUD_PRINTTALK, "Invisible.");
			Player:SetMaterial( "models/effects/vol_light001" )
			Player:SetRenderMode( RENDERMODE_TRANSALPHA )
			else
			Player:SetColor( Color(255, 255, 255, 255 ) )
			Player:SetRenderMode(RENDERMODE_NORMAL)
			Player:PrintMessage(HUD_PRINTTALK, "Visible.");
			Player:SetRenderMode(RENDERMODE_NORMAL)
		end
	end
); */

AddAbility("Kick Stall Manager", "Aim at a player to kick them from their stall.", 3,
	function ( Player, Trace )
		if IsValid(Trace.Entity) then
			if CLIENT then return end
				
			if Trace.Entity.Stall then
				Trace.Entity.Stall:KickManager()
				Player:PrintMessage(HUD_PRINTTALK, "Stall Manager Kicked.");
				Trace.Entity:PrintMessage(HUD_PRINTTALK, "A staff member has kicked you from your stall.");
			end

		end
	end
);
AddAbility("Unlock Door", "Aim at a door to unlock it.", 3,
	function ( Player, Trace )
			if IsValid(Trace.Entity) then
				Trace.Entity:Fire('unlock', '', 0);
				Trace.Entity:Fire('open', '', .5);
				Player:PrintMessage(HUD_PRINTTALK, "Door unlocked.");
			end
	end
);

AddAbility("Lock Door", "Aim at a door to lock it.", 3,
	function ( Player, Trace )
			if IsValid(Trace.Entity) then
				Trace.Entity:Fire('lock', '', 0);
				Trace.Entity:Fire('close', '', .5);
				Player:PrintMessage(HUD_PRINTTALK, "Door locked.");
			end
	end
);


AddAbility("Un-Ignite", "Removes ignition wherever you're aiming.", 4,
	function ( Player, Trace )
		if IsValid(Trace.Entity) then
			Trace.Entity:Ignite(1);
		Player:PrintMessage(HUD_PRINTTALK, "Fire started.");
		end
	end
);
AddAbility("Target/Teleport", "Target an entity to select, then teleport it.", 4,
	function ( Player, Trace )
		if IsValid(Trace.Entity) then
			Player:setFlag("targetTeleportEntity", Trace.Entity:EntIndex() )
		
				Player:PrintMessage(HUD_PRINTTALK,"Selected: " .. Trace.Entity:GetClass() )
		else
		
			if Player:getFlag("targetTeleportEntity", nil ) then
			
				ents.GetByIndex( Player:getFlag("targetTeleportEntity", nil ) ):SetPos( Trace.HitPos )
				Player:PrintMessage(HUD_PRINTTALK,"Teleported entity")
			else
				Player:PrintMessage(HUD_PRINTTALK,"No valid entity selected")
			end
			
		end
		
		
	end
);
AddAbility("Teleport", "Teleports you to a targeted location.", 4,
	function ( Player, Trace )
		local EndPos = Player:GetEyeTrace().HitPos;
		local CloserToUs = (Player:GetPos() - EndPos):Angle():Forward();
		
		Player:SetPos(EndPos + (CloserToUs * 20));
		Player:PrintMessage(HUD_PRINTTALK, "Teleported.");
	end
);

AddAbility("God Mode", "Left click to alternate between god and mortal.", 4,
	function ( Player, Trace )
		if Player.IsGod then
			Player.IsGod = false;
			Player:PrintMessage(HUD_PRINTTALK, "You are now vulnerable.");
			Player:GodDisable();
		else
			Player.IsGod = true;
			Player:PrintMessage(HUD_PRINTTALK, "You are now invulnerable.");
			Player:GodEnable();
		end
	end
);


AddAbility("Remover", "Aim at any object to remove it.", 4,
	function ( Player, Trace )
			if IsValid(Trace.Entity) then
				if Trace.Entity:IsVehicle() and IsValid(Trace.Entity:GetDriver()) then
					
					Trace.Entity:GetDriver():ExitVehicle();
					for k , v in pairs( player.GetAll() ) do
					
						if Trace.Entity:getFlag("carOwner","") == v:SteamID() then
					
							v:SendVehicleToGarage()
							
							break 
						
						end 
					
					end
					
					return Player:PrintMessage(HUD_PRINTTALK, "Vehicle Removed.");
					
				end
				
				if string.find(tostring(Trace.Entity), "door") then
					return Player:PrintMessage(HUD_PRINTTALK, "You cannot remove doors, silly.");
				elseif string.find(tostring(Trace.Entity), "npc") then
					return Player:PrintMessage(HUD_PRINTTALK, "You cannot remove npcs, silly.");
				end;
				
				if Trace.Entity:GetClass() == "cannabis_plant" then
				
					for k , v in pairs( player.GetAll() ) do
					
						if v:SteamID() == Trace.Entity:getFlag( "ownedBy" , "" ) then					
						
							v:setFlag( "maxcannabisplants", math.Clamp( v:getFlag( "maxcannabisplants", 0 ) - 1 , 0 , v:GetCannabisPlantLimit() ) )
							v:PrintMessage( HUD_PRINTTALK,Player:Nick() .. " has removed a cannabis plant of yours.");
						end
						
					end
					
				end
				
				if Trace.Entity:IsPlayer() then
					Trace.Entity:Kill();
				else
					Trace.Entity:Remove();
				end
			end
	end
);

AddAbility("Strip", "Left Click to strip the target player.", 2,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
					Trace.Entity:StripWeapons()
					Player:PrintMessage(HUD_PRINTTALK, "Player Stripped.");
					Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been stripped.");

		end
	end
);

AddAbility("Freeze", "Target a player to change his freeze state.", 2,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				if Trace.Entity.IsFrozens then
					Trace.Entity:Freeze(false);
					Player:PrintMessage(HUD_PRINTTALK, "Player unfrozen.");
					Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been unfrozen.");
					Trace.Entity.IsFrozens = nil;
				else
					Trace.Entity.IsFrozens = true;
					Trace.Entity:Freeze(true);
					Player:PrintMessage(HUD_PRINTTALK, "Player frozen.");
					Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been frozen.");
				end
			end
	end
);

AddAbility("Respawn Player", "Aim at a player to Respawn him.", 2,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				Trace.Entity:Spawn();
				Trace.Entity:PrintMessage(HUD_PRINTTALK, "An Administrator forced a Respawn on you.");
				Player:PrintMessage(HUD_PRINTTALK, "Player Respawned.");
			end
	end
);


AddAbility("Clear Decals", "Left Click to clear all decals.", 4,
	function ( pl )
	for _, pl in ipairs ( player.GetAll() ) do
		pl:ConCommand ( "ulx cleardecals" )
		pl:PrintMessage(HUD_PRINTTALK, "Cleared all Decals.");
	end
end
);

AddAbility("Stopsounds", "Left Click to stop all sounds for every player.", 4,
	function ( pl )
	for _, pl in ipairs ( player.GetAll() ) do
		pl:ConCommand ( "ulx stopsound" )
		pl:PrintMessage(HUD_PRINTTALK, "stopped sounds.");
	end
end
);
local PosPrint = {}

AddAbility("Unfreeze Props", "Left Click to unfreeze a prop you're looking at.", 4,
	function ( Player )
	if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then	
		Trace.Entity:PhysgunUnfreeze()
		Player:PrintMessage(HUD_PRINTTALK, "Unfroze prop.");
	end
end
);



AddAbility("[RP] Demote", "Left click to demote a player.", 3,
	function(Player, Trace)
		if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
            Trace.Entity:teamBan()
			Player:PrintMessage(HUD_PRINTTALK, "Player demoted.");
			Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been demoted by a Council Member.");
	end
end
);

AddAbility("[RP] Heal Player", "Aim at a player heal him and his legs, aim at anything else to heal yourself.", 3,
	function ( Player, Trace )
		if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
			Trace.Entity:SetHealth(100);
			Trace.Entity.__Crippled = false;
			local _runSpeed, _walkSpeed = Trace.Entity:FindMovementSpeed();
			Trace.Entity:SetWalkSpeed(_walkSpeed)
			Trace.Entity:SetRunSpeed( _runSpeed )
			Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been fully healed by an Council Member");
			Player:PrintMessage(HUD_PRINTTALK, "Player Healed.");
		else
			Player:SetHealth(100);
			Player.__Crippled = false;
			local _runSpeed, _walkSpeed = Player:FindMovementSpeed();
			Player:SetWalkSpeed(_walkSpeed)
			Player:SetRunSpeed( _runSpeed )
			Player:PrintMessage(HUD_PRINTTALK, "Fully Healed Yourself.");
		end
	end
);

function showClientReadout( trace, _p )
	
	local ent = trace
	// put index in the back for normal doors, keep it in the front for properties
	return "{ Index = " .. ent:MapCreationID() .. " ,Vector(" .. ent:GetPos().x .. ", " .. ent:GetPos().y .. ", " .. ent:GetPos().z .. "), '" .. ent:GetModel() .. "', '' },\n"

end

AddAbility("Return", "Returns you to your previous location", 2,
function (Player, Trace)
		
		if Trace.Entity && Trace.Entity:IsPlayer() && Trace.Entity:getFlag("ReturnPlace", Trace.Entity:GetPos() ) != Trace.Entity:GetPos() then
		
			
			Trace.Entity:SetPos( Trace.Entity:getFlag("ReturnPlace", Trace.Entity:GetPos() ) )
			return
			
		end
	
		Player:SetPos( Player:getFlag("ReturnPlace", Player:GetPos() ) )
			
	
end );



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
				local hue = math.abs(math.sin(CurTime() *0.9) *335)
    local attachment = self:GetAttachment(1)
    local curTime = CurTime()
    local scale = math.abs(math.sin(curTime) * 4)
    local alpha = math.abs(math.sin(curTime) / 4)
               
    self.ThirdPersonGlowSprite:SetFloat("$alpha", 0.7 + alpha)

	local cin = (math.sin(CurTime()) + 1) / 3

    if (attachment and attachment.Pos) then
        cam.Start3D( EyePos(), EyeAngles() )
            render.SetMaterial(self.ThirdPersonGlowSprite)
            render.DrawSprite( attachment.Pos, 45 + scale, 45 + scale, HSVToColor(hue, 1, 1) )
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
				//HSVToColor(hue, 1, 1)
				local hue = math.abs(math.sin(CurTime() *0.9) *335)
	            local cin = (math.sin(CurTime()) + 1) / 3                
                               
                if (attachment and attachment.Pos) then
                    cam.Start3D( EyePos(), EyeAngles() );
                        render.SetMaterial(self.ThirdPersonGlowSprite);
                        render.DrawSprite( attachment.Pos, 45 + scale, 45 + scale, HSVToColor(hue, 1, 1) );
                                               
                        self.FirstPersonGlowSprite:SetFloat("$alpha", 0.5 + alpha);
                                               
                            for i = 1, 9 do
                                local attachment = viewModel:GetAttachment( viewModel:LookupAttachment("spark"..i.."a") );
                                                       
                                if (attachment.Pos) then
                                     if (i == 1 or i == 2 or i == 9) then
                                        	render.SetMaterial(self.ThirdPersonGlowSprite);
                                        else
                                        	render.SetMaterial(self.FirstPersonGlowSprite);
                                        end         
                                            render.DrawSprite( attachment.Pos, 1, 1, HSVToColor(hue, 1, 1) );
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
                                                    render.DrawSprite( attachment.Pos, 1, 1, HSVToColor(hue, 1, 1) );
                                                end
                                            end
                    			cam.End3D()
                    	end
                end
        end
end

 // Draw the Crosshair
 local chRotate = 0;
 function SWEP:DrawHUD( )
 if (SERVER || CLIENT) then return; end
	 local godstickCrosshair = surface.GetTextureID("560rp/crosshairs/godstick_crosshairv4");
	 local trace = self.Owner:GetEyeTrace();
	 local x = (ScrW()/2);
	 local xb = 20
	 local y = (ScrH()/2);
					
		if IsValid(trace.Entity) then
			draw.WordBox( 8, xb, 10, "Target: " .. tostring(trace.Entity) , "GModNotify", Color(0,0,0,100), Color(255,0,0,255) );
			
			if !trace.Entity:IsPlayer() then
			
				draw.WordBox( 8, xb, 50, "Owner: " .. tostring(trace.Entity:getFlag("ownedBy", "")) , "GModNotify", Color(0,0,0,100), Color(255,0,0,255) );
			
			end
			
			surface.SetDrawColor(255, 0, 0, 255);
			chRotate = chRotate + 1;
		else
			draw.WordBox( 8, xb, 10, "Target: " .. tostring(trace.Entity)  , "GModNotify", Color(0,0,0,100), Color(255,255,255,255) );
			surface.SetDrawColor(255, 255, 255, 255);
			chRotate = chRotate + .1;
		end
		
	//surface.DrawRect((ScrW() / 2), (ScrH() / 2), 10, 10)
		//draw.RoundedBox(0, x, y, 10, 10, Color( 0, 255 * math.abs(math.sin(CurTime() *0.9) *335) , 255 ) )
		
	local hue = math.abs(math.sin(CurTime() *0.9) *335)
	//surface.DrawRect((ScrW() / 2), (ScrH() / 2), 10, 10)
	//draw.RoundedBox(0, (ScrW() / 2.0075), (ScrH() / 2.012), 10, 10, HSVToColor(hue, 1, 1))
		
		
		halo.Add( player.GetAll(), HSVToColor( (CurTime() * 2 ) % 360 , 1, 1 ), 5, 5, 2, true, true )
		//halo.Add( {LocalPlayer():GetViewModel()}, HSVToColor( CurTime() % 360, 1, 1 ), 5, 5, 2, true, true )
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
 
 if SERVER then
	  /*function GodSG ( Player, Cmd, Args )
			Player:GetTable().CurAbility = tonumber(Args[1]);
	  end
	  concommand.Add('god_sg', GodSG);
	  */
	  
				net.Receive( "sendAbility", function( _l, _p )
				
					_p:setFlag( "godStickAbility", net.ReadInt(8) );
				end )
 end
 
		local _pMeta = FindMetaTable( 'Player' )
		function _pMeta:SetAdministrationAbility( ability )
		
			self:setFlag("godStickAbility", ability )			
			
			if CLIENT then
			
				net.Start("sendAbility")
					net.WriteInt( ability ,8 )
				net.SendToServer()
			
				
			else
			
				net.Start("receiveAbility")
					net.WriteInt( ability ,8 )
				net.SendToServer()
			
			
			
			end
		end

if CLIENT then
		
	net.Receive( "receiveAbility", function( _l, _p )		

		_p:setFlag( "godStickAbility", net.ReadInt(8) );
					
	end )
	
end

 timer.Simple(.5, function () GAMEMODE.StickText = Abilities[1][1] .. ' - ' .. Abilities[1][2] end);
AddAbility( "Target This Player" , "Target a player.", 6,
	function (Player, Trace)
			
		
	end );
	AddAbility( "Goto" , "Goes to the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _toGoto;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			Player:setFlag("ReturnPlace", Player:GetPos() )
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target then
				
					_toGoto = v;
					v:Notify( Player:Nick() .. " has teleported to your location." )		
					Player:Notify( "You have teleported to " .. v:Nick() )
					
				end
				
			end
			
			goto( Player , _toGoto )
		
	end );
	AddAbility( "Bring" , "Brings the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _toGoto;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target then
				
					_toGoto = v;
					v:Notify( "You have been brought by " .. Player:Nick() )		
					Player:Notify( "You have brought " .. v:Nick() )
					
				end
				
			end
			
			bring( Player , { _toGoto })
		
	end );
	AddAbility( "Kick" , "Kicks the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _targetPlayer;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target && _target != Player:SteamID() then
				
					_targetPlayer = v;
					
				end
				
			end

			if _targetPlayer and !_targetPlayer:IsAdmin() then
				_targetPlayer:Kick("Kicked by Administrator - (Disconnected by Server)")
			else Player:Notify("You can't kick administrators.")
		end	
	end );
	AddAbility( "Ban" , "Brings up ban menu on requested player." , 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			//if _target == Player:SteamID() && !Player:IsDev() then return Player:Notify("You can not target a ban on yourself!") end
			if !Player:IsAdmin() then return end
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
						
			net.Start("getBanInformation")
				net.WriteString( _target );
				net.WriteInt( 0 , 4 );
			net.Send( Player )
		
	end ); 
	AddAbility( "Force Rename" , "Force Rename  the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _targetPlayer;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target then
				
					v:ShowNameChangeMenu()
					v:Notify( "You are forced to rename by " .. Player:Nick() .. " (If you disagree and believe your name is fine, post to the forum!)" )		
					Player:Notify( "You have sent a re-name form to " .. v:Nick() )
					break
				end
				
			end
			
	end );
	AddAbility( "Give $25,000" , "Give them $25k", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _targetPlayer;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target then
				
					v:addMoney(25000)
					v:Notify( "You have received $25,000 from " .. Player:Nick() )		
					Player:Notify( "You have sent $25,000 to " .. v:Nick() )
	
					break
				end
				
			end

	end );
	AddAbility( "Spawn" , "Force Revive  the target player", 6,
	function (Player, Trace)
			
			local _target = Player:getFlag("targetGodstickPlayer", nil )
			
			local _targetPlayer;
			
			if !_target then return Player:Notify("No target found" .. util.TypeToString( _target ) ); end
			
			for k , v in pairs( player.GetAll() ) do
			
				if v:SteamID() == _target then
				
					v:Spawn()
					v:Notify( "You have been respawned by " .. Player:Nick() )		
					Player:Notify( "You respawned " .. v:Nick() )
					break
				end
				
			end
			
	end );
if SERVER then
			
				
			
			
				util.AddNetworkString("sendAbility")
				util.AddNetworkString("receiveAbility")
				util.AddNetworkString("giveAdminWeapons")
				util.AddNetworkString("sendTargetGodstickPlayer")
				
				net.Receive("giveAdminWeapons", function( len , _p )
				
					if !_p:IsCouncilMember() then
					
						_p:Notify("Sorry, but no.")
						return
					end
					
					local _wep = net.ReadString()
					
					_p:Give( _wep );
					
				end )
				net.Receive("sendTargetGodstickPlayer", function( len , _p )
					
					_p:setFlag("targetGodstickPlayer", net.ReadString() )
				
				end )
				
			end
	
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()	
		if SERVER then return false; end
		
		local MENU = DermaMenu()
		//MENU:SetFontInternal( "Trebuchet24")
		local subMenu1= MENU:AddSubMenu( "Administration" )
		local subMenu2= MENU:AddSubMenu( "Roleplay" )
		local subMenu3= MENU:AddSubMenu( "Development" )
		local PlayerMenu= MENU:AddSubMenu( "Online Players" )
		local _pm;
		for x , t in pairs( player.GetAll() ) do 
		
			_pm = PlayerMenu:AddSubMenu( t:Nick() .. " (" .. t:getRPName() .. ") " )
			_giveMenu = _pm:AddSubMenu( "Give Weapon" )
					for k , v in pairs( ITEMLIST ) do
				
					if v.Category == "Weapon" && v.WeaponClass then
						
						_giveMenu:AddOption( v.Name , function( )
							
							LocalPlayer():SetAdministrationAbility( 0 )
							net.Start("giveAdminWeapons")
								net.WriteString( v.WeaponClass )
							net.SendToServer()
						
						end )
						
					
					end
				end
				
			for k, v in pairs(Abilities) do
				if v[3] == 6 then
				_pm:AddOption(v[1], 	function()
												net.Start("sendTargetGodstickPlayer")
													net.WriteString( t:SteamID() )
												net.SendToServer()
												LocalPlayer():setFlag("targetGodstickPlayer", t:SteamID() )
												LocalPlayer():Notify("Targeted " .. t:Nick() )
												LocalPlayer():SetAdministrationAbility( k )
												LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
												GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
											end )
				end
			end
		end 
		
		for k, v in pairs(Abilities) do
			local Title = v[1];
			
			if v[3] == 1 then

					MENU:AddOption(Title, 	function()
												LocalPlayer():SetAdministrationAbility( k )
												LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
												GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
											end )
			elseif v[3] == 2 then

			subMenu1:AddOption(Title, 	function()
										LocalPlayer():SetAdministrationAbility( k )
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
			elseif v[3] ==3 then

			subMenu2:AddOption(Title, 	function()
										LocalPlayer():SetAdministrationAbility( k )
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
			elseif v[3] ==4 then

			subMenu3:AddOption(Title, 	function()
										LocalPlayer():SetAdministrationAbility( k )
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
			elseif v[3] ==5 then

			subMenu4:AddOption(Title, 	function()
										LocalPlayer():SetAdministrationAbility( k )
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
			elseif v[3] ==7 then

			subMenu5:AddOption(Title, 	function()
										LocalPlayer():SetAdministrationAbility( k )
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
				
			elseif v[3] ==8 then

			subMenu6:AddOption(Title, 	function()
										LocalPlayer():SetAdministrationAbility( k )
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
				
			end		end
		
		MENU:Open( 100, 100 )	
		timer.Simple( 0, function() gui.SetMousePos(110, 110) end )
	
  end 