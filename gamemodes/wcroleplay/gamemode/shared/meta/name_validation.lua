

function fsrp.IsValidOrgName ( name )
	if (string.len(name) < 3) then return false; end
	if (string.len(name) >= 150) then return false; end
	
	local name = string.lower(name);
	
	local numDashes = 0;
	for i = 1, string.len(name) do
		local validLetter = false;
		local curChar = string.sub(name, i, i);
		
		if (curChar == "-") then
			numDashes = numDashes + 1;
			
			if (numDashes > 1) then
				return false;
			end
		end
		for k, v in pairs( fsrp.config.OrgCharacter) do
			if (curChar == v) then
				validLetter = true;
				break;
			
			
			end
		end
		
		if (!validLetter) then
			print( curChar )
			//Msg("bad char")
			return false;
		end
	end
	
	return true;
end

function fsrp.IsValidPartialName ( name )
	if (string.len(name) < 3) then return false; end
	if (string.len(name) >= 16) then return false; end
	
	local name = string.lower(name);
	
	local numDashes = 0;
	for i = 1, string.len(name) do
		local validLetter = false;
		local curChar = string.sub(name, i, i);
		
		if (curChar == "-") then
			numDashes = numDashes + 1;
			
			if (numDashes > 1) then
				return false;
			end
		end
		
		for k, v in pairs(fsrp.config.ValidNameCharacters) do
			if (curChar == v) then
				validLetter = true;
				break;
			end
		end
		
		if (!validLetter) then
			Msg("bad char")
			return false;
		end
	end
	
	return true;
end
fsrp.devprint("[WC-RP] - Accquired Name Validations" )

