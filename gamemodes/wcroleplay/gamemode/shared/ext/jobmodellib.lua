
jobMdlTable = {

	[TEAM_PARAMEDIC] = {
		
		[1] = {
		
			// Females
			{ id = 1;  model = 'models/vlrpgaming/hospitalfemale01.mdl'};
			{ id = 2;  model = 'models/vlrpgaming/hospitalfemale02.mdl'};
			{ id = 3;  model = 'models/vlrpgaming/hospitalfemale03.mdl'};
			{ id = 4;  model = 'models/vlrpgaming/hospitalfemale04.mdl'};
			{ id = 5;  model = 'models/vlrpgaming/hospitalfemale05.mdl'};
			{ id = 6;  model = 'models/vlrpgaming/hospitalfemale06.mdl'};
			{ id = 7;  model = 'models/vlrpgaming/hospitalfemale07.mdl'};
			{ id = 8;  model = 'models/vlrpgaming/hospitalfemale08.mdl'};
			{ id = 9;  model = 'models/vlrpgaming/hospitalfemale09.mdl'};
			{ id = 10;  model = 'models/vlrpgaming/hospitalfemale10.mdl'};
			{ id = 11;  model = 'models/vlrpgaming/hospitalfemale11.mdl'};
		
		},
		
		[2] = {
			// Males
			{ id = 1;  model = 'models/vlrpgaming/hospitalmale01.mdl'};
			{ id = 2;  model = 'models/vlrpgaming/hospitalmale02.mdl'};
			{ id = 3;  model = 'models/vlrpgaming/hospitalmale03.mdl'};
			{ id = 4;  model = 'models/vlrpgaming/hospitalmale04.mdl'};
			{ id = 5;  model = 'models/vlrpgaming/hospitalmale05.mdl'};
			{ id = 6;  model = 'models/vlrpgaming/hospitalmale06.mdl'};
			{ id = 7;  model = 'models/vlrpgaming/hospitalmale07.mdl'};
			{ id = 8;  model = 'models/vlrpgaming/hospitalmale08.mdl'};
			{ id = 9;  model = 'models/vlrpgaming/hospitalmale09.mdl'};
			{ id = 10;  model = 'models/vlrpgaming/hospitalmale10.mdl'};
			{ id = 11;  model = 'models/vlrpgaming/hospitalmale11.mdl'};
			{ id = 12;  model = 'models/vlrpgaming/hospitalmale12.mdl'};
			{ id = 13;  model = 'models/vlrpgaming/hospitalmale13.mdl'};
			{ id = 14;  model = 'models/vlrpgaming/hospitalmale14.mdl'};
			{ id = 15;  model = 'models/vlrpgaming/hospitalmale15.mdl'};
			{ id = 16;  model = 'models/vlrpgaming/hospitalmale16.mdl'};
			{ id = 17;  model = 'models/vlrpgaming/hospitalmale17.mdl'};
			{ id = 18;  model = 'models/vlrpgaming/hospitalmale18.mdl'};
			
		},
	},
	[TEAM_POLICE] = {
	
		[2] = {
			// Police Male
			{ id = 2; model = 'models/player/santosrp/male_02_santosrp.mdl'};
			{ id = 4;  model = 'models/player/santosrp/male_04_santosrp.mdl'};
			{ id = 5;  model = 'models/player/santosrp/male_05_santosrp.mdl'};
			{ id = 6;  model = 'models/player/santosrp/male_06_santosrp.mdl'};
			{ id = 7;  model = 'models/player/santosrp/male_07_santosrp.mdl'};
			{ id = 8;  model = 'models/player/santosrp/male_08_santosrp.mdl'};
			{ id = 9;  model = 'models/player/santosrp/male_09_santosrp.mdl'};
		},
		
	},
	[TEAM_MAYOR] = {
	
		[1] = {
		{ id = 1 ; model = "models/captainbigbutt/vocaloid/tda_kenzie.mdl" };
		 
		};
		[2] = {
		{ id = 1; model = "models/sentry/gtav/mexican/mexboss2pm.mdl" } ;
		
		}; 
	
	}
};
jobMdlTable[TEAM_POLICE][1] = jobMdlTable[TEAM_POLICE][2];
function getJobModelTable()

	return jobMdlTable
	
end

local _pMeta = FindMetaTable("Player"); 

function _pMeta:GetJobModel( team )
	if !jobMdlTable[team] then return end
	local _ToGive = ""
		local _defaultParam = "hospitalfemale_1";
			local DefaultMayor = "Liz(11 Noire)";
		
		if _p:getGender() != 1 then
		
			_defaultParam = "hospitalmale_1"
			DefaultMayor = "breen"
			
		end
		
	if team == TEAM_POLICE then
		
		_ToGive = self:getFlag("playerinfo_job_police_model", "Police_4" )
		
	elseif team == TEAM_PARAMEDIC then

		_ToGive = self:getFlag("playerinfo_job_paramedic_model", _defaultParam )
	
	elseif team == TEAM_MAYOR then
	
		_ToGive = self:getFlag("playerinfo_job_mayor_model",  DefaultMayor );
	
	end
	
	return player_manager.TranslatePlayerModel( _ToGive )
	
end
