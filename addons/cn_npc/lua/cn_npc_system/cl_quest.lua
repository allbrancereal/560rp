--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f59168a397dba8e36c56a2b029ce5f6b2e7545853cd1e8cd533b97d1aa2b08c2
--]]

local SCREEN_W, SCREEN_H = 3840, 2160;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
_wMod = _wMod*2;
_hMod = _hMod*2;
local PANEL = {}
	surface.CreateFont("cnChatFont", {
		font = "Tahoma",
		size = ScreenScale(7),
		weight = 550
	})

	surface.CreateFont( "cnChatFont_Treb5", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(7),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "cnChatFont_Treb5_4k", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(3),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "cnChatFont_CloseBut", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(7),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "cnChatFont_CloseBut_4k", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(3),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	function PANEL:Paint(w,h)

	
	
		if self.DoBeginning && !self.FinBeginning then
		
			self.Alpha = Lerp( 0.1 , self.Alpha , 255 ) 
			if self.top then
				self.top.Alpha = self.Alpha;
			end
			if self.Alpha > 254 then
			
				self.DoBeginning = false;
			
			end
			
		end
		
		if !self.DoBeginning && !self.FinBeginning then
		
			self.DoBeginning2 = true
			self.FinBeginning = true;
		
		end
		
		if self.DoBeginning2 then
				
			self.Alpha2 = Lerp( 0.1 , self.Alpha2 , 255 ) 
			
			if self.top then
				self.top.Alpha2 = self.Alpha2;
			end
			if self.Alpha2 > 254 then
			
				self.DoBeginning2 = false;
			
			end
			
		end
		surface.SetDrawColor( 40 ,40 ,40  , self.Alpha ) 
		surface.DrawRect( 0,_hMod*-50, w , (h+(50 *_hMod)))
		
		//surface.SetDrawColor(249 , 82 , 107, self.Alpha2 ) 
		local _hAdj4k = 20;
		if ScrW() == 3840 then
			_hAdj4k = 30

		end
		//surface.DrawRect( _wMod * 10, _hMod * 30, w  - _wMod * 20, (h-_hAdj4k) - _hMod * 20 )
		local _font = "cnChatFont_Treb5";

		if self.NPCName then
			surface.SetFont("cnChatFont_Treb5")
			local _x,_y = surface.GetTextSize(self.NPCName);
			if ScrW() == 3840 then
				_font = "cnChatFont_Treb5_4k"

			end
			//draw.SimpleText( self.NPCName , _font ,15*_wMod,_hMod*7.5 , Color( 255 ,255 ,255 , self.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT) 
		
		end

	end

	local _HAdj = 175;
	function PANEL:Init()
		self.Alpha = 0;
		self.Alpha2 = 0;
		self.DoBeginning = true;
		self.FinBeginning = false;
		self.DoBeginning2 = false;
		cnPanels.quest = self
		self:ShowCloseButton(false)
	
		self:SetSize(880*_wMod, _hMod*(350+_HAdj))
		self:SetPos(ScrW()/2-self:GetWide()/2, ScrH() * 0.5)
		self:SetTitle("")
		self:MakePopup()

		self.close = vgui.Create("DButton", self)
		self.close:SetText("")
		//self.close:SetPos(_wMod*10, _hMod* 10)
		self.close.Parent=self;
		local _font = "cnChatFont_CloseBut";
			if ScrW() == 3840 then
				_font = "cnChatFont_CloseBut_4k"
			end
		function self.close:Paint(w,h)
			surface.SetDrawColor(127 , 127 , 164, self.Alpha ) 
			surface.DrawRect( 0,0, w ,h)

			draw.SimpleText( "X" , _font ,w/2-2,0 , Color( 255 ,255 ,255 , self.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT) 
		
		end
		//self.close:Dock(TOP)
		//self.close:DockMargin(0,-10,0,0)
		self:Add(self.close)
		self.close:SetTall(_hMod*20)
		self.close:SetPos(self:GetWide()-_wMod*110,_hMod*5);
		self.close:SetWide(_wMod*100);
		function self.close:DoClick()
			self.Parent:Remove()
		end		

		self.top = self:Add("DPanel")
		self.top:SetTall(_hMod*(180+_HAdj))
		self.top:Dock(TOP)
		self.top.Alpha = 0;
		self.top.Alpha2=0;
		function self.top:Paint(w,h)

			surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
			surface.DrawRect( 0,0, w , h )

			surface.SetDrawColor(127 , 127 , 164, self.Alpha ) 
			surface.DrawRect( _wMod * 10, _hMod * 10, w  - _wMod * 20, h - _hMod * 20 )

		end
	
		local LEFT_ANGLE = Angle(0, 70, 0)
		local RIGHT_ANGLE = Angle(0, 20, 0)
		local lastUpdate = 0
		local realTime

		self.model = self:Add("DModelPanel")
		self.model.ShowMe = false;
		//self.model:Dock(LEFT)
		self.model:SetSize(256*_wMod,self:GetTall())
		self.model:SetPos(self.model.x+ _wMod*15 ,0)
		self.model:SetModel(LocalPlayer():GetModel())
		self.model:SetFOV(20)
		self.model.LayoutEntity = function(this, entity)
			realTime = RealTime()
			if  this.Entity:LookupBone( "ValveBiped.Bip01_Spine" )  then
				local headpos = this.Entity:GetBonePosition( this.Entity:LookupBone( "ValveBiped.Bip01_Spine" ) )
				this:SetLookAt( headpos -Vector(0,0,-10))

				this:SetCamPos( headpos-Vector( -50,-30,-10 ) )
				//entity:FrameAdvance(realTime - lastUpdate)
				entity:SetAngles(LEFT_ANGLE-Angle(0,15,0))
				entity:UseClientSideAnimation()
			end
			//lastUpdate = realTime
		end
		self.model.Entity:SetIK(false)
		//self.model:SetWide(150*_wMod)


		self.me = self.top:Add("DModelPanel")
		//self.me:Dock(RIGHT)
		self.me:SetSize(_wMod*128,_hMod*(180+_HAdj))
		//self.me:SetPos(self:GetWide()-133,0-10)

		self.me:SetModel(LocalPlayer():GetModel())
		
		
		self.me:SetVisible(false)
		self.me:SetFOV(20)
		self.me:SetWide(150*_wMod)
		self.me.LayoutEntity = function(this, entity)
			local _spine = this.Entity:LookupBone( "ValveBiped.Bip01_Spine" );
			if _spine then 
				local headpos = this.Entity:GetBonePosition( _spine )
				this:SetLookAt( headpos -Vector(0,0,-9))

				this:SetCamPos( headpos-Vector( -50,-30,-10 ) )
			end
			//entity:SetAngles(RIGHT_ANGLE)
		end
		self.me.Entity:SetPos(self.me.Entity:GetPos() - Vector(0, 0, 16))
		self.me.Entity:SetIK(false)
		self.me.Entity.GetPlayerColor = function()
			return LocalPlayer():GetPlayerColor()
		end
		self.me.Entity:SetEyeTarget(Vector(60, 0, 42))

		self.scroll = self.top:Add("DScrollPanel")
		//self.scroll:Dock(FILL)
		//self.scroll:DockMargin(-150,10,0,0)
		self.scroll:SetSize(self:GetWide(),_hMod*250)
		self.scroll:SetPos(_wMod*0,_hMod*11)
		
		self.scroll:SetTall(self.top:GetTall()-_hMod*22)

		self.scroll.VBar:SetWide(0)
 
		self.options = self:Add("DScrollPanel")
		self.options:SetPos(_wMod*250,_hMod*387.5)
		self.options:SetSize(_wMod*620,_hMod*135)
		//self.options:Dock(FILL)
		//self.options:SetDrawBackground(true)
		//self.options:DockMargin(0, 0, 0, 0)
		//self.options:SetBackgroundColor(Color(56,56, 56, 255))
		//self.options:DockPadding(2, 2, 2, 2)

		
		self.MainTextSPanel = vgui.Create("DScrollPanel",self)
		local _TextScrollPanel = self.MainTextSPanel
		_TextScrollPanel:SetPos(_wMod*250,_hMod*43)
		_TextScrollPanel:SetSize(_wMod*600,_hMod*332)

		local _TextPanel = _TextScrollPanel:Add("DPanel");
		_TextPanel.FromMe = false;
		function _TextPanel:Paint(w,h)
			surface.SetDrawColor(56 , 56 , 56, self.Alpha ) 
			surface.DrawRect( 0,0, w , h )
			if self.FromMe == true then
				surface.SetDrawColor( 225 ,225 ,255  , self.Alpha ) 			
			else
				surface.SetDrawColor( 225 ,225 ,225  , self.Alpha ) 
			end

			surface.DrawRect( _wMod * 2, _hMod * 2, w  - _wMod * 4, h - _hMod * 4 )

		end
		self.MainTextPanel = _TextPanel;
		_TextPanel:SetSize(_wMod*600,_hMod*350)

		_TextPanel.Label = vgui.Create("DLabel",_TextPanel)
		local _Label =_TextPanel.Label;
		_Label:SetPos(_wMod*10,_hMod*10)
		_Label:SetSize(_wMod*580,_hMod*327)
		_Label:SetAutoStretchVertical(true)
		_Label:SetWrap(true)
		_Label:SetFont("cnChatFont_Treb5")

		_TextPanel.DLabel = vgui.Create("DLabel",_TextPanel)
		local _DLabel =_TextPanel.DLabel;
		_DLabel:Dock(FILL)
		_DLabel:SetAutoStretchVertical(true)
		_DLabel:SetWrap(true)
		_DLabel:SetFont("cnChatFont_Treb5")
		_DLabel:DockMargin(30,ScrW()==3840 && 60 || 40,20,20)

		function self:SetTitleText(text,name,fromme,callback)

			_DLabel:SetText("")
			local _textToServe=text

			local _Speed = .1;
			local t = {}
			for i = 1, #_textToServe do
			    t[i] = _textToServe:sub(i, i)
			end
			for k , v in pairs(t) do
				timer.Simple( (k*(0.025*_Speed)) ,function()
					if _DLabel and IsValid(_DLabel) and ispanel(_DLabel) then
						local _textToServe = _DLabel:GetText();
						_DLabel:SetText(_textToServe .. v )
						if  k == #t then
							timer.Simple(1, function()
								if (IsValid(self) and callback) then
									callback()
								end
							end)
						end
					end
				end)
			end

			_DLabel:SetColor(Color(56,56,56,255))
			_Label:SetText(name)
			_Label:SetColor(Color(56,56,56,255))
			surface.SetFont("cnChatFont_Treb5")
			local _x,_y = surface.GetTextSize(_Label:GetText())
			//if _y > 327*_hMod then
				_DLabel:SetSize(_wMod*580,(5*_y))
				_TextPanel:SetSize(_wMod*600,(5*_y))
			//else
				//_DLabel:SetSize(_wMod*580,_hMod*327)
				//_TextPanel:SetSize(_wMod*600,_hMod*327)
			//end
			_TextPanel.FromMe = fromme
			
		end
		//self:SetTitleText("The quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dogThe quick brown fox jumps over the lazy dog","John Says")
	end
	local _pad = 3
	function PANEL:addOption(text, callback, isLeave)
		local button = self.options:Add("DButton")
		button:Dock(TOP)
		button:SetTall(28*_hMod)
		button:SetText("")
		button:DockMargin(2, 2, 2, 0)
		button.Text = text;
		button.Clicked = false;
		button.Alpha = 0;
		button.Alpha2 = 0;
		button.DoBeginning = true;
		button.FinBeginning = false;
		button.DoBeginning2 = false;
		/*
		function button:OnMousePressed(k)
			button.Clicked = true;
		end
		function button:OnMouseRelease(k)
			button.Clicked = false;
			LocalPlayer():Notify("click")
			if (isLeave) then
				button.DoClick = function() self:Remove() end
			else
				self:clear()
					self:addText(text, true, function()
						if (callback) then
							callback()
						end
					end)
			end
		end
		*/
		function button:Paint(w,h)

			if self.DoBeginning && !self.FinBeginning then
			
				self.Alpha = Lerp( 0.25 , self.Alpha , 255 ) 
				if self.top then
					self.top.Alpha = self.Alpha;
				end
				if self.Alpha > 254 then
				
					self.DoBeginning = false;
				
				end
				
			end
			
			if !self.DoBeginning && !self.FinBeginning then
			
				self.DoBeginning2 = true
				self.FinBeginning = true;
			
			end
			
			if self.DoBeginning2 then
					
				self.Alpha2 = Lerp( 0.25 , self.Alpha2 , 255 ) 
				
				if self.top then
					self.top.Alpha2 = self.Alpha2;
				end
				if self.Alpha2 > 254 then
				
					self.DoBeginning2 = false;
				
				end
				
			end

			surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
			surface.DrawRect( 0,0, w , h )

			if button.Clicked ==true then
				surface.SetDrawColor(127 , 127 , 164, 0 ) 
			elseif button:IsHovered() then
				surface.SetDrawColor(127 , 127 , 164, self.Alpha/2 ) 
			else
				surface.SetDrawColor(127 , 127 , 164, self.Alpha ) 
			end
			surface.DrawRect( _wMod * _pad, _hMod * _pad, w  - _wMod * (_pad*2), h - _hMod * (_pad*2) )

			draw.SimpleText( button.Text , "cnChatFont_Treb5" ,w/2,h/2 , Color( 255 ,255 ,255 , self.Alpha2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) 
		
		end
		
		if (isLeave) then
			button.DoClick = function() self:Remove() end
		else
			button.DoClick = function()
				self.Clicked = true;
				self:clear()
				self:addText(text, true, function()
					if (callback) then
						callback()
					end
				end)
			end
		end
		
		return button
	end

	function PANEL:clear()
		self.options:Clear(true)
	end

	function PANEL:setup(uniqueID)
	
		local data = cnQuests[uniqueID]
		if (!data) then
			return self:Remove()
		end
		local _pa = self;
		timer.Simple(0.01,function()
			if !_pa or !_pa.model then return end
			
			local found = false

			for k, v in ipairs(_pa.model.Entity:GetSequenceList()) do
				if (v:lower():find("idle") and v != "idlenoise") then
					_pa.model.Entity:ResetSequence(k)
					found = true

					break
				end
			end
		end)

		if (!found) then
			self.model.Entity:ResetSequence(4)
		end

		self.model.Entity:SetPos(Vector(0,0,-10))
		self.model.Entity:SetAngles(Angle(0,70,0))
		self.model.Entity:SetEyeTarget(Vector(-60, 0, 42))

		local _p = LocalPlayer();
		
		local ID = _p:Team()
		local _toFind = ( ID == TEAM_CIVILLIAN ) && "" || ( ID == TEAM_POLICE ) && "job_police_" || ( ID == TEAM_PARAMEDIC ) && "job_paramedic_" || "";

		local _civillian_model		= _p:getFlag( "playerinfo_" .. _toFind .. "model", "Overwatch-D.Va" )
		local _civillian_bdg		= _p:getFlag( "playerinfo_" .. _toFind .. "bodygroups", "" )
		local _civillian_skin		= _p:getFlag( "playerinfo_" .. _toFind .. "skin", 0 )
		

		local _targetModel = self.entity:GetModel();
		local _targetSkin = 0;
		if self.model.ShowMe then
			_targetModel =  player_manager.TranslatePlayerModel( _civillian_model );
			_targetSkin = _civillian_skin
		end

	
		self.model.Entity:SetModel( _targetModel )
		self.model.Entity:SetSkin( _targetSkin)
		
		if self.model.ShowMe then
			local groups =_civillian_bdg
			
			if ( groups == nil ) then groups = "" end
			
			local groups = string.Explode( " ", groups )
			
				for k = 0, self.me.Entity:GetNumBodyGroups() - 1 do
			
				self.model.Entity:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
				
			end
		else
			self.model.Entity:SetSkin(0)
			self.model.Entity:SetBodyGroups( "0000000000000000000000" )
		end
				
		
		
		
		//self.me.Entity:SetPos(self.me.Entity:GetPos() - Vector(0, 0, 0))
		//self.me.Entity:SetIK(false)
		self.model.Entity.GetPlayerColor = function()
			return LocalPlayer():GetPlayerColor()
		end
		
		if (data.color) then
			self.model.Entity.GetPlayerColor = function()
				return data.color
			end
		end

		self.NPCName = data.name
	end

	local COLOR_OTHER = Color(236, 236, 236)
	local COLOR_ME = Color(127 , 200 , 255)

	function PANEL:addText(text, fromMe, callback)


		if (!text) then
			return
		end
		local data = cnQuests[self.entity:GetQuest()]
		if (!data) then
			return self:Remove()
		end
		self.model.ShowMe = fromMe and true or false;

		self:setup(self.entity:GetQuest())
		local _name = data.name;
		if fromMe then _name = LocalPlayer():getFirstName() end

		self:SetTitleText(text,_name,fromMe and true or false,callback);
		
		if (fromMe) then
			LocalPlayer():EmitSound("friends/friend_join.wav", 30, 180)
		else
			LocalPlayer():EmitSound("friends/message.wav", 30, 180)
		end

	/*	self.model.ShowMe = fromMe and true or false;

		if (fromMe) then
			text = "<color=50,50,50>"..text.."</color>"
		end

		local object = markup.Parse("<font=cnChatFont><color=50,50,50>"..text.."</font>", _wMod*_maxSize)
		local w, h = object:Size()


		local oldfromMe = fromMe;
		fromMe = false;
		local x = fromMe and (364*_wMod - (w + 10)) or 0
		x = x+128
		fromMe = oldfromMe;
		self.lastY = self.lastY or 0

		local panel = self.scroll:Add("DPanel")
		//panel:SetPos(_wMod*(x + (fromMe and (w + 150) or -(w + 10))), self.lastY)
		panel:SetPos(0,self.lastY)
		panel:SetSize(self.scroll:GetWide(),_hMod*(h + 20))
		panel:SetBackgroundColor(fromMe and COLOR_ME or COLOR_OTHER)
		panel:SetAlpha(0)
		panel:AlphaTo(255, 0.25)
		panel:MoveTo(x, self.lastY, 0.2, 0, -1, function()
			timer.Simple(0.75, function()
				if (IsValid(self) and callback) then
					callback()
				end
			end)
		end)
		local 		_meOffset = 500;
		local		_otherOffset=200;
		local _boxExtend = 15;
		function panel:Paint(wi,he)

			if ScrW() == 3840 then
					
				if fromMe then
					
					surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
					surface.DrawRect( _meOffset,0,  (w+_boxExtend)  , he )

					surface.SetDrawColor(COLOR_ME ) 
					surface.DrawRect( _meOffset+_wMod * 3, _hMod * 3, (w+_boxExtend)  - _wMod * 6, he - _hMod * 6 )

				else

					surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
					surface.DrawRect( _otherOffset,0,  (w+_boxExtend+10)  , he )

					surface.SetDrawColor(COLOR_OTHER ) 
					surface.DrawRect( _otherOffset+_wMod * 3, _hMod * 3,  (w+_boxExtend+10)   - _wMod * 6, he - _hMod * 6 )
				end
				
			else

				if fromMe then
					
					surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
					surface.DrawRect( 0,0,  (w+_boxExtend)  , he )

					surface.SetDrawColor(COLOR_ME ) 
					surface.DrawRect( _wMod * 3, _hMod * 3,  (w+_boxExtend)   - _wMod * 6, he - _hMod * 6 )

				else

					surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
					surface.DrawRect( 0,0,  (w+_boxExtend)  , he )

					surface.SetDrawColor(COLOR_OTHER ) 
					surface.DrawRect( _wMod * 3, _hMod * 3,  (w+_boxExtend)   - _wMod * 6, he - _hMod * 6 )
				end
			

			end
			
		end

/*
		local 		_meOffset = 200;
		local		_otherOffset=50;
		*//*
		local text = panel:Add("DPanel")

		if ScrW() == 3840 then
			text:SetPos( (fromMe && _meOffset || _otherOffset)+ 10*_wMod, 5)
		else
			text:SetPos(  5*_wMod, 5)
		end
		
		text:SetSize(w*_wMod, h*_hMod)
		text.Paint = function(this, w, h)
			object:Draw(0, 0, 0,10)
		end
		text:CenterVertical()

		self.lastY = self.lastY + panel:GetTall() + 4
		self.scroll:ScrollToChild(panel)

		
		if (fromMe) then
			LocalPlayer():EmitSound("friends/friend_join.wav", 30, 180)
		else
			LocalPlayer():EmitSound("friends/message.wav", 30, 180)
		end
		 self:setup(self.entity:GetQuest())
		return panel
		*/

	end

	function PANEL:OnRemove()
		if (IsValid(self.entity)) then
			net.Start("npcClose")
			net.SendToServer()
		end

	end
vgui.Register("cnQuest", PANEL, "DFrame")