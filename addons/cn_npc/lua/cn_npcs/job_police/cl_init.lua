
NPC = NPC or {}
-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Staffing Director Terry"
NPC.model = "models/player/tfa_dcu_cptcold.mdl"

NPC.reputation =1;
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
local policeTalk = {}
policeTalk.AvailableJobs = {
	"Police Officer",
	"S.W.A.T. Officer",
}
policeTalk.onStart = {
	
	Computer = {
		"Welcome to the Police Department. If you are looking for a job then you found the right one.",
		"This is the police department, if you are looking to be hero then look no further.",
		"Welcome back Officer.",
		"Is there anything I can help you with?",
		"Welcome to the force. You can get a squad car in the back.",
		
		"Alright if you say so. Welcome to the Police force. You can get your equipment in the back.",
		"I apologize but there are no more jobs available actually.",
		"I know I told you I would look for a job that you could do, but I found none. You have to go.",
	};
	
	Response = {
		"I am actually looking for a police officer job.",
		"I am here to quit. Here is my badge and pistol.",
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
	
	if _team == TEAM_POLICE then
	
		welcomeText = policeTalk.onStart.Computer[math.random(3,4)]
		
	end
	
	self:addText( welcomeText )
	
	local responseText = _team == TEAM_CIVILLIAN && policeTalk.onStart.Response[1] || _team == TEAM_POLICE && !table.HasValue( {TEAM_POLICE,TEAM_CIVILLIAN} , _team ) && policeTalk.onStart.Response[3] || "";
	local _leaveTxt = policeTalk.onStart.LeaveResponse[math.random(1,4)];
	
			
			if _team == TEAM_CIVILLIAN then
				self:addOption( responseText, function()
					
						self:TryPolice()
						
					
				end)
			end
			
			if _team == TEAM_POLICE then
			
				
				self:addOption( policeTalk.onStart.LeaveResponse[10], function()
					self:send("LeavePoliceForce")

					self:addLeave( "<Leave> " .. policeTalk.onStart.LeaveResponse[9] )
				end)
				
			end
			
			
			if _team != TEAM_CIVILLIAN && _team != TEAM_POLICE then
			
				self:HasJob()
			
			end		
				
		
			
	
	
	
	self:addLeave( "<Leave> " .. _leaveTxt )
	
end

function NPC:TryPolice()
	local _NPCText, _leaveTxt = "", "";
	
	if IsJobFull( TEAM_POLICE ) then
		_leaveTxt = policeTalk.onStart.LeaveResponse[9];
		_npcText = policeTalk.onStart.Computer[math.random(7,8)]
	else		
		
		_NPCText = policeTalk.onStart.Computer[math.random(5,6)];
		_leaveTxt = policeTalk.onStart.LeaveResponse[math.random(5,6)];
		self:send("EnterPoliceForce")
	end
	
	self:addText( _NPCText )
		
	self:addLeave( "<Leave> " .. _leaveTxt  )
	
end

function NPC:HasJob()


	self:addLeave( "<Leave> " .. policeTalk.onStart.LeaveResponse[math.random(7,8)] )

end