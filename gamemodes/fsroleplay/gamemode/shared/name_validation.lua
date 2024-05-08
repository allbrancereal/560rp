
fsrp.devprint("[560Roleplay] - Fetching Name Validations " )

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
		
		for k, v in pairs(VALID_NAME_CHARACTERS) do
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

function fsrp.IsValidName ( first, last, skipFirstLast )
	local first = string.lower(first);
	local last = string.lower(last);

	if (!skipFirstLast) then
		if (!fsrp.IsValidPartialName(first)) then return false; end
		if (!fsrp.IsValidPartialName(last)) then return false; end
	end
	
	if (first == "john" && last == "doe") then return false end
	
	
	return true;
end

fsrp.devprint("[560Roleplay] - Accquired Name Validations" )

