
local _pMeta = FindMetaTable( "Player" )
if CLIENT then

net.Receive("sendClientPermData", function( _l, _player )

	local _p = net.ReadString();
	local _tb = net.ReadString();

	local _pByID = player.GetBySteamID(_p);

	if _p == LocalPlayer():SteamID() then
		_pByID = LocalPlayer();
	end
	_pByID:setFlag("PermanentData", util.JSONToTable(_tb));
end)
net.Receive("sendClientHatAdjustment", function()
	
	local _newVec = net.ReadVector()
	local _newAng = net.ReadAngle()
	
	local _p = player.GetBySteamID( net.ReadString() )
	
	if !_p then return end
	_p:setFlag("hatXYZ", _newVec)
	_p:setFlag("hatPYR", _newAng)

end )
fsrp.orgs = fsrp.orgs || {}

net.Receive( "updateClientOrgDefinitions" , function( _l , _p )
	
	if !fsrp.orgs then fsrp.orgs = {} end
	
	fsrp.orgs = net.ReadTable()

end )

local tab = {
	["$pp_colour_addr"] = -0.05,
	["$pp_colour_addg"] = -0.02,
	["$pp_colour_addb"] = -0.02,
	["$pp_colour_brightness"] = .0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = .6,
	["$pp_colour_mulr"] = 1,
	["$pp_colour_mulg"] = 1,
	["$pp_colour_mulb"] = 1,
}
if hook.GetTable()["RenderScreenspaceEffects"]["PPLut"] then
	hook.Remove("RenderScreenspaceEffects","PPLut")
end
hook.Add("RenderScreenspaceEffects", "PPLut", function()
	DrawColorModify( tab ) --Draws Color Modify effect

end )


function MotionBlurHealthEffects()
	if !IsValid(LocalPlayer()) then return end
	DrawMotionBlur(0.2, math.Clamp((40 - LocalPlayer():Health()) * 0.01, 0, 1), FrameTime())
end
hook.Add("RenderScreenspaceEffects", "MotionBlur", MotionBlurHealthEffects)

hook.Add("cardealerCanBuy", "makecardealerrestrictedincity",function( )
	
	return (LocalPlayer():GetPos():Distance(Vector(4698.983398 ,-5161.849609, 128.031250)) < 1000 );

end )
local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
net.Receive("paydayReport", function(_l,_p)

	LocalPlayer().LastPaydaySummary = net.ReadTable();

end)
net.Receive("updatemayorconfig", function(_l,_p)

	fsrp.mayorgovernment = net.ReadTable();

end)

function ShowMayorConfig()
	if LocalPlayer().MayorConfig then
		LocalPlayer().MayorConfig:Remove()
	end

			LocalPlayer():setFlag("restrictInv", true)
	if !LocalPlayer():IsCouncilMember() and LocalPlayer():Team() != TEAM_MAYOR then
		return LocalPlayer():Notify("You need to be a mayor to access this menu!")
	end

	if fsrp.mayorgovernment  and istable(fsrp.mayorgovernment) then
		local FRAME = vgui.Create( "DFrame" ) 
		FRAME:SetSize( _wMod * 550, _hMod *400 )
		FRAME:Center()
		FRAME:SetTitle( "" )
		FRAME:MakePopup()
		FRAME:ShowCloseButton( true )
		FRAME.Alpha = 0;
		FRAME.DoIntro = true;

		function FRAME.OnClose()


			LocalPlayer():setFlag("restrictInv", false)

		end
		FRAME.DoOutro = true;
		FRAME.SelectedValue = 0;
		function FRAME:Paint( w , h )
			
			if self.DoIntro == true  then
			
				self.Alpha = Lerp( 0.1, self.Alpha, 255 )
				
				if self.Alpha >= 254 then
				
					self.DoIntro = false;
				
				end
			
			end
			
			surface.SetDrawColor( 36, 36 ,36 , self.Alpha * 1 )
			surface.DrawRect( 0,0,w,h)
			//surface.SetDrawColor( 56, 56 ,56 , self.Alpha * 1 )
			//surface.DrawRect( 10,10,w-20,h-20)
			draw.SimpleText(fsrp.mayorgovernment.name .. " - Budget Manager" , "Trebuchet24" ,_wMod*5,_hMod*5 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			
		end 

		local sheet = vgui.Create( "DPropertySheet", FRAME )
		sheet:Dock( FILL )


		local panel1 = vgui.Create( "DPanel", sheet )
		panel1.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, Color( 128, 128, 128, self:GetAlpha() ) ) 
			draw.SimpleText("Government Statistics:" , "RobberyTextSmall" ,_wMod*5,_hMod*5 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText("How do I make the government" , "Trebuchet18" ,_wMod*5,_hMod*25 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText("profitable?" , "Trebuchet18" ,_wMod*5,_hMod*36 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			
			draw.SimpleText("You have to balance both limits" , "Trebuchet18" ,_wMod*5,_hMod*50 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText("and paydays to make money while" , "Trebuchet18" ,_wMod*5,_hMod*61 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText("appeasing your citizens." , "Trebuchet18" ,_wMod*5,_hMod*72 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText("Remember, your term is limited." , "Trebuchet18" ,_wMod*5,_hMod*83 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			
			draw.SimpleText("How long do I have?" , "Trebuchet18" ,_wMod*5,_hMod*105 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText("8 Paycheques." , "Trebuchet18" ,_wMod*5,_hMod*116 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			
			draw.SimpleText("Are civillians allowed to kill me" , "Trebuchet18" ,_wMod*5,_hMod*135 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText("because of my tax plan?" , "Trebuchet18" ,_wMod*5,_hMod*146 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			
			draw.SimpleText("Only if you raise taxes beyond 25%!" , "Trebuchet18" ,_wMod*5,_hMod*157 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		end
		sheet:AddSheet( "Status", panel1, "icon16/arrow_out.png" )

		local listpanel= vgui.Create("DPanel", panel1)
		listpanel:SetSize(_wMod*300,_hMod*300)
		listpanel:SetPos(_wMod*215,_hMod*25)


		local AppList = vgui.Create( "DListView", listpanel )
		AppList:Dock( FILL )
		AppList:SetMultiSelect( false )
		AppList:AddColumn( "Memo" )
		AppList:AddColumn( "Value" )

		LocalPlayer().MayorConfig = FRAME;


		/*

		fsrp.mayorgovernmentdefault = {
			money = fsrp.config.mayoral.citybaseincome,
			carlimits = {
				policecruiser = fsrp.config.mayoral.carlimits.police.default,
				ambulance = fsrp.config.mayoral.carlimits.ambulance.default,
			},
			tax = {
				income = fsrp.config.mayoral.taxinfo.income.default;
				sales = fsrp.config.mayoral.taxinfo.sales.default
			},
			salary = {
				[TEAM_PARAMEDIC] = fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].default;
				[TEAM_MAYOR] = fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].default;
				[TEAM_POLICE] = fsrp.config.mayoral.salaryinfo[TEAM_POLICE].default;
				[TEAM_CIVILLIAN] = fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].default;
			},
		}
		*/


		AppList:AddLine("-- Government Statistics -- ", "-- --")
		if fsrp.mayorgovernment.money then
			AppList:AddLine( "Government Money", "$"..  tostring(math.Round( fsrp.mayorgovernment.money,2)) )
		else 
			AppList:AddLine( "Government Money", "N/A" )
		end
		AppList:AddLine("-- Mayor Statistics -- ", "-- --")
		if fsrp.mayorgovernment.salary[TEAM_MAYOR] then
			AppList:AddLine(  "Base Mayor Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_MAYOR],2)) )
		else 
			AppList:AddLine(  "Base Mayor Salary", "N/A" )
		end
		AppList:AddLine("-- Police Statistics -- ", "-- --")
		if fsrp.mayorgovernment.carlimits.policecruiser then
			AppList:AddLine(  "Maximum Police Cruisers",  "$"..tostring(math.Round(fsrp.mayorgovernment.carlimits.policecruiser,2)) )
			AppList:AddLine(  "Total Police Vehicle Cost",  "$"..tostring(math.Round(fsrp.config.mayoral.carlimits.police.policecarcost*fsrp.mayorgovernment.carlimits.policecruiser,2)) )
		else 
			AppList:AddLine(  "Maximum Police Cruisers", "N/A" )
			AppList:AddLine(  "Maximum Police Cruisers", "N/A" )
		end
		if fsrp.mayorgovernment.salary[TEAM_POLICE] then
			AppList:AddLine(  "Base Police Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_POLICE],2)) )
		else 
			AppList:AddLine(  "Base Police Salary", "N/A" )
		end
		AppList:AddLine("-- Paramedic Statistics -- ", "-- --")
		if fsrp.mayorgovernment.carlimits.ambulance then
			AppList:AddLine(  "Maximum Ambulances",  "$"..tostring(math.Round(fsrp.mayorgovernment.carlimits.ambulance,2)) )
			AppList:AddLine(  "Maximum Ambulances",  "$"..tostring(math.Round(fsrp.config.mayoral.carlimits.ambulance.ambulancecost*fsrp.mayorgovernment.carlimits.ambulance,2)) )
		else 
			AppList:AddLine(  "Maximum Ambulances", "N/A" )
			AppList:AddLine(  "Base Civillian Salary", "N/A" )
		end
		if fsrp.mayorgovernment.salary[TEAM_PARAMEDIC] then
			AppList:AddLine( "Base Paramedic Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_PARAMEDIC],2)) )
		else 
			AppList:AddLine(  "Base Paramedic Salary", "N/A" )
		end
			
		AppList:AddLine("-- Civillian Statistics -- ", "-- --")
		if fsrp.mayorgovernment.salary[TEAM_CIVILLIAN] then
			AppList:AddLine(  "Base Civillian Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_CIVILLIAN],2)) )
		else 
			AppList:AddLine(  "Base Civillian Salary", "N/A" )
		end
		if fsrp.mayorgovernment.tax.income then
			AppList:AddLine( "Income Tax", tostring(math.Round(fsrp.mayorgovernment.tax.income,2)) .. "%" )
		else 
			AppList:AddLine("Income Tax", "N/A" )
		end
		if fsrp.mayorgovernment.tax.sales then
			AppList:AddLine( "Sales Tax",tostring(math.Round(fsrp.mayorgovernment.tax.sales,2)) .. "%" )
		else 
			AppList:AddLine("Sales Tax", "N/A" )
		end
		local panel2 = vgui.Create( "DPanel", sheet )
		panel2.Paint = function( self, w, h ) 
			draw.RoundedBox( 4, 0, 0, w, h, Color( 128, 128, 128, self:GetAlpha() ) )
			draw.SimpleText("Adjust settings and save them afterwards." , "Trebuchet24" ,_wMod*5,_hMod*5 , Color( 255 ,255 ,255 , FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 

			 end
		sheet:AddSheet( "Budget", panel2, "icon16/money.png" )

		local Slider_MayorSalary = vgui.Create( "DNumSlider", panel2 )
		Slider_MayorSalary:SetPos( _wMod*50,_hMod* 25 )			// Set the position
		Slider_MayorSalary:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_MayorSalary:SetText( "Mayor Salary: (Adjust your own)" )	// Set the text above the slider
		Slider_MayorSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].min )				// Set the minimum number you can slide to
		Slider_MayorSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].max )				// Set the maximum number you can slide to
		Slider_MayorSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_MAYOR])

		Slider_MayorSalary:SetDecimals( 0 )			// Decimal places - zero for whole numbe

		local Slider_MaxPoliceCruisers = vgui.Create( "DNumSlider", panel2 )
		Slider_MaxPoliceCruisers:SetPos( _wMod*50,_hMod* 55 )			// Set the position
		Slider_MaxPoliceCruisers:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_MaxPoliceCruisers:SetText( "Maximum Police Cruisers:" )	// Set the text above the slider
		Slider_MaxPoliceCruisers:SetMin( 0 )				// Set the minimum number you can slide to
		Slider_MaxPoliceCruisers:SetMax( fsrp.config.mayoral.carlimits.police.maxpolicecars )				// Set the maximum number you can slide to
		Slider_MaxPoliceCruisers:SetDecimals( 0 )			// Decimal places - zero for whole numbe
		Slider_MaxPoliceCruisers:SetValue(fsrp.mayorgovernment.carlimits.policecruiser)

		local Slider_PoliceSalary = vgui.Create( "DNumSlider", panel2 )
		Slider_PoliceSalary:SetPos( _wMod*50,_hMod* 85 )			// Set the position
		Slider_PoliceSalary:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_PoliceSalary:SetText( "Police Salary:" )	// Set the text above the slider
		Slider_PoliceSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_POLICE].min )				// Set the minimum number you can slide to
		Slider_PoliceSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_POLICE].max )				// Set the maximum number you can slide to
		Slider_PoliceSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_POLICE])
		Slider_PoliceSalary:SetDecimals( 0 )			// Decimal places - zero for whole numbe
		
		local Slider_MaxAmbulances = vgui.Create( "DNumSlider", panel2 )
		Slider_MaxAmbulances:SetPos( _wMod*50,_hMod* 115 )			// Set the position
		Slider_MaxAmbulances:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_MaxAmbulances:SetText( "Maximum Ambulances:" )	// Set the text above the slider
		Slider_MaxAmbulances:SetMin( 0 )				// Set the minimum number you can slide to
		Slider_MaxAmbulances:SetMax(  fsrp.config.mayoral.carlimits.ambulance.maxambulances )				// Set the maximum number you can slide to
		Slider_MaxAmbulances:SetDecimals( 0 )			// Decimal places - zero for whole numbe
		Slider_MaxAmbulances:SetValue(fsrp.mayorgovernment.carlimits.ambulance)
		
		local Slider_ParaSalary = vgui.Create( "DNumSlider", panel2 )
		Slider_ParaSalary:SetPos( _wMod*50,_hMod* 145 )			// Set the position
		Slider_ParaSalary:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_ParaSalary:SetText( "Paramedic Salary" )	// Set the text above the slider
		Slider_ParaSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].min )				// Set the minimum number you can slide to
		Slider_ParaSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].max )				// Set the maximum number you can slide to
		Slider_ParaSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_PARAMEDIC])
		Slider_ParaSalary:SetDecimals( 0 )			// Decimal places - zero for whole numbe
		

		local Slider_CivSalary = vgui.Create( "DNumSlider", panel2 )
		Slider_CivSalary:SetPos( _wMod*50,_hMod* 175 )			// Set the position
		Slider_CivSalary:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_CivSalary:SetText( "Civillian Base Salary" )	// Set the text above the slider
		Slider_CivSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].min )				// Set the minimum number you can slide to
		Slider_CivSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].max )				// Set the maximum number you can slide to
		Slider_CivSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_CIVILLIAN])
		Slider_CivSalary:SetDecimals( 0 )			// Decimal places - zero for whole numbe
		
		local Slider_IncomeTax = vgui.Create( "DNumSlider", panel2 )
		Slider_IncomeTax:SetPos( _wMod*50,_hMod* 205 )			// Set the position
		Slider_IncomeTax:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_IncomeTax:SetText( "Income Tax" )	// Set the text above the slider
		Slider_IncomeTax:SetMin( fsrp.config.mayoral.taxinfo.income.min )				// Set the minimum number you can slide to
		Slider_IncomeTax:SetMax( fsrp.config.mayoral.taxinfo.income.max )				// Set the maximum number you can slide to
		Slider_IncomeTax:SetDecimals( 0 )			// Decimal places - zero for whole numbe
		Slider_IncomeTax:SetValue(fsrp.mayorgovernment.tax.income)
		local Slider_SalesTax = vgui.Create( "DNumSlider", panel2 )
		Slider_SalesTax:SetPos( _wMod*50,_hMod* 235 )			// Set the position
		Slider_SalesTax:SetSize( 450*_wMod, _hMod*50 )		// Set the size
		Slider_SalesTax:SetText( "Sales Tax" )	// Set the text above the slider
		Slider_SalesTax:SetMin( fsrp.config.mayoral.taxinfo.sales.min )				// Set the minimum number you can slide to
		Slider_SalesTax:SetMax( fsrp.config.mayoral.taxinfo.sales.max )				// Set the maximum number you can slide to
		Slider_SalesTax:SetDecimals( 0 )			// Decimal places - zero for whole numbe
		Slider_SalesTax:SetValue(fsrp.mayorgovernment.tax.sales)
		local TextEntry = vgui.Create( "DTextEntry", panel2 ) -- create the form as a child of frame
		TextEntry:SetPos( _wMod*50,_hMod* 290 )			// Set the position
		TextEntry:SetSize( 450*_wMod, _hMod*25 )		// Set the size
		TextEntry:SetText( fsrp.mayorgovernment.name )
		TextEntry.OnEnter = function( self )

		end
		local function UpdateSliders()

			if !FRAME then return end
			Slider_SalesTax:SetValue(fsrp.mayorgovernment.tax.sales)
			Slider_IncomeTax:SetMin( fsrp.config.mayoral.taxinfo.income.min )				// Set the minimum number you can slide to
			Slider_IncomeTax:SetMax( fsrp.config.mayoral.taxinfo.income.max )				// Set the maximum number you can slide to
			Slider_IncomeTax:SetValue(fsrp.mayorgovernment.tax.income)
			Slider_SalesTax:SetMin( fsrp.config.mayoral.taxinfo.sales.min )				// Set the minimum number you can slide to
			Slider_SalesTax:SetMax( fsrp.config.mayoral.taxinfo.sales.max )				// Set the maximum number you can slide to
			Slider_MayorSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].min )				// Set the minimum number you can slide to
			Slider_MayorSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].max )				// Set the maximum number you can slide to
			Slider_MayorSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_MAYOR])
			Slider_MaxPoliceCruisers:SetMax( fsrp.config.mayoral.carlimits.police.maxpolicecars )	
			Slider_MaxPoliceCruisers:SetValue(fsrp.mayorgovernment.carlimits.policecruiser)
			Slider_PoliceSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_POLICE].min )				// Set the minimum number you can slide to
			Slider_PoliceSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_POLICE].max )				// Set the maximum number you can slide to
			Slider_PoliceSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_POLICE])
			Slider_MaxAmbulances:SetMax(  fsrp.config.mayoral.carlimits.ambulance.maxambulances )	
			Slider_MaxAmbulances:SetValue(fsrp.mayorgovernment.carlimits.ambulance)
			Slider_ParaSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].min )				// Set the minimum number you can slide to
			Slider_ParaSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].max )				// Set the maximum number you can slide to
			Slider_ParaSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_PARAMEDIC])
			Slider_CivSalary:SetMin( fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].min )				// Set the minimum number you can slide to
			Slider_CivSalary:SetMax( fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].max )				// Set the maximum number you can slide to
			Slider_CivSalary:SetValue(fsrp.mayorgovernment.salary[TEAM_CIVILLIAN])
			Slider_IncomeTax:SetMin( fsrp.config.mayoral.taxinfo.income.min )				// Set the minimum number you can slide to
			Slider_IncomeTax:SetMax( fsrp.config.mayoral.taxinfo.income.max )	
			Slider_IncomeTax:SetValue(fsrp.mayorgovernment.tax.income)
			Slider_SalesTax:SetMin( fsrp.config.mayoral.taxinfo.sales.min )				// Set the minimum number you can slide to
			Slider_SalesTax:SetMax( fsrp.config.mayoral.taxinfo.sales.max )	
			TextEntry:SetText( fsrp.mayorgovernment.name )
		end
		
		local function GetSliderVals( )
			_tbl = {
				name = TextEntry:GetValue(),
				tax = { 
					sales = Slider_SalesTax:GetValue(),
					income =Slider_IncomeTax:GetValue(),
				},
				salary = {
					[TEAM_CIVILLIAN]=Slider_CivSalary:GetValue(),
					[TEAM_PARAMEDIC]=Slider_ParaSalary:GetValue(),
					[TEAM_POLICE]=Slider_PoliceSalary:GetValue(),
					[TEAM_MAYOR]=Slider_MayorSalary:GetValue(),
				},
				maxvehicles = {
					police = Slider_MaxPoliceCruisers:GetValue(),
					ambulance = Slider_MaxAmbulances:GetValue(),
				}
			}
			return _tbl
		end
		
		local _but = vgui.Create("DButton", panel2)
		_but:SetSize(_wMod*125,_hMod*30)
		_but:SetPos(_wMod*385,_hMod*5)
		_but:SetText("Save!")

		function _but:OnMousePressed()
			net.Start("updatemayorconfig")
			net.WriteTable(GetSliderVals())
			net.SendToServer()
			timer.Simple(1, function() if IsValid(FRAME) then
				 UpdateSliders()

				end
			end)
		end
		
		return FRAME
	else
		return

	end
end


function ShowPaydaySummary(payday)
	if LocalPlayer().PaydaySummary then
		LocalPlayer().PaydaySummary:Remove()
	end

	local FRAME = vgui.Create( "DFrame" ) 
	FRAME:SetSize( _wMod * 300, _hMod * 150 )
	FRAME:Center()
	FRAME:SetTitle( "Payday Summary" )
	FRAME:MakePopup()
	FRAME:ShowCloseButton( true )
	FRAME.Alpha = 0;
	FRAME.DoIntro = true;
	FRAME.DoOutro = true;
	FRAME.SelectedValue = 0;
	function FRAME:Paint( w , h )
		
		if self.DoIntro == true  then
		
			self.Alpha = Lerp( 0.1, self.Alpha, 255 )
			
			if self.Alpha >= 254 then
			
				self.DoIntro = false;
			
			end
		
		end
		
		surface.SetDrawColor( 36, 36 ,36 , self.Alpha * 1 )
		surface.DrawRect( 0,0,w,h)
		//surface.SetDrawColor( 56, 56 ,56 , self.Alpha * 1 )
		//surface.DrawRect( 10,10,w-20,h-20)
		
	end 
	

	local AppList = vgui.Create( "DListView", FRAME )
	AppList:Dock( FILL )
	AppList:SetMultiSelect( false )
	AppList:AddColumn( "Memo" )
	AppList:AddColumn( "Credit/Debit" )

	LocalPlayer().PaydaySummary = FRAME;


	if payday and istable(payday) then
		if payday.earned then
			AppList:AddLine( "Income Pay","+$".. tostring(math.Round(payday.earned,2)))
		else 
			AppList:AddLine( "Income Pay", "N/A" )
			
		end
		if payday.incometax then
			AppList:AddLine( "Taxed Income", "-$".. tostring(math.Round(payday.incometax,2)) )
		else 
			AppList:AddLine( "Taxed Income", "N/A" )
		end
		if payday.propertyinvestment then
			AppList:AddLine( "Property Investments", "+$".. tostring(math.Round(payday.propertyinvestment,2)))
		else 
		AppList:AddLine( "Property Investments", "N/A" )
			
		end
		if payday.zoneincome then
			AppList:AddLine( "Zone Income", "+$".. tostring(math.Round(payday.zoneincome,2)) )
		else 
			AppList:AddLine( "Zone Income", "N/A" )
		end
	else
		AppList:AddLine( "No Information Available", "N/A" )
	end

	/*

	fsrp.mayorgovernmentdefault = {
		money = fsrp.config.mayoral.citybaseincome,
		carlimits = {
			policecruiser = fsrp.config.mayoral.carlimits.police.default,
			ambulance = fsrp.config.mayoral.carlimits.ambulance.default,
		},
		tax = {
			income = fsrp.config.mayoral.taxinfo.income.default;
			sales = fsrp.config.mayoral.taxinfo.sales.default
		},
		salary = {
			[TEAM_PARAMEDIC] = fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].default;
			[TEAM_MAYOR] = fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].default;
			[TEAM_POLICE] = fsrp.config.mayoral.salaryinfo[TEAM_POLICE].default;
			[TEAM_CIVILLIAN] = fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].default;
		},
	}
	*/

	if fsrp.mayorgovernment  and istable(fsrp.mayorgovernment) then

		if fsrp.mayorgovernment.money then
			AppList:AddLine( "Government Money", "$"..  tostring(math.Round( fsrp.mayorgovernment.money,2)) )
		else 
			AppList:AddLine( "Government Money", "N/A" )
		end
		if fsrp.mayorgovernment.tax.income then
			AppList:AddLine( "Income Tax", tostring(math.Round(fsrp.mayorgovernment.tax.income,2)) .. "%" )
		else 
			AppList:AddLine("Income Tax", "N/A" )
		end
		if fsrp.mayorgovernment.tax.sales then
			AppList:AddLine( "Sales Tax",tostring(math.Round(fsrp.mayorgovernment.tax.sales,2)) .. "%" )
		else 
			AppList:AddLine("Sales Tax", "N/A" )
		end
		if fsrp.mayorgovernment.salary[TEAM_PARAMEDIC] then
			AppList:AddLine( "Base Paramedic Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_PARAMEDIC],2)) )
		else 
			AppList:AddLine(  "Base Paramedic Salary", "N/A" )
		end
		if fsrp.mayorgovernment.salary[TEAM_MAYOR] then
			AppList:AddLine(  "Base Mayor Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_MAYOR],2)) )
		else 
			AppList:AddLine(  "Base Mayor Salary", "N/A" )
		end
		if fsrp.mayorgovernment.salary[TEAM_POLICE] then
			AppList:AddLine(  "Base Police Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_POLICE],2)) )
		else 
			AppList:AddLine(  "Base Police Salary", "N/A" )
		end
		if fsrp.mayorgovernment.salary[TEAM_CIVILLIAN] then
			AppList:AddLine(  "Base Civillian Salary",  "$"..tostring(math.Round(fsrp.mayorgovernment.salary[TEAM_CIVILLIAN],2)) )
		else 
			AppList:AddLine(  "Base Civillian Salary", "N/A" )
		end
		
	end

	return FRAME
end

function ShowBankATMMenu()

	local _p = LocalPlayer();
	if _p:getBankAccount() <= 0 then return _p:Notify("You must establish a bank account.") end
	
	local FRAME = vgui.Create( "DFrame" ) 
	FRAME:SetSize( _wMod * 300, _hMod * 225 )
	FRAME:Center()
	FRAME:SetTitle( "" )
	FRAME:MakePopup()
	FRAME:ShowCloseButton( false )
	FRAME.Alpha = 0;
	FRAME.DoIntro = true;
	FRAME.DoOutro = true;
	FRAME.SelectedValue = 0;
	function FRAME:Paint( w , h )
		
		if self.DoIntro == true  then
		
			self.Alpha = Lerp( 0.1, self.Alpha, 255 )
			
			if self.Alpha >= 254 then
			
				self.DoIntro = false;
			
			end
		
		end
		
		surface.SetDrawColor( 128, 175 ,128 , self.Alpha * 0.5 )
		surface.DrawRect( 0,0,w,h)
		surface.SetDrawColor( 128, 175 ,128 , self.Alpha * 0.9 )
		surface.DrawRect( 10,10,w-20,h-20)
		
	end 
	
	
	local DermaNumSlider = FRAME:Add( "DNumSlider" )
	DermaNumSlider:SetPos( _wMod * 15, _hMod * 30 )			// Set the position
	DermaNumSlider:SetSize( FRAME:GetWide() - _wMod * 20,  _hMod * 25 )		// Set the size
	local _MoneyLabel = FRAME:Add( "DLabel" )
	_MoneyLabel:SetPos( _wMod * 15, _hMod * 30 )			// Set the position
	_MoneyLabel:SetSize( FRAME:GetWide()/2 - _wMod * 20,  _hMod * 25 )		// Set the size
	_MoneyLabel:SetTextColor(Color(56,56,56,220))
	_MoneyLabel:SetFont("RobberyTextSuperSmall")
	_MoneyLabel:SetText( "Bank $" .. math.Round(_p:getBank( ),2) )	// Set the text above the slider
	DermaNumSlider:SetText( "" )	// Set the text above the slider
	DermaNumSlider:SetMin( -_p:getMoney() )				// Set the minimum number you can slide to
	DermaNumSlider:SetMax( _p:getBank() )				// Set the maximum number you can slide to
	DermaNumSlider:SetDecimals( 0 )			// Decimal places - zero for whole number
	//DermaNumSlider:SetColor(Color(0,0,0))
	local AcceptButton = FRAME:Add( "DButton" )
	function DermaNumSlider:OnValueChanged( val ) 
		local _pre = "Withdraw";
		
		FRAME.SelectedValue = math.Clamp(val, -_p:getMoney(), _p:getBank());
		if FRAME.SelectedValue < 0 then

			_pre = "Deposit";
			
		end
		AcceptButton:SetText( _pre .. " $" .. math.floor(val) )
	end
	
	
	function DermaNumSlider:Think() 
	
		
		_MoneyLabel:SetText( "Bank $" .. math.Round( _p:getBank( ),2) )	// Set the text above the slider
		self:SetMin( -_p:getMoney() )				// Set the minimum number you can slide to
		self:SetMax( _p:getBank() )				// Set the maximum number you can slide to
		self:SetDecimals( 0 )	
		
	end
	
	
	AcceptButton:SetPos( FRAME:GetWide() *0.1555555 , _hMod * 75 )
	AcceptButton:SetSize( _wMod * 100, _hMod * 50 )
	
	AcceptButton:SetText( "Chose Amount" )
	function AcceptButton:OnMousePressed( k )
		/*
		net.Start("bankATMExchange")
			net.WriteInt( FRAME.SelectedValue , 32 )
		net.SendToServer()
		timer.Simple( 0.25 , function()
			DermaNumSlider:SetText( "$" .. _p:getBank( ) )	// Set the text above the slider
			DermaNumSlider:SetMin( -_p:getMoney() )				// Set the minimum number you can slide to
			DermaNumSlider:SetMax( _p:getBank() )				// Set the maximum number you can slide to
		
		
		end )
		*/

		net.Start("bankATMExchange")
			net.WriteInt( FRAME.SelectedValue , 32 )
		net.SendToServer()
		FRAME.SelectedValue = 0;

		_MoneyLabel:SetText( "$0" )

		DermaNumSlider:SetValue( 0 )
		AcceptButton:SetText( "$0" )
	end 
	
	local CloseButton = FRAME:Add( "DButton" )
	CloseButton:SetPos( FRAME:GetWide()*0.5 + _wMod * 10, _hMod * 75 )
	CloseButton:SetPos( FRAME:GetWide()*0.333333, _hMod * 150 )
	CloseButton:SetSize( _wMod * 100, _hMod * 50 )
	CloseButton:SetText( "Close" )
	
	function CloseButton:OnMousePressed( k )
		FRAME:Close()
		
			
		
	end 	
	
	local LastPaydaySummary = FRAME:Add( "DButton" )
	LastPaydaySummary:SetPos( FRAME:GetWide()*0.488888, _hMod * 75 )
	LastPaydaySummary:SetSize( _wMod * 100, _hMod * 50 )
	LastPaydaySummary:SetText( "Payday Summary" )
	
	function LastPaydaySummary:OnMousePressed( k )
		FRAME:Close()
		
		ShowPaydaySummary(LocalPlayer().LastPaydaySummary)
		
	end 	
	
end

net.Receive( "sendSong", function( )

	LocalPlayer():StartShopMusic( ) ;
	
end )

function _pMeta:StartShopMusic( )
			if !steamworks.IsSubscribed( fsrp.config.WorkshopSounds ) then return end
			
			if self.shopMusic then
			
				self.shopMusic:Stop()
				self.shopMusic = nil;
			
			end
			
			sound.PlayFile( "sound/shop/shop_" .. math.random(1,2).. ".wav" , "", function( station )
				if ( IsValid( station ) ) then 
					self.shopMusic = station; 
					station:SetVolume( 10 ) 
					station:Play() 
				end
			end )
			

end

function _pMeta:StopShopMusic( )

	if !steamworks.IsSubscribed( fsrp.config.WorkshopSounds ) then return end
	if !self.shopMusic then return end
	
	self.shopMusic:Pause();
	self.shopMusic = nil;
	
end

end

	net.Receive( "fsrp.startUser" , function ( len , _p )
		ply:setFlag("creatingCharacter" , true )
		StartCreateACharacterMenu( )
		//LoadHud()
		// 
	end ) 
	net.Receive( "UpdateHUD", function( len , _p )
	
		timer.Simple( 1, function() 
			//LoadHud()
			print("Aborted reloading of hud because of bugs")
		end)
	end)
	function getThirdpersonVar()
	
		return GetConVar("wc_thirdperson");
	
	end
	concommand.Add( "lookup", function( ply, cmd, args )

	  
		local find = string.lower( tostring( args[1] ) )
		
		print( "Looking up: " .. find )
		
		for k,v in pairs( player.GetAll() ) do
			if string.find( string.lower( v:Nick() ), find ) or string.find( string.lower( v:getRPName() ), find ) then
				print( "Steam Name: " .. v:Nick() )
				print( "RP Name: " .. v:getRPName() )
				print( "SteamID: " .. v:SteamID() )
				print( "Job: " .. team.GetName( v:Team() ) )
			end
		end
		
	end )
	net.Receive("networkPostServerPlayerSpawn", function( _len, _p )
	
	
		if LocalPlayer().__hadThirdpersonBeforeDeath then
		
			
			LocalPlayer():ConCommand("hat_thirdperson_enable 1");
		
		end
	
	end )
	
	net.Receive("turnThirdpersonOff", function( _len, _p )
	
		local _con = getThirdpersonVar();
		
		if _con:GetInt() == 1 then
		
			LocalPlayer():ConCommand("hat_thirdperson_enable 0");
			LocalPlayer().__hadThirdpersonBeforeDeath = true;
			
		end
	
	end)
	

	function HealthEffects()
		if !IsValid(LocalPlayer()) then return end
		DrawMotionBlur(0.2, math.Clamp((40 - LocalPlayer():Health()) * 0.01, 0, 1), FrameTime())
	end
	hook.Add("RenderScreenspaceEffects", "GM.HealthEffects", HealthEffects)

     local function CalcView( pl, origin, angles, fov )
	 
		if pl:Alive() then return end
         // get their ragdoll
       local ragdoll = pl:GetRagdollEntity();
       if( !ragdoll || ragdoll == NULL || !ragdoll:IsValid() ) then return; end
       
        // find the eyes
        local eyes = ragdoll:GetAttachment( ragdoll:LookupAttachment( "eyes" ) );
        
         // setup our view
         local view = {
             origin = eyes.Pos,
             angles = eyes.Ang,
			 fov = 90, 
         };
        
          //
         return view;
     
      end
      hook.Add( "CalcView", "DeathView", CalcView );
net.Receive( "networkJobTimes" , function( len , _p )
	
	local _stID = net.ReadString( );
	local _joTb	= net.ReadTable( );
	//PrintTable( _joTb ) 
	
	
	if _stID == LocalPlayer():SteamID() then
	
		LocalPlayer():setFlag( "jobPlaytimes", _joTb )
		LocalPlayer().__JobPlayTimes = _joTb
		return
		
		
	end
	
	for k , v in pairs( player.GetAll() ) do
		
		if v:SteamID() == _stID then
		
			v.__JobPlayTimes = _joTb
			v:setFlag("jobPlaytimes", _joTb )
		
		end
		
	end

end )

fsrp.Intro = nil;

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

net.Receive( "inventorySync", function( len , _p )
	
	//local _id = net.ReadString();
	//local _inv = net.ReadTable();
	//LocalPlayer():setFlag( "inventory", _inv )
	if LocalPlayer().ActionBar then
 		LocalPlayer().ActionBar.inv = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ));
		for i =1,6 do
			 LocalPlayer().ActionBar.ItemSlot[i]:SetItemTable()
		end
	end
	
	
end )
local _p=LocalPlayer();

function splittokens(s)
    local res = {}
    for w in s:gmatch("%S+") do
        res[#res+1] = w
    end
    return res
end
 
function textwrap(text, linewidth)
    if not linewidth then
        linewidth = 75
    end
 
    local spaceleft = linewidth
    local res = {}
    local line = {}
 
    for _, word in ipairs(splittokens(text)) do
        if #word + 1 > spaceleft then
            table.insert(res, table.concat(line, ' '))
            line = {word}
            spaceleft = linewidth - #word
        else
            table.insert(line, word)
            spaceleft = spaceleft - (#word + 1)
        end
    end
 
    table.insert(res, table.concat(line, ' '))
    return table.concat(res, ' ')
end
function DrawActionBar()
	if LocalPlayer().ActionBar and ispanel(LocalPlayer().ActionBar) then LocalPlayer().ActionBar:Remove() end
	local _abar = vgui.Create("DFrame")
	_abar:SetPos((ScrW()/2)-(_wMod*300),_hMod*900);
	_abar:SetSize(_wMod*600,_hMod*200);
	_abar:ShowCloseButton(false)
	_abar:SetTitle("") 
 	_abar.inv = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ));
	_abar.ItemSlot = {};
	local _lastinvcheck = CurTime()
 	local _items = LocalPlayer():getFlag("actionbarslots",{})
	function _abar:Paint(w,h)
 		if _lastinvcheck+1>CurTime() then
 			self.inv = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ));
 		end
		surface.SetDrawColor( 36, 36 ,36 , 128 )
		surface.DrawRect( 0,0,w,_hMod*100)
		for i=1,6 do 

			if _items and _items[i] and _items[i].ID and self.inv[_items[i].ID]  then
				local _itemname = ITEMLIST[self.inv[_items[i].ID].ID].Name;

				draw.SimpleText( #_itemname > 15 && splittokens(_itemname)[1] .. "... " or _itemname , "Trebuchet18" ,(_wMod*50+(_wMod*100)*(i-1)),_hMod*105 , Color( 255 ,255 ,255 ,255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
			end		
		end

	end 
	function _abar:Update()
		timer.Simple(.5,function()
			if LocalPlayer().ActionBar.ItemSlot then 
				for k , v in pairs(LocalPlayer().ActionBar.ItemSlot) do if v and ispanel(v) then v:Remove() end end
			end
			local _slots = LocalPlayer():getFlag("actionbarslots",{})
			for i=1,6 do 
				local _info = _slots[i]
				local _ac = vgui.Create("inventoryitem",_abar)
				_ac:SetPos((_wMod*5+(_wMod*100)*(i-1)),_hMod* 5)
				_ac:SetSize((_wMod*90),_hMod*90)
				_ac.slot = i;

				LocalPlayer().ActionBar.ItemSlot[i] = _ac;
				if _info then
					_ac.ID = _info.ID
					_ac.ItemSlot = _info.ItemSlot
					_ac:SetItemTable()
				end
				function _ac:OnMouseReleased(k) 
					self.MousePress = CurTime()
					if k == MOUSE_RIGHT then
						local _target =nil
						//local _inv = LoadStringToInventory(_p:getFlag("inventory", nil ))
						local _abar = LocalPlayer().ActionBar;
						_abar.ItemSlot[i].ItemSlot = _target;
						_abar.ItemSlot[i].ID = _target//self.InventorySlotCache[self.TargetUI.SlotID].ID;
						_abar.ItemSlot[i]:SetItemTable()
						local _stbl = _p:getFlag("actionbarslots",{});
						_stbl[i] = {};
						_stbl[i].ItemSlot = _target
						_stbl[i].ID = _target

						_p:setFlag("actionbarslots",_stbl)
						net.Start("sendItemSlots")
							net.WriteTable(_stbl)
						net.SendToServer()						  
					end
					self:OnMouseReleasedImplementation(MOUSE_LEFT,true) 
					self:GetParent():Update();
				end

			end
		end)
	end
	LocalPlayer().ActionBar =_abar;
	_abar:Update()
end

hook.Add("PlayerFullyConnected", "DoIntro", function( )
	
	if !steamworks.IsSubscribed( "2122465484") then
			
		LocalPlayer():Notify("If you go to F1 and click on steam workshop you can subscribe to the content!")
	
	end
	if !IntroCinematic then
		timer.Simple(6,function()
			IntroCinematic = vgui.Create("cinematicintro");
			DrawWeaponWheel()
		end)
	end

end)


local _startedUI = false;
hook.Add("HUDPaint", "StartUI",function()

	if _startedUI == false then
		timer.Simple(1,function()
			DrawActionBar()
			DrawWeaponWheel()
			_startedUI = true
		end)

	end

	hook.Remove("HUDPaint","StartUI")
end)
gameevent.Listen( "player_spawn" )
hook.Add("player_spawn", "DrawHUDElements_Event", function(data)
	DrawActionBar()
	DrawWeaponWheel()
end)

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

function DrawWeaponWheel()
	if LocalPlayer().WeaponWheel and ispanel(LocalPlayer().WeaponWheel) then 
		LocalPlayer().WeaponWheel:Remove()
		LocalPlayer().WeaponWheel = nil;
	end
	local _pWeps = LocalPlayer():GetWeapons();
	local _pWepsSize = #_pWeps;
	local _size = _pWepsSize*(_hMod*55);
	local _wwheel = vgui.Create("DFrame")
	LocalPlayer().WeaponWheel =_wwheel;
	_wwheel:SetPos(_wMod*1600,_hMod*250)
	_wwheel:SetSize(_wMod*400,_size)
	_wwheel:SetTitle("")
	_wwheel:ShowCloseButton(false)
	_wwheel.WeaponShows = {};
	function _wwheel:Update()
		timer.Simple(.1,function()
			_pWeps = LocalPlayer():GetWeapons();
			if _pWeps == nil then return end 
			_pWepsSize = #_pWeps;
			_size = _pWepsSize*(_hMod*55);
			local _wepwheel = LocalPlayer().WeaponWheel
			_wepwheel:SetSize(_wMod*400,_size)
			//for k , v in pairs( _wwheel.WeaponShows) do v:Remove() end
			for k , v in pairs( _pWeps ) do 
				local _b = _wepwheel.WeaponShows[k];
				if _b and _b.Wep == v and v == LocalPlayer():GetActiveWeapon() then
					_b:MoveTo(_wMod*0, (_hMod*55)*(k-1),.1,0)
					_b.extended = true;
				elseif _b then

					_b:MoveTo(_wMod*350, (_hMod*55)*(k-1),.1,0)
					_b.extended = false

				end
			end
			for k , v in pairs(_pWeps) do 
				if !_wepwheel.WeaponShows[k] then
					local _weaponpn = vgui.Create("DPanel",_wepwheel);
					_weaponpn:SetPos(_wMod*350, (_hMod*55)*(k-1))
					_weaponpn:SetSize(_wMod*400,_hMod*50)
					_weaponpn.Wep = v;
					_weaponpn.extended = false;
					if _weaponpn.Wep == LocalPlayer():GetActiveWeapon() then
						_weaponpn:MoveTo(_wMod*300, (_hMod*55)*(k-1),.1,0)
						_weaponpn.extended = true;
					end
					function _weaponpn:Paint(w,h)
						if self.Wep and IsValid(self.Wep) then
							surface.SetDrawColor( 56,56,56, 128 )
							surface.DrawRect( 0,0,w,h)
					
							draw.SimpleText( self.Wep:GetPrintName(), "Trebuchet19" ,w/3,h/2 , Color( 255 ,255 ,255 ,255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
			
						end
					end 
					_wepwheel.WeaponShows[k] = _weaponpn
				end
			end
		end)
	end
	_wwheel:Update()


	function _wwheel:Paint(w,h)
		surface.SetDrawColor( 36, 36 ,36 , 128 )
		surface.DrawRect( w-_wMod*100,0,_wMod*100,_size)
	end 
end
 
hook.Add("PreDrawHalos", "EntityHalos", function()
	local tbl = {}
	for k,v in pairs(ents.GetAll()) do
		if(v.ShouldDrawHalo) or ( v:getFlag("drawHalo",false) == true and v:getFlag("ownedBy","") == LocalPlayer():SteamID() ) then
			table.insert(tbl, v)
		end
	end
	halo.Add(tbl, Color(128, 128, 128), 5, 5, 2)
	
	
end)
net.Receive("sendClientJobModels", function( _len , _p )
	
	local jModTb	= net.ReadTable();
	local sID 		= net.ReadString();

	if !IsValid( LocalPlayer()) then return end 
	if sID == LocalPlayer():SteamID() then
	
		LocalPlayer().__JobModels = jModTb;
		LocalPlayer():setFlag("jobmodels", jModTb);
		return
		
	end
	
	for k , v in pairs( player.GetAll() ) do
	
		if v:SteamID() == sID then
		
			v.__JobModels = jModTb;
			v:setFlag("jobmodels", jModTb);
			
			break
			
		end
		
	end
	
end )
	
//
//  - Josh 'Acecool' Moser
//

// Shows how to make a vgui map... The WorldToMapPos function can be confusing. Basically the top-left of the
// map image should be -16384, -16384. I add this amount to ensure the values are always positive.
// The start offset values should be you standing / noclipped to top-left corner and you should add / subtract
// values to get to -16384 if there is an offset...
// Total width / length values are simply the size of the map in units where the max is 32768 in both directions.
// This is so the math can calculate exactly where on the map what represents...


// origin = 32768 / 2, 32768 / 2 = 16384


//
// Returns the 2D map x and y positions
//
// Positions from evocity map image to calculate values...
// Top Left		= -14512,	 15335
// Bottom		= - 7210,	-14734
// Top-Right	=	12903,	 15335
//
// Origin = 538 564 ie 16384 16384
local function WorldToMapPos( _pos, _w, _h, _start_offset_x, _start_offset_y, _total_width, _total_length )
	// Grab the X and Y from the player position... Simplify by making it always positive...
	local _x, _y = _pos.x + 16384 + ( _start_offset_x || 0 ), -_pos.y + 16384 + ( _start_offset_y || 0 ); -- 32768

	// We need to create a modifier which lets us multiply our x and y to get the new x and y converted to the minimap points...
	// The only issue is maps that have offset... So we allow an offset to be + or - for w and h to be added prior to the modding..
	local _modW, _modH = _w / ( _total_width && ( _total_width ) || 32768 ), _h / ( _total_length && ( _total_length ) || 32768 );

	//
	return ( _x * _modW ), ( _y * _modH );
end


//
// Console command to bring it up....
//

local _ShouldDrawMinimap = false//CreateClientConVar( "wc_minimap", 1, true, true )
local _mat = Material( "properties/southside.jpg" );
concommand.Add( "mapview", function( _p, _cmd, _args )
	local _offset =400 *_wMod;
	local _size = math.min(ScrW(),ScrH() ) - _offset;
	if LocalPlayer().Map then 
		LocalPlayer().Map:Remove() 
		LocalPlayer().Map = nil;
	end
	if true then
		return 
	end
	if  GetConVar( "wc_minimap" ) and GetConVar( "wc_minimap" ):GetBool()== false then return end
	// Custom Function - you'll want to use Material, then _mat:Width( ) and _mat:Height( );
	local  _w, _h;

	local _panel = vgui.Create( "DFrame" );
	_panel:SetTitle( "" );
	_panel:MouseCapture( false );
	_panel:ShowCloseButton(false)
	_panel:SetSize( (_size - _offset),(_size -_offset));
	_panel:SetPos( _wMod*20, _hMod*0 );
	function _panel:Paint(w,h) end
	-- _panel:Center( );
	local _map = vgui.Create( "DImage", _panel );
	_map:SetMaterial( _mat );
	_map:SetKeepAspect( true );
	local _mOffset = _offset
	_map:SetPos( 0, _hMod*20 );
	_map:SetSize( _size - _mOffset, _size - _mOffset );
	_map:SetMouseInputEnabled( true );
	LocalPlayer().Map = _panel;

	// If you want the map image to handle drawing, this is how you'd do it...

	local __paint = _map.Paint;
	/*function _map:Think() 
			if !LocalPlayer() then return end
			local xsize,ysize = self:GetSize()
			local _x, _y = WorldToMapPos( LocalPlayer():GetPos(), xsize , ysize , 0, 0, 32768, 32768 );
	
			local _truex = (xsize- _x)+(_wMod*640)
			local _truey = (ysize- _y)+(_hMod*640)
			self:SetPos(_truex,_truey)
	end*/
	function _map:Paint( )
		// Draw the map image
		__paint( _map );

		// Draw the overlay...			local _x, _y = WorldToMapPos( _p:GetPos( ), _size - _mOffset, _size - _mOffset, -1872 - 160, -1049 + 480, 25925, 30268 );

		for k, _p in pairs( player.GetAll( ) ) do
			if ( !IsValid( _p ) || !_p:Alive( ) ) then continue; end
 
			// Get the map x y position from the world-position, the map-image-size, and what the map represents ( start offset for top-left,
			// add value to get to -16348 for x and y... The last 2 represent the RANGE the map image represents - if using image where origin
			// is at 16348, 16348 you shouldn't need to touch anything if the map represents the entire map-map size of 32768.. )
			local _x, _y = WorldToMapPos( _p:GetPos( ), _size - _mOffset, _size - _mOffset, -1872 - 160, -1049 + 480, 25525, 31768 );
			//self:SetPos(1024/_x,0)//-(_wMod*100),_y-(_hMod*100))
			// Custom function for icon...
			-- draw.Icon( _x, _y, "icon16/user.png", color_white, 8, 8, !true );
			// Name
			draw.SimpleText( _p:GetPos():Distance(LocalPlayer():GetPos()) <= 1500 && _p:Nick() or "Player" , "Default", _x, _y, color_white );

			// Line to location so you can set it to represent as accurately as possible...
			//surface.DrawLine( 0, 0, _x, _y );
		end
	end
	//
	// Snaps a number to the nearest interval divisible by the number...
	//
	function math.SnapTo( _value, _interval, _always_increment )
		if ( !_interval || _interval == 0 ) then return _value; end

		local _func = ( _always_increment ) && math.ceil || math.Round;
		local _snapped = _func( _value / _interval ) * _interval;

		return _snapped;
		--// return ( _always_increment && _snapped < _value ) && _snapped + _interval || _snapped;
	end


	//_panel:MakePopup( );
end );
//RunConsoleCommand("mapview")