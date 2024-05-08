local NPC = NPC || {}
-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Ambulance Coordinator Mercy"
NPC.model = "models/player/real/prawnmodels/pepsiman.mdl"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

NPC.reputation =2;

-- This is the function that gets called when the player presses <E> on the NPC.
local policeTalk = {}
policeTalk.AvailableJobs = {
	"Paramedic",
}
policeTalk.onStart = {
	
	Computer = {
		"Welcome to the Hospital. If you are looking for help with injury, then ask Ciri at the front desk.",
		"This is the Hospital, ask people around for all the things you can do around here.",
		"Welcome back!",
		"Is there anything I can help you with?",
		"Welcome to the force. You can get a Ambulance at the police department.",
		
		"Welcome to the Paramedic Force. You can get your equipment in the back.",
		"I apologize but there are no more jobs actually.",
		"I know I told you I would look for a job that you could do, but I found none. You have to go.",
	};
	
	Response = {
		"I am actually looking for a paramedic job.",
		"I am here to quit. Here is my ID card & scrubs.",
		"I already have a job.",
	};
	LeaveResponse = {
		"I actually do not have any time to talk right now, sorry.",
		"Maybe later. I have to do some work.",
		"I'm not in the mood to talk to you.",
		"Be seeing you.",
		"Wow thank you just like I always wanted to be since I was a child.",
		
		"I can't believe you would allow me to do this thank you so much!",
		"Yeah whatever it doesnt make sense I want a second job...",
		"I guess you're right, I gotta do some other stuff.",
		"...",
		"I would like to quit my job",
	};
};
function NPC:onStart()
	local welcomeText = policeTalk.onStart.Computer[math.random(1,2)];
	local _p = LocalPlayer();
	local _team = _p:Team() ;
	
	if _team == TEAM_PARAMEDIC then
	
		welcomeText = policeTalk.onStart.Computer[math.random(3,4)]
		
	end
	
	self:addText( welcomeText )
	
	local responseText = _team == TEAM_CIVILLIAN && policeTalk.onStart.Response[1] || _team == TEAM_PARAMEDIC && !table.HasValue( {TEAM_PARAMEDIC,TEAM_CIVILLIAN} , _team ) && policeTalk.onStart.Response[3] || "";
	local _leaveTxt = policeTalk.onStart.LeaveResponse[math.random(1,4)];
	
			
			if _team == TEAM_CIVILLIAN then
				self:addOption( responseText, function()
					
						self:TryPara()
						
					
				end)
			end
			
			if _team == TEAM_PARAMEDIC then
			
				
				self:addOption( policeTalk.onStart.LeaveResponse[10], function()
					self:send("LeaveParaForce")
					
					self:addText( "Okay, have a good one." )
					
					self:addLeave( "<Leave> " .. policeTalk.onStart.LeaveResponse[9] )
				end)
				
			end
			
			
			if _team != TEAM_CIVILLIAN && _team != TEAM_PARAMEDIC then
			
				self:HasJob()
			
			else
				self:addLeave( "<Leave> " .. _leaveTxt )
			end		
				
		
			
	
	
	
	
end


function NPC:HasJob()


	self:addLeave( "<Leave> " .. policeTalk.onStart.LeaveResponse[math.random(7,8)] )

end
function NPC:TryPara()
	local _b =  LocalPlayer():FinishedQuest(5)
	
	if _b then
		local _NPCText, _leaveTxt = "", "";
		
		if IsJobFull( TEAM_PARAMEDIC ) then
			_leaveTxt = policeTalk.onStart.LeaveResponse[9];
			_npcText = policeTalk.onStart.Computer[math.random(7,8)]
		else		
			
			_NPCText = policeTalk.onStart.Computer[math.random(5,6)];
			_leaveTxt = policeTalk.onStart.LeaveResponse[math.random(5,6)];
			self:send("EnterParaForce")
		end
		
		self:addText( _NPCText )
			
		self:addLeave( "<Leave> " .. _leaveTxt  )
	else
		if !LocalPlayer():FinishedQuest( 5 ) then
		
			self:DoParamedicQuiz()
			
		end
		
		
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

function NPC:DoParamedicQuiz()
	
	if !LocalPlayer():HasCooldown( "paramedicQuiz" ) then
		if !LocalPlayer():getFlag("questTable",{})[5] then
			self:send("startQuizQuest")
		end
		self:addText("Looks like you need to do training first");
		timer.Simple(2,function()
		
			self:DoQuiz()
	
		end)
	
	else
	
		local _HasCD, _CDT, _T = LocalPlayer():HasCooldown( "paramedicQuiz" );
		
		if _HasCD then
		
			self:addText("You may not take another test for " .. 30 / (_CDT/60) .. " minutes")
			
			self:addLeave("Oh okay, I guess I will come back later")
		else
		
		
			self:addLeave("I guess I will come back later")
		end
		
	end
end
function NPC:DoQuiz ()
		if !LocalPlayer():getFlag( "paramedicQuizQ_1", false ) then
			
			local _Q = _quizTable[1].Question
			
			self:addText( _Q )
			local _A = _quizTable[1].Answer
			local _Rand = _quizTable[1].Randoms
			
			local _tbCache = { _Rand[1],_Rand[2],_Rand[3], _A } 
			
			for k , v in pairs( _tbCache ) do
			
				self:addOption( v , function()
				
					self:send( "quizNW",1, v )
					
				end)
			
			end
					
		
		elseif !LocalPlayer():getFlag( "paramedicQuizQ_2", false ) then
	
		
			local _Q = _quizTable[2].Question
			self:addText( _Q )
			local _A = _quizTable[2].Answer
			local _Rand = _quizTable[2].Randoms
			
			local _tbCache = { _Rand[1],_Rand[2],_Rand[3], _A } 
			
			for k , v in pairs( _tbCache ) do
			
				self:addOption( v , function()
				
					self:send( "quizNW",2, v )
					
				end)
			
			end
		elseif !LocalPlayer():getFlag( "paramedicQuizQ_3", false ) then
		
			local _Q = _quizTable[3].Question
			self:addText( _Q )
			local _A = _quizTable[3].Answer
			local _Rand = _quizTable[3].Randoms
			
			local _tbCache = { _Rand[1],_Rand[2],_Rand[3], _A } 
			
			for k , v in pairs( _tbCache ) do
			
				self:addOption( v , function()
				
					self:send( "quizNW", 3 ,v )
					
				end)
			
			end
		else
		
			self:Quest6ClientInfo()
		end
end

net.Receive("sendNextQuestion", function()
	NPC:DoQuiz();
	

end)

function NPC:Quest6ClientInfo()

	if LocalPlayer():FinishedQuest(5) && !LocalPlayer():getFlag("questTable",{})[6] then
	
		self:addText( "Alright you made it through the first part, you are welcome to become a paramedic now." )
		
		self:addText( "Your next task is to make sure that at least 3 people around town are cared for." )
		
		self:send("quest6Start")
		
		self:send("EnterParaForce")
		
	end
	
end