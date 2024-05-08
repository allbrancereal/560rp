
NPC = NPC or {}

-- This sets the model for the NPC.
NPC.model = "models/player/tfa_dcu_cptcold.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Staffing Director Terry"

NPC.reputation =1;
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.

function NPC:onEnterPoliceForce( client )

	if !IsJobFull( TEAM_POLICE ) && client:NearNPC( "job_police") then
	
		client:EnterJob( TEAM_POLICE )
		
	end

end

function NPC:onLeavePoliceForce( client )

	if client:Team() == TEAM_POLICE && client:NearNPC( "job_police") then
	
		client:LeaveJob()
		
	end
	
end
