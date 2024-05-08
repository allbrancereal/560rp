
fsrp.devprint("[560Roleplay] - Acquiring the Create - A - Player Menu")


function fsrp.vgui_createPlayer(  )

	local Models = {};
	
	for k, v in pairs(mdlTable[2]) do 
		local iterator = iterateModelTable( 2, k );
		if iterator.beginner then
			table.insert(Models, {2, iterator.mdl , "1_"..k }); 
		end
	end
	for k, v in pairs(mdlTable[1]) do 
		local iterator = iterateModelTable( 1, k );
			
		if iterator.beginner then
			table.insert(Models, {1, iterator.mdl , "1_"..k }); 
		end
	end
	

	local curModelReference = 1;

	local W, H = ScrW() * 0.75, ScrH() * 0.8;
	
	local blurAmount = 7
	PlayerCreationScreen = vgui.Create("DFrame",BackgroundBlur)
	PlayerCreationScreen:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	PlayerCreationScreen:SetSize(W, H)
	PlayerCreationScreen:SetTitle("")
	PlayerCreationScreen:SetVisible(true)
	PlayerCreationScreen:SetDraggable(false)
	PlayerCreationScreen.OnClose = function()
	
		hook.Remove("Think", "MonColors");

	
	end
	
	PlayerCreationScreen:ShowCloseButton(true)
	PlayerCreationScreen:MakePopup()
	PlayerCreationScreen.Paint = function ( self , w, h )
		draw.Blur(self,15)
		draw.Box(0, 0, w, h, Color( 0,0,0, 128 ) )
		draw.Box(0, 0, w, -h+h + 25, Color( 220,220,220, 255 ) )
		surface.SetFont("Trebuchet18")
		surface.SetTextColor( 80, 100, 210 )
		surface.SetTextPos( 25 ,25)
	
	
	end
	local playerNameText = vgui.Create("DPanel",PlayerCreationScreen)
    playerNameText:SetPos(5,25)
    playerNameText:SetSize(W,H)
	
    playerNameText.Paint = function(self)
        //draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(0,0,0,200))	
        //surface.SetDrawColor(0,0,0,255)
        //surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())		
		if firstName && lastName then
			
			if firstName:GetValue() == "John" && lastName:GetValue() == "Doe" then
				draw.DrawText( "Welcome to 560Roleplay " .. LocalPlayer():Nick()  ,"fsrp.vgui_createplayer_name",8,5,Color(255,255,255,255),TEXT_ALIGN_LEFT)
			else
				draw.DrawText("Welcome to 560Roleplay " ..  string.sub( firstName:GetValue() , 1, 15) .. " " .. string.sub( lastName:GetValue() ,1,15) ,"fsrp.vgui_createplayer_name",8,5,Color(255,255,255,255),TEXT_ALIGN_LEFT)
			end
		end
		local padding = 160
		for _ , v in pairs( _adviceTable ) do 
		
			draw.DrawText( v ,"fsrp.vgui_createplayer",W-500,padding + 5,Color(255,255,255,255),TEXT_ALIGN_LEFT)
			padding = padding + 25;
		end
   end	
	
		local ModelPanel = vgui.Create('DModelPanel', PlayerCreationScreen);
		ModelPanel:SetPos(15, 30);
		ModelPanel:SetSize(W,H);
		ModelPanel:SetFOV(70);
		ModelPanel:SetCamPos(CAM_LOOK_AT_CAMMODEL_POS[2]);
		
		ModelPanel:SetLookAt(CAM_LOOK_AT[2]);
		ModelPanel:SetModel(Models[curModelReference][2]);
		//ModelPanel:SetModel("models/player/Group01/Female_01.mdl");
		function ModelPanel:LayoutEntity( Entity )  end
		local ourModel = Models[curModelReference][3]
				
		local LeftButton = vgui.Create("DButton", PlayerCreationScreen);
		LeftButton:SetPos(300, H - 175);
		LeftButton:SetSize(125, 100);
		LeftButton:SetText("<");
		LeftButton.Paint = function (self , w , h )
			draw.Box(0, 0, w, h, Color( 0,0,0, 128 ) )
		
		
		end	
		
		function LeftButton:DoClick ( )
			curModelReference = curModelReference - 1;
			if (curModelReference < 1) then
				curModelReference = #Models;
			end
			
			ModelPanel:SetModel(Models[curModelReference][2]);
			ModelPanel:SetCamPos(CAM_LOOK_AT_CAMMODEL_POS[Models[curModelReference][1]]);
			ModelPanel:SetLookAt(CAM_LOOK_AT[Models[curModelReference][1]]);
			ourModel = Models[curModelReference][3];
		end
		
		local RightButton = vgui.Create("DButton", PlayerCreationScreen);
		RightButton:SetPos(W - 400, H - 175);
		RightButton:SetSize(125, 100);
		RightButton:SetText(">");
		RightButton.Paint = function (self , w , h )
			draw.Box(0, 0, w, h, Color( 0,0,0, 128 ) )
		
		
		end	
		function RightButton:DoClick ( )
			curModelReference = curModelReference + 1;
			if (curModelReference > #Models) then
				curModelReference = 1;
			end
			
			ModelPanel:SetModel(Models[curModelReference][2]);
			ModelPanel:SetLookAt(CAM_LOOK_AT[Models[curModelReference][1]]);
			ourModel = Models[curModelReference][3];
		end
		
		
		local PanelSize = W * .5 - 7.5;
		local _pCache_1 = vgui.Create("DPanelList", PlayerCreationScreen);
		_pCache_1:EnableHorizontal(false)
		_pCache_1:EnableVerticalScrollbar(true)
		_pCache_1:StretchToParent(5, 30, 5, 5);
		_pCache_1:SetPos(180, 200);
		_pCache_1:SetSize(300, 150);
		
		_pCache_1:SetPadding(5);
		
		local _pCache_2 = vgui.Create("DPanelList", PlayerCreationScreen);
		_pCache_2:EnableHorizontal(false)
		_pCache_2:EnableVerticalScrollbar(true)
		_pCache_2:SetPos(5, 30);
		_pCache_2:SetSize(120, 150);
		_pCache_2:SetPadding(5);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("Character's First Name:");
		_pCache_1:AddItem(firstNamel);
		
		firstName = vgui.Create("DTextEntry", _pCache_1);
		firstName:SetPos(80, 30);
		firstName:SetSize(100, 20);
		firstName:SetText("John");
		
		_pCache_1:AddItem(firstName);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("");
		_pCache_1:AddItem(firstNamel);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("Character's Last Name:");
		_pCache_1:AddItem(firstNamel);
		
		lastName = vgui.Create("DTextEntry", _pCache_1);
		lastName:SetPos(80, 30);
		lastName:SetSize(100, 20);
		lastName:SetText("Doe");
		_pCache_1:AddItem(lastName);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("");
		_pCache_1:AddItem(firstNamel);
		
		SubmitButton = vgui.Create("DButton", _pCache_1);
		SubmitButton:SetPos(80, 30);
		SubmitButton:SetSize(100, 20);
		SubmitButton:SetText("Create User");
		
		_pCache_1:AddItem(SubmitButton);
		
		local function MonitorColors ( wantReturn )
			local firstNamex = firstName:GetValue();
			local lastNamex = lastName:GetValue();

			local anyInvalid = false;
			
			if !fsrp.IsValidPartialName(firstNamex) then
				firstName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				firstName:SetTextColor(Color(0, 0, 0, 255));
			end
	
			if !fsrp.IsValidPartialName(lastNamex) then
				lastName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				lastName:SetTextColor(Color(0, 0, 0, 255));
			end
			
			if (!fsrp.IsValidName(firstNamex, lastNamex, true)) then
				lastName:SetTextColor(Color(255, 0, 0, 255));
				firstName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			end
			
			if (anyInvalid) then
				SubmitButton:SetEnabled(false);
			else
				SubmitButton:SetEnabled(true);
			end
			
			if (wantReturn) then
				return !anyInvalid;
			end
		end
		hook.Add('Think', 'MonColors', MonitorColors);
		
		function SubmitButton:DoClick ( )
			
			hasEntered = true;
				
				local NetFName = string.sub(firstName:GetValue(), 1, 15)
				local NetLName = string.sub(lastName:GetValue(), 1, 15)
				
				
				confirmFirstName( NetFName , NetLName, ourModel )
				hook.Remove("Think", "MonColors");
				PlayerCreationScreen:Remove();
				
			end
		end
		


function confirmFirstName(  first, last, ourModel )
	local opentextboxbg = vgui.Create( "DFrame")
	opentextboxbg:SetSize(ScrW(),ScrH())
	opentextboxbg:SetTitle("")
	opentextboxbg:ShowCloseButton(false)
	opentextboxbg:SetDraggable(false)
	opentextboxbg.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,250))
	end
	opentextboxbg:MakePopup()

	local opentextboxmain = vgui.Create( "DFrame",opentextboxbg)
	opentextboxmain:SetSize(300,200)
	opentextboxmain:SetTitle("")
	opentextboxmain:SetPos(-500, ScrH() / 2 - 200)
	opentextboxmain:ShowCloseButton(false)
	opentextboxmain.Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,Color(45,45,45))
		draw.SimpleText("Name Confirmation","fsrp.vgui_createplayer",24,20,Color(190,190,190))
	end
	opentextboxmain:MoveTo( ScrW() / 2 - 150, ScrH() / 2 - 200, 0.5, 0, 1 )
	
	local opentextboxlabel = vgui.Create("DLabel",opentextboxmain)
	opentextboxlabel:SetPos(28,54)
	opentextboxlabel:SetSize(opentextboxmain:GetWide() - 56,40)
	opentextboxlabel:SetWrap(true)
	opentextboxlabel:SetText("Please type yes to confirm your name " .. first .. " " .. last )
	opentextboxlabel:SetFont("fsrp.vgui_createplayer")
	opentextboxlabel:SetTextColor(Color(190,190,190))
	
	local opentextboxclose = vgui.Create("DButton",opentextboxmain)
	opentextboxclose:SetSize(32,32)
	opentextboxclose:SetPos(opentextboxmain:GetWide() - 38,6)
	opentextboxclose:SetText("r")
	opentextboxclose:SetFont("marlett")
	opentextboxclose:SetTextColor(Color(166,169,172))
	opentextboxclose.Paint = function() end
	opentextboxclose.DoClick = function()
		fsrp.vgui_createPlayer()
		opentextboxmain:Close()
		opentextboxbg:Remove()
	end

	local opentextboxmytext = vgui.Create("DTextEntry",opentextboxmain)
	opentextboxmytext:SetText("")
	opentextboxmytext:SetPos(opentextboxmain:GetWide() / 2 - 100,opentextboxmain:GetTall() - 80)
	opentextboxmytext:SetSize(200,20)
	opentextboxmytext.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(230,230,230))
		draw.RoundedBox(0,1,1,w-2,h-2,Color(255,255,255))
		self:DrawTextEntryText(Color(30,30,30),Color(149,240,193),Color(0,0,0))
	end

	local opentextboxyaccept = vgui.Create("DButton",opentextboxmain)
	opentextboxyaccept:SetSize(80,35)
	opentextboxyaccept:SetPos(opentextboxmain:GetWide() / 2 - 40,opentextboxmain:GetTall() - 44)
	opentextboxyaccept:SetText("Accept")
	opentextboxyaccept:SetFont("fsrp.vgui_createplayer")
	opentextboxyaccept:SetTextColor(Color(255,255,255))
	opentextboxyaccept.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(120,120,120))
		if self.Hovered then 
			draw.RoundedBoxEx(0,0,0,w,h,Color(135,135,135)) 
		end
	end
	opentextboxyaccept.DoClick = function()
	
		if string.lower( opentextboxmytext:GetValue() ) == "yes" then
			fsrp.devprint("This works")
			net.Start("fsrp.sendUsYourName")
						net.WriteString( first )
						net.WriteString( last )
						net.WriteString( ourModel )
			net.SendToServer()
			
			opentextboxmain:Close()
			opentextboxbg:Close()
			textOpen = false
		else
			fsrp.vgui_createPlayer()
			opentextboxmain:Close()
			opentextboxbg:Close()
			textOpen = false
		end
		

	end

end

fsrp.devprint("[560Roleplay] - Copy that, we got it. (Create-A-Player)")
