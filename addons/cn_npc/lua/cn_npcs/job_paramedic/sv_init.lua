

-- This sets the model for the NPC.
NPC.model = "models/player/real/prawnmodels/pepsiman.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Ambulance Coordinator Mercy"

NPC.reputation =2;

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.

function NPC:onEnterParaForce( client )
	local _b , _v = client:FinishedQuestLine( {5} );
	
	if !IsJobFull( TEAM_PARAMEDIC ) && _b then
	
		client:EnterJob( TEAM_PARAMEDIC )
	
	else
	
		client:Notify("You need to finish the Paramedic Training Questline before!")
		
	end

end
function NPC:onstartQuizQuest( client )

	if !client:getFlag("questTable",{})[5] then
		client:StartQuest(5)
	end
	
end
function NPC:onquest6Start( client )

	if !client:getFlag("questTable",{})[6] then
		client:StartQuest(6)
	end

end
local _quizTable = {

	[1] = {
		Question 	= "As a Paramedic, your job is to ...";
		Answer 		= "Save Lives no matter what.";
		Randoms		= {
			"Entertain people while they are home and protect them from violence.";
			"Stand around the hospital and do things.";
			"Behave like that guy House from TV.";
		};
	};
	[2] = {
		Question 	= "A Defibrilator is used for what?";
		Answer 		= "Shocking a person's heart alive.";
		Randoms		= {
			"A deadly weapon that I can use to finally bend electricity at my will.";
			"When a heart is doing the dead thing you pull it out and zap the person alive.";
			"Entertaining people by tazing them and then laughing at them pissing themselves.";
		};
	};
	[3] = {
		Question 	= "How do you help people feel better?";
		Answer 		= "By supplying them with care and medicine as needed.";
		Randoms		= {
			"Giving them some drugs and calling it a day.";
			"A paycheque is a paycheque, so I just do whats needed.";
			"What do you mean? I signed up to do things my way.";
		};
	};
	
	

}
util.AddNetworkString("sendNextQuestion")
function NPC:onquizNW( client, id, str )

	if _quizTable[id].Answer == str then
			
			client:setFlag( "paramedicQuizQ_" .. id , true )
			
		if client:getFlag( "paramedicQuizQ_3" , false ) == true then
			client:RewardQuest(5)
		
		
		end
			net.Start("sendNextQuestion")
			net.Send(client)
	end

end


function NPC:onLeaveParaForce( client )

	if client:Team() == TEAM_PARAMEDIC  then
	
		client:LeaveJob()
		
	end
	
end
