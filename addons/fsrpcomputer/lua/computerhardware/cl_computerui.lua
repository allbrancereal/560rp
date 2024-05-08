

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _devSkew = 7;
	
local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

net.Receive( "AdjustComputerAnimationSpeed" ,function( _l , _p )
	
	//_devSkew = net.ReadDouble( );

end )

function ProgramMainPanel( Desktop , ID ) 
	
	local _p = LocalPlayer();
		

	local ProgramPanel = vgui.Create( "DPanel" , Desktop )
	ProgramPanel:SetSize( _wMod * 1000, _hMod * 800 )
	ProgramPanel:Center()
	ProgramPanel:MoveToBack()
	ProgramPanel.Desktop = Desktop;
	ProgramPanel.Alpha = 0; 
	ProgramPanel.DoBeginning = true;
	ProgramPanel.IsAlphaVisible = false;
	ProgramPanel.FinishedBeginning = false;
	ProgramPanel.ReadyForProgram = false;
	//surface.PlaySound("computer/startupsound.wav")
	ProgramPanel.Desktop = Desktop
	ProgramPanel.ID = ID
	//print( ProgramPanel.Desktop.Entity:getFlag("ownedBy","") )
	function ProgramPanel:Paint( w, h )
		
		if self.DoBeginning && !self.FinishedBeginning then
		
			self.Alpha = Lerp( 0.05* _devSkew , self.Alpha , 255 )
			
			if self.Alpha >= 254 then
			
				self.IsAlphaVisible = true;
				
			end
			
			if self.IsAlphaVisible && !self.FinishedBeginning then
				
				self.FinishedBeginning = true;
				hook.Run( "ProgramPanelBeginningFinished" , self, ID , Desktop)
			
			end
			
		end
		
		if self.ReadyForProgram then
		
		
		end
		
		surface.SetDrawColor( 255, 255 ,255 , self.Alpha * 0.5 )
		surface.DrawRect( 0,0, w , h )
		//surface.DrawRect( _wMod * 25, _hMod * 25 , w - _wMod * 50 , h - _hMod * 50 )
		//surface.DrawRect( _wMod * 25, _hMod * 25 , w - _wMod * 50 , h - _hMod * 50 )
		
		surface.SetDrawColor( 25, 25 ,25 , self.Alpha )		
		surface.DrawOutlinedRect( 0,0, w , h )
	end 
	

	function ProgramPanel:DrawCloseButtonForPanel(  )
		local Desktop = self.Desktop
		local CloseButton = vgui.Create( "DButton" , self )
		self.CloseButton = CloseButton;
		self.CloseButton.Desktop = Desktop;
		self.CloseButton:SetSize( _wMod * 150 , _hMod * 75 )
		self.CloseButton:SetText("")
		self.CloseButton:SetPos( self:GetWide() - _wMod * 175 , _hMod * 25 )
		
						
		self.CloseButton.HoveredColor = Color( 145, 255 ,169, self.CloseButton.Alpha)
		self.CloseButton.PressedColor = Color( 255, 211 ,93 ,self.CloseButton.Alpha)
		self.CloseButton.DefaultColor = Color( 255 ,255 ,255 , self.CloseButton.Alpha );
		self.CloseButton.ActiveColor = Color( 0,0,0 ,0 )
		self.CloseButton.Alpha = 0;
		self.CloseButton.DoBeginning = true;
		self.CloseButton.IsAlphaVisible = false;
		self.CloseButton.FinishedBeginning = true;
		
		function self.CloseButton:Paint( w, h )
			
			if self.DoBeginning && !self.IsAlphaVisible then
			
				self.Alpha = Lerp( 0.05* _devSkew , self.Alpha , 255 )
				
				if self.Alpha >= 254 then
				
					self.IsAlphaVisible = true;
					
				end
			
			elseif self.DoBeginning && self.IsAlphaVisible then
				
				if self:IsDown() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
				elseif self:IsHovered() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
				else
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
				end
			
			end
			
			surface.SetDrawColor( self.ActiveColor )
			surface.DrawRect( 0,0,w,h )
			
			draw.SimpleText( "Close Program", "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
		end 
		self.CloseButton.ProgramPanel = self;
		
		function self.CloseButton:OnMousePressed( k ) 
			if !self.Desktop then return end;
			//if !self.FinishedBeginning then return end
			if !self:IsHovered() then return end
			
			/*for i=1,#self.Desktop.ActualPrograms do
				v = self.Desktop.ActualPrograms[i];
				
				if v && v.ID == self.ProgramPanel.ID then
				
					table.remove(self.Desktop.ActivePrograms,i)
										
				end
				
			end
			*/
			
			for k , v in pairs( self.Desktop.HTMLPanels ) do
			
				v:Remove()
				
			end
			
			if self.Desktop.TaskBar.ProgramStache then
			
				self.Desktop.TaskBar.ProgramStache:RefreshPrograms( )
				
			end
			
			ProgramPanel:SetVisible( false );
			ProgramPanel:SetMouseInputEnabled( false );
			ProgramPanel:MoveToBack( );
			Desktop:MoveToFront();
		
		end 
	
	end
	
	hook.Add( "ProgramPanelBeginningFinished", "ProgramActualSubPanelDraw" , function( ProgramPanel , ID , Desktop ) 
	
		ProgramPanel.ReadyForProgram = true;
		
		local MainPanel = vgui.Create( "DPanel" , ProgramPanel )
		MainPanel:SetSize( ProgramPanel:GetWide() - _wMod * 24 , ProgramPanel:GetTall() - _hMod * 24 )
		MainPanel:SetPos( _wMod * 12 , _hMod * 12 )
		//MainPanel:SetText( Desktop.Programs[ID].Name );
		MainPanel.DoBeginning = true;
		MainPanel.Desktop = Desktop;
		MainPanel.FinishedBeginning = false;
		MainPanel.EventFinishMainPanelBegining = false;
		MainPanel.Alpha = 0;

		function MainPanel:RefreshLayout()
			if !self.Desktop then return end;
			
			/*for i=1,#self.Desktop.ActualPrograms do
				v = self.Desktop.ActualPrograms[i];
				
				if v && v.ID == self.ProgramPanel.ID then
				
					table.remove(self.Desktop.ActivePrograms,i)
										
				end
				
			end
			*/
			
			for k , v in pairs( self.Desktop.HTMLPanels ) do
			
				v:Remove()
				
			end
			
			if self.Desktop.TaskBar.ProgramStache then
			
				self.Desktop.TaskBar.ProgramStache:RefreshPrograms( )
				
			end
			
			ProgramPanel:SetVisible( false );
			ProgramPanel:SetMouseInputEnabled( false );
			ProgramPanel:MoveToBack( );
			Desktop:MoveToFront();
		end
		function MainPanel:Paint( w , h )
		
			if self.DoBeginning && !self.FinishedBeginning then
				
				self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
				
				if self.Alpha >= 254 then
			
					self.DoBeginning = false;
					self.FinishedBeginning = true;
					
				end
				
			end
			
			surface.SetDrawColor( 128, 128, 128, self.Alpha )
			surface.DrawRect( 0,0,w,h ) 
			
			draw.SimpleText( Desktop.Programs[ID].Name , "Trebuchet20", _wMod * 50, _hMod * 25 , Color( 255 ,255 ,255 , self.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
				
			draw.SimpleText( Desktop.Programs[ID].Desc , "Trebuchet24", _wMod * 50, _hMod * 60, Color( 185 ,185 ,185 , self.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
				
			if self.FinishedBeginning && !self.EventFinishMainPanelBegining then
			
				timer.Simple( 0.1, function ()
					
					if ID == 1 || ID == 5 then 

						if Desktop && Desktop.Entity && Desktop.Entity:getFlag("ownedBy","") != LocalPlayer():SteamID() then
						
							hook.Run("SubPanelFinishedLoadingIn", ProgramPanel, -1 , Desktop, MainPanel )
							
						end	
						

					end
					hook.Run("SubPanelFinishedLoadingIn", ProgramPanel, ID , Desktop, MainPanel )
			
				end )
			
				self.EventFinishMainPanelBegining = true
			
			end
			
		end 
		
		hook.Add( "SubPanelFinishedLoadingIn", "LoadInCloseButton" , function( ProgramPanel, ID, Desktop, MainPanel )
		
				ProgramPanel:DrawCloseButtonForPanel(  )
				
				if ID != 4 then
				
					net.Start("endWarehouse")
					net.SendToServer()
					
				end
				local grid = {};
				//{ Name = "Coin-Broker"}; // 1
				//{ Name = "Homebanker" }; // 2 
				//{ Name = "World Wide Web" }; // 3 
				//{ Name = "Remote Warehouse" };// 4
				//{ Name = "Remote Memory Express" }; // 5
				if ID == -1 then // Coin broker
				
					local _ErrorLabel = vgui.Create("DPanel", MainPanel )
					_ErrorLabel:Dock( FILL )
					function _ErrorLabel:Paint( w, h )
					
						draw.SimpleText( "Purchase your own computer to access this program!", "Trebuchet20", w/2,h/2, Color(255,255,255, MainPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
											
					end
					
				elseif ID == 1 && Desktop.Entity:getFlag("ownedBy","") == _p:SteamID() then // Coin broker
						/*
							CoinBroker = {}
							CoinBroker = vgui.Create( "DButton", MainPanel )
							CoinBrokerMainPanel = vgui.Create( "DPanel" , MainPanel )
							CoinBroker:SetPos(( 1 * ( _wMod * 220 )) - _wMod * 155, _hMod * 120 )
							CoinBroker:SetSize( _wMod * 210, _hMod * 50 )		
							CoinBroker.HoveredColor = Color( 145, 255 ,169, CoinBroker.Alpha)
							CoinBroker.PressedColor = Color( 255, 211 ,93 ,CoinBroker.Alpha)
							CoinBroker.DefaultColor = Color( 255 ,255 ,255 , CoinBroker.Alpha );
							CoinBroker.ActiveColor = Color( 0,0,0 ,0 )
							CoinBroker.Alpha = 0;
							CoinBroker.DoBeginning = true;
							CoinBroker.IsAlphaVisible = true;
							CoinBroker.FinishedBeginning = true;					
							CoinBroker:SetText( "" )				
							CoinBroker.CoinBrokerMainPanel = CoinBrokerMainPanel
							CoinBroker.HardwareType = hardWareType;
							CoinBroker.OnMousePressed = function( self, k )
								self.CoinBrokerMainPanel:SetVisible( true )
								self.CoinBrokerMainPanel.Alpha = 0
								self.CoinBrokerMainPanel.IsAlphaVisible = false
								self.CoinBrokerMainPanel.DoBeginning = true;
							end 
							
							CoinBroker.Paint = function( self,  w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								draw.SimpleText( "Coin Broker" , "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
							
							CoinBrokerMainPanel:SetPos( _wMod * 5 , _hMod * 170 )						
							CoinBrokerMainPanel:SetSize( MainPanel:GetWide() - _wMod * 10 , MainPanel:GetTall() - _hMod * 175 )						
							CoinBrokerMainPanel:SetVisible( true )
							CoinBrokerMainPanel.Alpha = 0
							CoinBrokerMainPanel.IsAlphaVisible = false
							CoinBrokerMainPanel.DoBeginning = true;
							CoinBrokerMainPanel:SetMouseInputEnabled( false )
							CoinBrokerMainPanel.Paint = function( self , w , h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
									
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
										
									if self.Alpha >= 254 then
										
										self.IsAlphaVisible = true;
											
									end
									
								end
									
								surface.SetDrawColor( 56, 56, 56, self.Alpha ) 
								surface.DrawRect( 0,0,w,h )
									
								
							end 
						*/
					
							local CoinBroker = vgui.Create( "DButton", MainPanel )
							local CoinBrokerMainPanel = vgui.Create( "DPanel" , MainPanel )
							CoinBroker:SetPos(( 1 * ( _wMod * 220 )) - _wMod * 155, _hMod * 120 )
							CoinBroker:SetSize( _wMod * 210, _hMod * 50 )		
							CoinBroker.HoveredColor = Color( 145, 255 ,169, CoinBroker.Alpha)
							CoinBroker.PressedColor = Color( 255, 211 ,93 ,CoinBroker.Alpha)
							CoinBroker.DefaultColor = Color( 255 ,255 ,255 , CoinBroker.Alpha );
							CoinBroker.ActiveColor = Color( 0,0,0 ,0 )
							CoinBroker.Alpha = 0;
							CoinBroker.DoBeginning = true;
							CoinBroker.IsAlphaVisible = true;
							CoinBroker.FinishedBeginning = true;					
							CoinBroker:SetText( "" )				
							CoinBroker.CoinBrokerMainPanel = CoinBrokerMainPanel
							CoinBroker.HardwareType = hardWareType;
							CoinBroker.OnMousePressed = function( self, k )
								self.CoinBrokerMainPanel:SetVisible( true )
								self.CoinBrokerMainPanel.Alpha = 0
								self.CoinBrokerMainPanel.IsAlphaVisible = false
								self.CoinBrokerMainPanel.DoBeginning = true;
							end 
							
							CoinBroker.Paint = function( self,  w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								draw.SimpleText( "Coin Broker" , "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
							
							CoinBrokerMainPanel:SetPos( _wMod * 5 , _hMod * 170 )						
							CoinBrokerMainPanel:SetSize( MainPanel:GetWide() - _wMod * 10 , MainPanel:GetTall() - _hMod * 175 )						
							CoinBrokerMainPanel:SetVisible( true )
							CoinBrokerMainPanel.Alpha = 0
							CoinBrokerMainPanel.IsAlphaVisible = false
							CoinBrokerMainPanel.DoBeginning = true;
							CoinBrokerMainPanel:SetMouseInputEnabled( false )
							CoinBrokerMainPanel.Paint = function( self , w , h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
									
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
										
									if self.Alpha >= 254 then
										
										self.IsAlphaVisible = true;
											
									end
									
								end
									
								surface.SetDrawColor( 56, 56, 56, self.Alpha ) 
								surface.DrawRect( 0,0,w,h )
									
								
							end 
							local prevValue = 0

							
							local CoinBar = vgui.Create( "DPanel" , CoinBrokerMainPanel )
							CoinBar.MainPanel = MainPanel
							CoinBar.CoinBrokerMainPanel = CoinBrokerMainPanel
							CoinBar:SetSize( CoinBrokerMainPanel:GetWide() , CoinBrokerMainPanel:GetTall() )
							function CoinBar:Paint( w,  h )
								local data = self.MainPanel.Desktop
								local value = Lerp(4 * FrameTime() , prevValue , (data.Entity:getFlag( "miningProgress" ,0) / 100) * _wMod *( 1000 - 24 - 175 - 135) )

								draw.RoundedBox(0,_wMod * 15, _hMod * 10,CoinBrokerMainPanel:GetWide() - _wMod * 30,_hMod * 100 , Color(30,30,30,255))
								draw.RoundedBox(0,_wMod * 30, _hMod * 20,CoinBrokerMainPanel:GetWide() - _wMod * 60,_hMod * 80, Color(60,60,60,255))

								draw.RoundedBox(0, _wMod * 45 , _hMod * 25,  CoinBrokerMainPanel:GetWide() - _wMod * 90 , _hMod * 70 , Color(140,140,140 , alpha))
								draw.RoundedBox(0, _wMod * 45 , _hMod * 25,  _wMod * value, _hMod * 70 , Color(255,255,255 , alpha))


								surface.SetFont( "Trebuchet20" )
								surface.SetTextColor( 0,0,0, 255 )
								local x = surface.GetTextSize(data.Entity:getFlag("minedCoins",0).." Coins Mined")/2
								surface.SetTextPos(w /2 - x , _hMod *( 45 ) )
								surface.DrawText(data.Entity:getFlag("minedCoins",0 ).." Coins Mined")

								prevValue = value
							end
						
					
							local CoinBrokerClaimButton = vgui.Create( "DButton", MainPanel )
							CoinBrokerClaimButton:SetPos( MainPanel:GetWide() * 0.5 - _wMod * 105, _hMod * 350 )
							CoinBrokerClaimButton:SetSize( _wMod * 210, _hMod * 50 )		
							CoinBrokerClaimButton.HoveredColor = Color( 145, 255 ,169, CoinBrokerClaimButton.Alpha)
							CoinBrokerClaimButton.PressedColor = Color( 255, 211 ,93 ,CoinBrokerClaimButton.Alpha)
							CoinBrokerClaimButton.DefaultColor = Color( 255 ,255 ,255 , CoinBrokerClaimButton.Alpha );
							CoinBrokerClaimButton.ActiveColor = Color( 0,0,0 ,0 )
							CoinBrokerClaimButton.Alpha = 0;
							CoinBrokerClaimButton.MainPanel = MainPanel;
							CoinBrokerClaimButton.DoBeginning = true;
							CoinBrokerClaimButton.IsAlphaVisible = true;
							CoinBrokerClaimButton.FinishedBeginning = true;					
							CoinBrokerClaimButton:SetText( "" )				
							CoinBrokerClaimButton.CoinBrokerMainPanel = CoinBrokerMainPanel
							CoinBrokerClaimButton.HardwareType = hardWareType;
							CoinBrokerClaimButton.OnMousePressed = function( self, k )
								
								
								local data = self.MainPanel.Desktop
								
								if data.Entity:getFlag("minedCoins",0 ) <= 0 then return LocalPlayer():Notify("You must have more than 0 coins to claim!") end
								
								net.Start( "claimMinedCoins" )
								net.SendToServer( ) 
								
							end 
							
							CoinBrokerClaimButton.Paint = function( self,  w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								local data = self.MainPanel.Desktop
								draw.SimpleText( "Claim " .. data.Entity:getFlag("minedCoins",0 ), "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
				elseif ID == 2 then // Homebanker
					
					
							local HomebankerBut = vgui.Create( "DButton", MainPanel )
							local HomeBankerMainPanel = vgui.Create( "DPanel" , MainPanel )
							HomebankerBut:SetPos(( 1 * ( _wMod * 220 )) - _wMod * 155, _hMod * 120 )
							HomebankerBut:SetSize( _wMod * 210, _hMod * 50 )		
							HomebankerBut.HoveredColor = Color( 145, 255 ,169, HomebankerBut.Alpha)
							HomebankerBut.PressedColor = Color( 255, 211 ,93 ,HomebankerBut.Alpha)
							HomebankerBut.DefaultColor = Color( 255 ,255 ,255 , HomebankerBut.Alpha );
							HomebankerBut.ActiveColor = Color( 0,0,0 ,0 )
							HomebankerBut.Alpha = 0;
							HomebankerBut.DoBeginning = true;
							HomebankerBut.IsAlphaVisible = true;
							HomebankerBut.FinishedBeginning = true;					
							HomebankerBut:SetText( "" )				
							HomebankerBut.HomeBankerMainPanel = HomeBankerMainPanel
							HomebankerBut.HardwareType = hardWareType;
							HomebankerBut.OnMousePressed = function( self, k )
								self.HomeBankerMainPanel:SetVisible( true )
								self.HomeBankerMainPanel.Alpha = 0
								self.HomeBankerMainPanel.IsAlphaVisible = false
								self.HomeBankerMainPanel.DoBeginning = true;
							end 
							
							HomebankerBut.Paint = function( self,  w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								draw.SimpleText( "Homebanker" , "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
							
							
					HomeBankerMainPanel:SetPos( _wMod * 5 , _hMod * 170 )						
					HomeBankerMainPanel:SetSize( MainPanel:GetWide() - _wMod * 10 , MainPanel:GetTall() - _hMod * 175 )						
					HomeBankerMainPanel:SetVisible( true )
					HomeBankerMainPanel.Alpha = 0
					HomeBankerMainPanel.IsAlphaVisible = false
					HomeBankerMainPanel.DoBeginning = true;
					HomeBankerMainPanel:SetMouseInputEnabled( false )
					HomeBankerMainPanel.Paint = function( self , w , h )
							
						if self.DoBeginning && !self.IsAlphaVisible then
								
							self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
										
							if self.Alpha >= 254 then
								
								self.IsAlphaVisible = true;
											
							end
									
						end
									
						surface.SetDrawColor( 56, 56, 56, self.Alpha ) 
						surface.DrawRect( 0,0,w,h )
						local x = surface.GetTextSize( "Slide around to start banking!" )/2
						
						draw.SimpleText( "Slide around to start banking!" , "Trebuchet24", _wMod * 25 +x,_hMod * 60, Color( 255 ,255 ,255 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
												
								
					end 
							
					local DermaNumSlider = MainPanel:Add( "DNumSlider" )
					DermaNumSlider:SetPos( _wMod * 15, _hMod *  (50+170) )			// Set the position
					DermaNumSlider:SetSize( MainPanel:GetWide() - _wMod * 30,  _hMod * 25 )		// Set the size
					DermaNumSlider:SetText( "" )	// Set the text above the slider
					DermaNumSlider:SetMin( -_p:getMoney() )				// Set the minimum number you can slide to
					DermaNumSlider:SetMax( _p:getBank() )				// Set the maximum number you can slide to
					DermaNumSlider:SetDecimals( 0 )			// Decimal places - zero for whole number
					DermaNumSlider:SetMouseInputEnabled( true )
					MainPanel.SelectedValue = 0;
					
					local AcceptButton = MainPanel:Add( "DButton" )
					function DermaNumSlider:OnValueChanged( val ) 
						local _pre = "Withdraw";
						
						MainPanel.SelectedValue = math.Clamp(val, -_p:getMoney(), _p:getBank());
						if MainPanel.SelectedValue < 0 then

							_pre = "Deposit";
							
						end
						AcceptButton._Text = ( _pre .. " $" .. math.floor(val) )
					end
					
					function DermaNumSlider:Think()
							
						self:SetMin( -_p:getMoney() )				// Set the minimum number you can slide to
						self:SetMax( _p:getBank()-1 )				// Set the maximum number you can slide to
						
					end
					
					AcceptButton:SetText("")
					AcceptButton.HoveredColor = Color( 145, 255 ,169, AcceptButton.Alpha)
					AcceptButton.PressedColor = Color( 255, 211 ,93 ,AcceptButton.Alpha)
					AcceptButton.DefaultColor = Color( 255 ,255 ,255 , AcceptButton.Alpha );
					AcceptButton.ActiveColor = Color( 0,0,0 ,0 )
					AcceptButton.Alpha = 0;
					AcceptButton.DoBeginning = true;
					AcceptButton.IsAlphaVisible = false;
					AcceptButton:SetMouseInputEnabled( true )
					AcceptButton.FinishedBeginning = false;
					AcceptButton._Text = "Chose Amount";
					function AcceptButton:Paint( w, h )
						
						if self.DoBeginning && !self.IsAlphaVisible then
						
							self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
							
							if self.Alpha >= 254 then
							
								self.IsAlphaVisible = true;
								
							end
							
						end
						
							if self:IsDown() then
							
								self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
							
							elseif self:IsHovered() then
							
								self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
							
							else
							
								self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
							
							end
							
						surface.SetDrawColor( self.ActiveColor )
						surface.DrawRect( 0,0,w,h )
						
						draw.SimpleText( AcceptButton._Text, "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							
					end 
					
					AcceptButton:SetPos( MainPanel:GetWide() *0.5 - _wMod * 100 , _hMod * (125+170) )
					AcceptButton:SetSize( _wMod * 200, _hMod * 100 )
					
					//AcceptButton:SetText( "Chose Amount" )
					
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
							net.WriteInt( MainPanel.SelectedValue , 32 )
						net.SendToServer()
						
						timer.Simple( .1, function ()
						
							
							DermaNumSlider:SetValue(0)
							

						end )
						
					end 
					
					
				
				elseif ID == 3 then // World Wide Web
					
					local WebsitePanel = vgui.Create( "DHTML", MainPanel )
					local TextInput = vgui.Create( "DTextEntry" , MainPanel )
					TextInput:SetPos( _wMod * 15 , _hMod * 125 )
					TextInput:SetSize( MainPanel:GetWide() - _wMod * 30 , _hMod * 25)
					function TextInput:OnValueChange( text ) 
						//if !isstring( textt ) || text == "" then return end
						if !WebsitePanel then return end
						
						WebsitePanel:OpenURL( text )
					
					end
					
					WebsitePanel:SetPos( _wMod * 15 , _hMod * 150)
					WebsitePanel:SetSize( MainPanel:GetWide() - _wMod * 30, MainPanel:GetTall() - _hMod * 210   )
					WebsitePanel:OpenURL( "https://westcoastrp.org" )
					table.insert( Desktop.HTMLPanels, WebsitePanel )
					
				elseif ID == 4 then // Remote Warehouse
					//if !LocalPlayer():NearNPC("warehouse") && !isRemote then return LocalPlayer():Notify("You need to be closer to the warehouse NPC!") end
					FRAME = vgui.Create( "DPanel" , MainPanel)
					local isRemote = true;
					FRAME:SetSize( MainPanel:GetWide() - _wMod * 30, MainPanel:GetTall() - _hMod * 100 )
					FRAME:Center()
						LocalPlayer():setFlag("restrictInv", true)
					FRAME:SetPos( _wMod * 490 , _hMod * 250 )
					//FRAME:ShowCloseButton(false)
					//FRAME:SetTitle( "Your Warehouse" )
					FRAME:MakePopup()
					FRAME.Alpha = 0;
					FRAME.SelectedText = "Hover over an Item";
					FRAME.SelectedDesc = "The description will be here (=";
					/*function FRAME:OnClose() 
					
						LocalPlayer():setFlag("restrictInv", false)
						net.Start("endWarehouse")
						net.SendToServer()
					
					end*/
					function FRAME:Paint( w,  h )
					
						draw.RoundedBoxEx( 0,0,0,w,h,Color( 25, 25 ,25, math.Clamp( FRAME.Alpha , 0, 128 ) ) )
						draw.RoundedBoxEx( 0,_wMod* 10, _hMod * 30,w/3 - _wMod * 15,h - _hMod * 40 ,Color( 56, 56 ,56,math.Clamp( FRAME.Alpha , 0 , 185 )  ) )
						
						draw.RoundedBoxEx( 0, w/1.5 ,_hMod * 30 , w/3 - _wMod * 15, h - _hMod * 40 ,Color( 56, 56 ,56, math.Clamp( FRAME.Alpha, 0 , 185)  ) )
						draw.SimpleText( FRAME.SelectedText , "ShopDescFont", w/2 , _hMod * 85, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						draw.SimpleText( FRAME.SelectedDesc , "ShopDescFont", w/2 , _hMod * 105, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						draw.SimpleText( "Inventory" , "Trebuchet24", w/2 + _wMod * 100 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						draw.SimpleText( "Warehouse", "Trebuchet24", w/2 - _wMod * 100 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					
					end 
					function FRAME:Think()
					
						if FRAME.Alpha < 255 then
						
							FRAME.Alpha = Lerp( 0.05, FRAME.Alpha , 255 )
							
						end
					
					end
					
					local FRAMEmdl = vgui.Create( "DModelPanel", MainPanel )
					
					FRAMEmdl:SetPos( MainPanel:GetWide() / 3 , _hMod * 20 )
					FRAMEmdl:SetSize( MainPanel:GetWide() /3 , MainPanel:GetTall() - _hMod * 40 )
					local buttonSize = _wMod * 90;	


					local _WarehouseList = vgui.Create( "DScrollPanel" , FRAME )
					_WarehouseList:SetSize( FRAME:GetWide()/3 - _wMod * 15 , FRAME:GetTall() - _hMod * 75)
					_WarehouseList:SetPos(_wMod * 15 , _hMod * 50 )
					local _WarehouseGrid = vgui.Create( "DGrid", _WarehouseList )
					_WarehouseGrid:SetCols( 3 )
					_WarehouseGrid:SetColWide( _wMod * 95 )
					_WarehouseGrid:SetRowHeight( 95 * _hMod  )
					lastTouch = 0;
					local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
					
					local _list = vgui.Create( "DScrollPanel" , FRAME )
					_list:SetSize( FRAME:GetWide()/3  - _wMod * 15  , FRAME:GetTall() - _hMod * 75)
					_list:SetPos( FRAME:GetWide()/1.5 + _wMod * 5 , _hMod * 50 )
					local _grid = vgui.Create( "DGrid", _list )
					_grid:SetCols( 3 )
					_grid:SetColWide( 95 * _wMod )
					_grid:SetRowHeight( 95 * _hMod )
					
					FRAME.InvList = _list
					FRAME.WarehouseList = _WarehouseList
					local _WarehouseItems = LocalPlayer():getFlag("warehouseItems",{});
					for i = 1, MAX_SLOTS do
					
						
						butCache = vgui.Create("DButton", _list )
						butCache.ID = i;
						butCache.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))

						butCache.TargetMDL = FRAMEmdl
						
						butCache:SetSize( buttonSize,buttonSize)
						
						butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
						butCache:SetToolTip( "Left Click to Deposit 1, Right click to Deposit 5" )

						local butCacheLabelTest = vgui.Create( "DPanel", butCache)
						function butCache:SetItemTable( )
								
							self.InventorySlotCache = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ))
							butCacheLabelTest.InventorySlotCache = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ))
							if self.mdl then self.mdl:Remove(); end
							
							if self.InventorySlotCache[self.ID] then
								//PrintTable( self.InventorySlotCache[self.ID] )

								local ListItem = ITEMLIST[self.InventorySlotCache[self.ID].ID];
								if ListItem && ListItem.Illegal == true then
								
								self.mdl = vgui.Create( "DModelPanel", self  )
								//self.mdl:SetFOV( 12 )
								self.mdl:SetVisible(true)
								
							
								self.mdl:SetPos( 5, 5 )
								self.mdl:SetSize( self:GetWide(), self:GetTall() )
								
								self.mdl:SetCamPos( ListItem.CamPos )

								self.mdl:SetLookAt(ListItem.LookAt )

								self.mdl:SetModel( ListItem.Model )

								//self.mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

								//self.mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

								//self.mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

								//self.mdl:SetColor( Color( 200, 200, 200 ) )

								//self.mdl:SetAnimated( false )		

								if ListItem.Scale then
									self.mdl.Entity:SetModelScale(ListItem.Scale);
								end
								self.mdl:SetMouseInputEnabled(false)
								//local iSeq = self.mdl.Entity:LookupSequence('ragdoll')
							
								//self.mdl.Entity:ResetSequence(iSeq)
								

								//self:MoveToFront()
								end
							end
						end
						butCache:SetItemTable()
						FRAME._grid = _grid;
						FRAME._WarehouseGrid = _WarehouseGrid;
						function butCache:OnMousePressed( k )
						
							//if self:IsDown() && lastTouch < CurTime() then
								//lastTouch = CurTime() + 0.1
								if !self.InventorySlotCache[self.ID] || !self.InventorySlotCache[self.ID].ID then return end
								local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
								local _amount = false;
							
								if k ==MOUSE_RIGHT then
									if self.InventorySlotCache[self.ID].Amount >= 10 then
									
										_amount = true;
									
									end
									
								end
								//if !table.HasValue(_ourBuyingInfo, _Item.ID ) then return end
								
								net.Start( "WarehouseAction_Inventory" )
									if k == MOUSE_RIGHT then
										net.WriteBool( false )
									elseif k == MOUSE_LEFT then
										net.WriteBool( true )
									end
									net.WriteInt( self.ID, 16 )
								net.SendToServer()
								
								timer.Simple( .1, function()
									
									for k , v in pairs( FRAME._grid:GetChildren() ) do
										
										
										v:SetItemTable()
										
										
									end
									for k , v in pairs( FRAME._WarehouseGrid:GetChildren() ) do
										
										
										v:SetItemTable()
										
										
									end
									
								end )
							//end
							
						end
						local _maxSlots = LocalPlayer():IsPremium() && fsrp.config.warehouses.SlotsPremium ||  LocalPlayer():IsDonator() && fsrp.config.warehouses.SlotsDonator || fsrp.config.warehouses.SlotsUser; 
					
						
						function butCache:Paint( w, h )
						
							if self.InventorySlotCache[self.ID]	then
							
							local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
								
								if #_WarehouseItems >= _maxSlots then
									
									
									surface.SetDrawColor( 255 ,0 ,0 ,FRAME.Alpha  )
									surface.DrawOutlinedRect( 0, 0, w, h )
									
									
									
								else

									
										surface.SetDrawColor( 255 ,255 ,255,FRAME.Alpha   )
										
										surface.DrawOutlinedRect( 0, 0, w, h )
									
								
								
								end
								
								//draw.SimpleText( self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet20", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								
								if self:IsHovered() && self.TargetMDL:GetModel() != ITEMLIST[self.InventorySlotCache[self.ID].ID].Model then
									
									
									self.TargetMDL:SetModel( _Item.Model )
									self.TargetMDL:SetCamPos( _Item.CamPos )
									self.TargetMDL:SetLookAt( _Item.LookAt )


									FRAME.SelectedText = _Item.Name .. " (Sell for $" .. _Item.Cost .. ")";
									FRAME.SelectedDesc = _Item.Description;
								end
								
							else
							
									surface.SetDrawColor( 128 ,128,128,FRAME.Alpha   )
									surface.DrawOutlinedRect( 0, 0, w, h )
								
								
							end
							
						end 
						
						local butx ,buty = butCache:GetSize()
						butCacheLabelTest:SetSize( butx, buty )
						butCacheLabelTest.ID = i;
						butCacheLabelTest.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
						butCacheLabelTest:MoveToFront()
						butCacheLabelTest:SetMouseInputEnabled( false )
						function butCacheLabelTest:Paint( w, h )
							if self.InventorySlotCache && self.InventorySlotCache[self.ID] && self.InventorySlotCache[self.ID].ID then
							
								draw.SimpleText("\t\t".. self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							
							end	
						end
						
						
						_grid:AddItem( butCache )
						
					end	
					
						local _maxSlots = LocalPlayer():IsPremium() && fsrp.config.warehouses.SlotsPremium ||  LocalPlayer():IsDonator() && fsrp.config.warehouses.SlotsDonator || fsrp.config.warehouses.SlotsUser; 
					
					
					local _player = LocalPlayer();
					
									
						for i = 1, _maxSlots do
						
							
							butCache = vgui.Create("DButton", FRAME._WarehouseList )
							butCache.ID = i;
							butCache.InventorySlotCache = _player:getFlag("warehouseItems", {});

							butCache.TargetMDL = FRAMEmdl
							butCache:SetText("")
							butCache:SetSize( buttonSize,buttonSize)
							butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
							butCache:SetToolTip( "Left Click to Withdraw 1, Right Click to Withdraw 5, Middle Mouse to Remove" )

							local butCacheLabelTest = vgui.Create( "DPanel", butCache)
							function butCache:SetItemTable( )
									
								self.InventorySlotCache =_player:getFlag("warehouseItems", {});
								butCacheLabelTest.InventorySlotCache =_player:getFlag("warehouseItems", {});
								if self.mdl then self.mdl:Remove(); end
								
								if self.InventorySlotCache[self.ID] then
									//PrintTable( self.InventorySlotCache[self.ID] )

									local ListItem = ITEMLIST[self.InventorySlotCache[self.ID].ID];
									if ListItem && ListItem.Illegal == true then
									
									self.mdl = vgui.Create( "DModelPanel", self  )
									//self.mdl:SetFOV( 12 )
									self.mdl:SetVisible(true)
									
								
									self.mdl:SetPos( 5, 5 )
									self.mdl:SetSize( self:GetWide(), self:GetTall() )
									
									self.mdl:SetCamPos( ListItem.CamPos )

									self.mdl:SetLookAt(ListItem.LookAt )

									self.mdl:SetModel( ListItem.Model )

									//self.mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

									//self.mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

									//self.mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

									//self.mdl:SetColor( Color( 200, 200, 200 ) )

									//self.mdl:SetAnimated( false )		

									if ListItem.Scale then
										self.mdl.Entity:SetModelScale(ListItem.Scale);
									end
									self.mdl:SetMouseInputEnabled(false)
									//local iSeq = self.mdl.Entity:LookupSequence('ragdoll')
								
									//self.mdl.Entity:ResetSequence(iSeq)
									

									//self:MoveToFront()
									end
								end
							end
							butCache:SetItemTable()
							function butCache:OnMousePressed( k )
							
								//if self:IsDown() && lastTouch < CurTime() then
									//lastTouch = CurTime() + 0.1
									if !self.InventorySlotCache[self.ID] || !self.InventorySlotCache[self.ID].ID then return end
									local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
									local _amount = false;
								
									if _Item.RestrictPlayerTrade then return end
									/*
									net.Start("sendIllegalSellRequestToServer")
										net.WriteInt( _Item.ID , 16 )
										net.WriteInt( self.ID , 8 )
										net.WriteBool( _amount )
									net.SendToServer()
									*/
									
									net.Start( "WarehouseAction_Home" )
										if k == MOUSE_RIGHT then
											net.WriteInt( 2,4 )
										elseif k == MOUSE_LEFT then
											net.WriteInt( 1,4 )
										elseif k == MOUSE_MIDDLE then
											net.WriteInt( 3,4 )
										end
										net.WriteInt( self.ID, 16 )
										net.WriteBool( LocalPlayer():KeyDown( IN_ALT1 ) )
									net.SendToServer()
									
									timer.Simple( .1, function()
										
										if !FRAME then return end
										
										for k , v in pairs( FRAME._grid:GetChildren() ) do
											
											
											v:SetItemTable()
											
											
										end
										for k , v in pairs( FRAME._WarehouseGrid:GetChildren() ) do
											
											
											v:SetItemTable()
											
											
										end
										
									end )
								//end
								
							end
							
							
							function butCache:Paint( w, h )
							
								if self.InventorySlotCache[self.ID]	then
								
								local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
									
									if _Item.RestrictPlayerTrade then
										
										
										surface.SetDrawColor( 255 ,0 ,0 ,FRAME.Alpha  )
										surface.DrawOutlinedRect( 0, 0, w, h )
										
										
										
									else

										
											surface.SetDrawColor( 255 ,255 ,255,FRAME.Alpha   )
											
											surface.DrawOutlinedRect( 0, 0, w, h )
										
									
									
									end
									
									//draw.SimpleText( self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet20", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
									if self:IsHovered() && self.TargetMDL:GetModel() != ITEMLIST[self.InventorySlotCache[self.ID].ID].Model then
										
										
										self.TargetMDL:SetModel( _Item.Model )
										self.TargetMDL:SetCamPos( _Item.CamPos )
										self.TargetMDL:SetLookAt( _Item.LookAt )
										FRAME.SelectedText = _Item.Name .. " ($" .. _Item.Cost .. ")";
										FRAME.SelectedDesc = _Item.Description;
									end
									
								else
								
										surface.SetDrawColor( 128 ,128,128,FRAME.Alpha   )
										surface.DrawOutlinedRect( 0, 0, w, h )
									
									
								end
								
							end 
							
							local butx ,buty = butCache:GetSize()
							butCacheLabelTest:SetSize( butx, buty )
							butCacheLabelTest.ID = i;
							butCacheLabelTest.InventorySlotCache = _player:getFlag("warehouseItems", {});
							butCacheLabelTest:MoveToFront()
							butCacheLabelTest:SetMouseInputEnabled( false )
							function butCacheLabelTest:Paint( w, h )
								if self.InventorySlotCache && self.InventorySlotCache[self.ID] && self.InventorySlotCache[self.ID].ID then
								
									draw.SimpleText( "\t\t".. self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								
								end	
							end
									
							FRAME._WarehouseGrid:AddItem( butCache )
							if !LocalPlayer().WarehouseItemPanel then 
								
								LocalPlayer().WarehouseItemPanel = {}
								
							end
							
							table.insert( LocalPlayer().WarehouseItemPanel , butCache )
						end
					
					
				elseif ID == 5 && Desktop.Entity:getFlag("ownedBy","") == _p:SteamID() then // Remote Memory Express
					//local _ent = Desktop.Entity; 
					
					// for each hard ware type
					// we make a category
					// for each amount of upgrades
					// we make a box
					
					//local _ComputerInfo = Desktop.Entity.Specifications;
					
					// Hardware Type - > Component -> Component Level
					// For each hardware type make a category
					// for each component expose their max amount or level
					// in the component allow components to be upgraded in tab.
					
					MainPanel.CategoryPanels = { };
					MainPanel.HardwareCategories = { };
					//MainPanel.HardwareCategories = { [1] = {} , [2] = {} , [3] = {} , [4] = {} };
					
					// for each hardwaretype (key) and  hardwarecomponent( value ) in table computerinfo
					local i = 1;
					for hardWareType , hardWareComponents in pairs( Desktop.Entity.Specifications ) do
					
						if MainPanel.CategoryPanels[hardWareType] then 
						
							MainPanel.CategoryPanels[hardWareType]:Remove()
							MainPanel.CategoryPanels[hardWareType] = nil;
						
						end
					
					end
					/*
					local SelectedHardwareComponentPanel = vgui.Create( "DPanel", MainPanel )
					SelectedHardwareComponentPanel:Dock( FILL )
					SelectedHardwareComponentPanel:SetMouseInputEnabled( false )
					SelectedHardwareComponentPanel.SelectedHardware = 0;
					SelectedHardwareComponentPanel.SelectedLevel = 0;
					SelectedHardwareComponentPanel.IsSelectingComponent = false;
					
					function SelectedHardwareComponentPanel:Paint( w , h )
						local cursorX, cursorY = self:CursorPos()
						
						surface.SetDrawColor( 56, 56 ,56 , MainPanel.Alpha ) 
						local _xBuffer , _yBuffer = 0,0
						if rpcomputer.config.HardwareTypes[self.SelectedHardware] && rpcomputer.config.HardwareTypes[self.SelectedHardware].Levels[self.SelectedLevel].Desc  then
						
							_xBuffer , _yBuffer =	surface.GetTextSize( rpcomputer.config.HardwareTypes[self.SelectedHardware].Levels[self.SelectedLevel].Desc )
						
						end
						
						surface.DrawRect( cursorX +  _wMod * 10  ,cursorY + _hMod * 10 + _xBuffer, _wMod * 150 ,  _hMod * 75 )
						
						surface.SetDrawColor( 255 ,255 ,255 , MainPanel.Alpha )
						
						surface.DrawOutlinedRect( cursorX +  _wMod * 10  ,cursorY +  _hMod * 10  + _xBuffer, _wMod * 150 ,   _hMod * 75 )
						
						if rpcomputer.config.HardwareTypes[self.SelectedHardware] && rpcomputer.config.HardwareTypes[self.SelectedHardware].Levels[self.SelectedLevel] then
							
							local textGuiX, textGuiY = cursorX +10, cursorY+10;
							
							if self.IsSelectingComponent == true then
							
								draw.SimpleText( rpcomputer.config.HardwareTypes[self.SelectedHardware].Levels[self.SelectedLevel].Name , "Trebuchet24", textGuiX,textGuiY, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								draw.SimpleText( rpcomputer.config.HardwareTypes[self.SelectedHardware].Levels[self.SelectedLevel].Desc , "Trebuchet24", textGuiX,textGuiY + _hMod * 10, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								draw.SimpleText( "$" .. rpcomputer.config.HardwareTypes[self.SelectedHardware].Price , "Trebuchet24", textGuiX,textGuiY + _hMod * 20, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							
							else
								
								draw.SimpleText( rpcomputer.config.HardwareTypes[self.SelectedHardware].Name , "Trebuchet24", textGuiX,textGuiY, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								draw.SimpleText( "$" .. rpcomputer.config.HardwareTypes[self.SelectedHardware].Price , "Trebuchet24",textGuiX,textGuiY+ _hMod * 10, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							
							
							end
						end
						
					end
					*/
					
					function MainPanel:MakeTechTree( tabVisible, EntInfo )
						local _ComputerInfo = LocalPlayer().__Computer ;
						
					for hardWareType , hardWareComponents in pairs( _ComputerInfo ) do
						
						// Make a tab for each one, and a category button
						if !MainPanel.HardwareCategories[hardWareType] then
						
							MainPanel.HardwareCategories[hardWareType] = {}
							MainPanel.HardwareCategories[hardWareType] = vgui.Create( "DButton", MainPanel )
							MainPanel.HardwareCategories[hardWareType]:SetPos(( i * ( _wMod * 220 )) - _wMod * 155, _hMod * 120 )
							MainPanel.HardwareCategories[hardWareType]:SetSize( _wMod * 210, _hMod * 50 )		
							MainPanel.HardwareCategories[hardWareType].HoveredColor = Color( 145, 255 ,169, MainPanel.HardwareCategories[hardWareType].Alpha)
							MainPanel.HardwareCategories[hardWareType].PressedColor = Color( 255, 211 ,93 ,MainPanel.HardwareCategories[hardWareType].Alpha)
							MainPanel.HardwareCategories[hardWareType].DefaultColor = Color( 255 ,255 ,255 , MainPanel.HardwareCategories[hardWareType].Alpha );
							MainPanel.HardwareCategories[hardWareType].ActiveColor = Color( 0,0,0 ,0 )
							MainPanel.HardwareCategories[hardWareType].Alpha = 0;
							MainPanel.HardwareCategories[hardWareType].DoBeginning = true;
							MainPanel.HardwareCategories[hardWareType].IsAlphaVisible = true;
							MainPanel.HardwareCategories[hardWareType].FinishedBeginning = true;					
							MainPanel.HardwareCategories[hardWareType]:SetText( "" )				
						
							MainPanel.HardwareCategories[hardWareType].HardwareType = hardWareType;
							MainPanel.HardwareCategories[hardWareType].OnMousePressed = function( self, k )
							
								for k , v in pairs ( MainPanel.CategoryPanels ) do 
								
									v:SetVisible( false )
									v:SetMouseInputEnabled( false )
								
								end
								
								MainPanel.CategoryPanels[self.HardwareType]:SetVisible( true )
								MainPanel.CategoryPanels[self.HardwareType].Alpha = 0
								MainPanel.CategoryPanels[self.HardwareType].IsAlphaVisible = false
								MainPanel.CategoryPanels[self.HardwareType]:SetMouseInputEnabled( true )
								
							end 
							
							for k , v in pairs ( MainPanel.CategoryPanels ) do 
								
								v:SetVisible( false )
								v:SetMouseInputEnabled( false )
								
							end
							
							MainPanel.HardwareCategories[hardWareType].Paint = function( self,  w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								draw.SimpleText( rpcomputer.config.HardwareTypes[hardWareType].Name , "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
							
							if !MainPanel.CategoryPanels[hardWareType] then
							
								MainPanel.CategoryPanels[hardWareType] = vgui.Create( "DPanel" , MainPanel )
								MainPanel.CategoryPanels[hardWareType]:SetPos( _wMod * 5 , _hMod * 170 )						
								MainPanel.CategoryPanels[hardWareType]:SetSize( MainPanel:GetWide() - _wMod * 10 , MainPanel:GetTall() - _hMod * 175 )						
								MainPanel.CategoryPanels[hardWareType]:SetVisible( false )
								MainPanel.CategoryPanels[hardWareType].Alpha = 0
								MainPanel.CategoryPanels[hardWareType].IsAlphaVisible = false
								MainPanel.CategoryPanels[hardWareType].DoBeginning = true;
								MainPanel.CategoryPanels[hardWareType]:SetMouseInputEnabled( false )
								MainPanel.CategoryPanels[hardWareType].Paint = function( self , w , h )
									if self.DoBeginning && !self.IsAlphaVisible then
									
										self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
										
										if self.Alpha >= 254 then
										
											self.IsAlphaVisible = true;
											
										end
									
									end
									
									surface.SetDrawColor( 56, 56, 56, self.Alpha ) 
									surface.DrawRect( 0,0,w,h )
									
								
								end 
								
							end
							
							local ComponentList = vgui.Create( "DScrollPanel" , MainPanel.CategoryPanels[hardWareType] )
							ComponentList:Dock( FILL )
							ComponentList.LevelButtons = {};
							ComponentList.ComponentButtons = {};
							
							function ComponentList:RefreshList() 
												
								if #self.LevelButtons > 0 then
								
									for k , v in pairs( self.LevelButtons ) do
									
										v:Remove()
										table.remove( self.LevelButtons, k )
										
									end
									
								end
								if #self.ComponentButtons > 0 then
								
									for k , v in pairs( self.ComponentButtons ) do
									
										v:Remove()
										table.remove( self.ComponentButtons, k )
										
									end
									
								end
								
							local componentIndex = 0
							local componentLevelIndex = 0
							
							for t = 1 , rpcomputer.config.HardwareTypes[hardWareType].Max do
							
								local component = vgui.Create( "DButton" , ComponentList )
								component:SetSize( _wMod * 100, _hMod * 100 )
								component:SetPos( ( _wMod * 110 ) * t - _wMod * 50, _hMod * 30 )
								component:SetText(  "" )
								component:SetEnabled( true ) 
								component.HWLevel = t;
								component.slot = t;
								if hardWareComponents.Components[t] then
									
									component:SetEnabled( false )
								
								end
								component.DoBeginning = true;
								component.IsAlphaVisible = false;
								component.Alpha = 0;
								component.Name = hardWareType == 1 && "CPU" || hardWareType == 2 && "GPU" || hardWareType == 3 && "RAM" || hardWareType == 4 && "HDD" || "Component"
								component.ComponentList = ComponentList;
								component.hardwaretype = hardWareType;
								component.Price = rpcomputer.config.HardwareTypes[hardWareType].Price;
								component.MainPanel = MainPanel;
									component.Components = hardWareComponents.Components
								function component:OnMousePressed( k )
								
									net.Start("sendComponentPurchaseRequest")
										net.WriteInt( self.slot , 8 ) // slot;
										net.WriteInt( self.hardwaretype, 4 )
									net.SendToServer() 	
										
									timer.Simple( .25 , function()
										
										//if self.ComponentList then
											
											//self.ComponentList:RefreshList() 
																		
										//end
											for g, h in pairs( ComponentList.ComponentButtons ) do
											
												h.Components = LocalPlayer().__Computer[hardWareType].Components; // hwlevel is component slot actually 
												
												h:SetEnabled( true )
												
												if h.Components[component.slot] then
									
													h:SetEnabled( false )
													
												end
											
											end
											
											
											for g, h in pairs( ComponentList.LevelButtons ) do
												
												
												h.Components = LocalPlayer().__Computer[hardWareType].Components; // hwlevel is component slot actually 
															
												h:SetEnabled( true )
												
												if h.Components[h.HWLevel] && h.Components[h.HWLevel].Level >= h.Level  then
												
													h:SetEnabled( false )
													
												end
												
											end
										//self.MainPanel:MakeTechTree( self.hardwaretype, ents.GetByIndex( self.MainPanel.Desktop.Entity:EntIndex() ).Specifications )
									end )
								end
								
								function component:Paint( w , h )
									
									if self.DoBeginning && !self.IsAlphaVisible then
									
										self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
										
										if self.Alpha >= 254 then
										
											self.IsAlphaVisible = true;
											
										end
									
									end
									
									if  !self.Components[self.slot] then
									
										surface.SetDrawColor( 0, 255, 0, self.Alpha )
									
									else
									
										surface.SetDrawColor( 255, 0, 0, self.Alpha ) 
									
									
									end
									
									surface.DrawOutlinedRect( 0,0,w,h )
									
									draw.SimpleText( "$"..self.Price , "Trebuchet24", w/2, h/2 , Color( 255 ,255 ,255 , self.Alpha ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) 
								
								end
								
								
								table.insert( ComponentList.ComponentButtons , component )
								local ModelPanel = vgui.Create( "DModelPanel" , component )
								ModelPanel.hardwareType = hardWareType;
								ModelPanel:SetSize( _wMod * 100 , _hMod * 100 )
								local _winner = 0;
								for p , u in pairs( hardWareComponents.Components ) do
									
									if u.Level > _winner then
									
										_winner = u.Level
									
									end
									
								end
								ModelPanel:SetModel( rpcomputer.config.HardwareTypes[ModelPanel.hardwareType].Levels[_winner].Model )
								ModelPanel:SetMouseInputEnabled( false )
								
								for o = 1 , rpcomputer.config.HardwareTypes[hardWareType].MaxLevel do
								
									local componentLevel = vgui.Create( "DButton" , ComponentList )
									componentLevel:SetSize( _wMod * 55, _hMod * 55 )
									componentLevel:SetPos( ( _wMod * 110 ) * t - _wMod * 27.5, _hMod * 75 + o * ( _hMod * 65 ) )
									componentLevel:SetText(  "")
									
									componentLevel.Level = o;
									componentLevel:SetEnabled( true )
									componentLevel.Components = hardWareComponents.Components
									
									componentLevel.HWLevel = t;
									
									if hardWareComponents.Components[componentLevel.HWLevel] && hardWareComponents.Components[componentLevel.HWLevel].Level >= componentLevel.Level then
									
										componentLevel:SetEnabled( false )
										
									end
								
									componentLevel.DoBeginning = true;
									componentLevel.IsAlphaVisible = false;
									componentLevel.Alpha = 0;
									componentLevel.ComponentList = ComponentList;
									componentLevel.hardwaretype = hardWareType;
									componentLevel.MainPanel = MainPanel 
									function componentLevel:OnMousePressed( k )
									
										if self.Components[self.HWLevel] then
										
											net.Start( "sendComponentUpgradeRequest" )
												net.WriteInt( self.HWLevel , 8 )
												net.WriteInt( self.hardwaretype , 4 )
											net.SendToServer()
										
										else
											
											_p:Notify( "Purchase the component to upgrade it!" )
										
										end
										
										//PrintTable( self.Components )
										timer.Simple( .25 , function()
												
											for g, h in pairs( ComponentList.LevelButtons ) do
												
												
												h.Components = LocalPlayer().__Computer[hardWareType].Components; // hwlevel is component slot actually 
															
												h:SetEnabled( true )
												
												if h.Components[h.HWLevel] && h.Components[h.HWLevel].Level >= h.Level  then
												
													h:SetEnabled( false )
													
												end
												
											end
											for g, h in pairs( ComponentList.ComponentButtons ) do
											
												h.Components = LocalPlayer().__Computer[hardWareType].Components; // hwlevel is component slot actually 
												
												h:SetEnabled( true )
												
												if h.Components[component.slot] then
									
													h:SetEnabled( false )
													
												end
											
											end
											
											//if self.ComponentList then
											
												//self.ComponentList:RefreshList() 
																							
											//end
											
											//self.MainPanel:MakeTechTree( self.hardwaretype, ents.GetByIndex( self.MainPanel.Desktop.Entity:EntIndex() ).Specifications )
										end )
										
									end
									function componentLevel:Paint( w , h )
										
										if self.DoBeginning && !self.IsAlphaVisible then
										
											self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
											
											if self.Alpha >= 254 then
											
												self.IsAlphaVisible = true;
												
											end
										
										end
										if !self:IsEnabled() then
											
											surface.SetDrawColor( 255, 0, 0, self.Alpha ) 
										
										else
											surface.SetDrawColor( 0, 255, 0, self.Alpha )
										
										end
										surface.DrawOutlinedRect( 0,0,w,h )
										
										draw.SimpleText(  "Lv. " .. o , "Trebuchet24", w/2, h/2 , Color( 255 ,255 ,255 , self.Alpha ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) 
										
									end 
									
									table.insert( ComponentList.LevelButtons , componentLevel )
								end
							end
							
							i = i +1
						end
							ComponentList:RefreshList() 
						end
							
						
						// for each component( key ) and componentinformation( value) in table hardwarecomponents
						for ComponentNumber, ComponentInformation in pairs( hardWareComponents ) do
						
							
						
						end
					
						
						
					end
					
							
							MainPanel.CategoryPanels[tabVisible]:SetVisible( true )
							MainPanel.CategoryPanels[tabVisible].Alpha = 0
							MainPanel.CategoryPanels[tabVisible].IsAlphaVisible = false
							MainPanel.CategoryPanels[tabVisible]:SetMouseInputEnabled( true )
					end
					
					MainPanel:MakeTechTree( 1 , ents.GetByIndex( MainPanel.Desktop.Entity:EntIndex() ).Specifications)
					//SelectedHardwareComponentPanel:MoveToFront()
				elseif ID == 6 then // Image as Designed
					
					local _gender = _p:getGender();
										
					local modelSaleList = { }

					local Models = {};
					local _pTeam = _p:Team()
					
					if _pTeam == TEAM_CIVILLIAN then
						
						if !mdlTable[ _gender ] then return FRAME:Close() end;
						
						for k, v in pairs( mdlTable[ _gender] ) do 
						/*
							local iterator = iterateModelTable( 1, k );
							
								if iterator.id && iterator.mdl && player_manager.TranslateToPlayerModelName( iterator.mdl ) != "kleiner" then*/
								table.insert(Models, { _gender, v.path}); 
								
						end
					
					elseif TEAM_PARAMEDIC == _pTeam || TEAM_POLICE == _pTeam || TEAM_MAYOR == _pTeam then
					
						if !jobMdlTable[_pTeam] then return FRAME:Close() end;
						local _JobTable =  jobMdlTable[_pTeam];
						
						local _pNameFancy = ( _pTeam == TEAM_PARAMEDIC ) && "Paramedic" || ( _pTeam == TEAM_POLICE ) && "Police Officer" || (_pTeam == TEAM_MAYOR ) && "The Mayor" || "John Doe";
						
						//if !IsValid( _JobTable ) then return FRAME:Close() end
						//if !IsValid( _JobTable[_gender] ) then PrintTable( _JobTable[_gender] ) return FRAME:Close() end
						
						
						for k , v in pairs( _JobTable[tonumber(_gender)] ) do
							
								
									table.insert( Models, {_gender, v.model } )
							
							
					
						end
						
					end
					/*else
						if !jobMdlTable[_pTeam] then return Frame:Close() end;
						
						local _pNameFancy = ( _pTeam == TEAM_PARAMEDIC ) && "Paramedic" || ( _pTeam == TEAM_POLICE ) && "Police Officer" || "John Doe";
						for k , v in pairs( jobMdlTable[_pTeam][_p:getGender()]) do
						
							table.insert( Models, { _p:getGender(), v.model, _pNameFancy } )
							
						end
					*/
					local ScrollPanel = vgui.Create( "DScrollPanel", MainPanel )
					ScrollPanel:SetPos( _wMod * 15, _hMod * 210 )
					ScrollPanel:SetSize( MainPanel:GetWide() - _wMod * 30, MainPanel:GetTall() - _hMod * 230 )
					
					local grid = vgui.Create( "DGrid", ScrollPanel )
					grid:SetCols( 4 )
					grid:SetSize( ScrollPanel:GetWide() , ScrollPanel:GetTall() )
					grid:SetColWide( _wMod * 230 )
					grid:SetRowHeight( _hMod * 300 )

				timer.Simple( 0.1, function()
					
					modelSaleList = {};
					for k, v in pairs( Models ) do
									local i = 0
						timer.Simple( (i*0.2), function() 
							
							local ModelPanelBackground = vgui.Create( "DPanel", grid )
							ModelPanelBackground:SetSize( _wMod * 225 , _hMod * 275 )
							ModelPanelBackground.Alpha = 0;
							ModelPanelBackground.grid = grid;
							ModelPanelBackground.DoBeginning = true;
							function ModelPanelBackground:Paint( w, h )
								
								if self.DoBeginning then
										
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.DoBeginning = false;
									
									end							
									
								end
								
								surface.SetDrawColor( 56, 56 ,56 ,self.Alpha ) 
								surface.DrawRect( 0,0, w, h )
							
							end 
							
							local ModelPanelDisplayModel = vgui.Create( "DModelPanel", ModelPanelBackground )
							ModelPanelDisplayModel:SetSize( ModelPanelBackground:GetWide() - _wMod * 30 , ModelPanelBackground:GetTall() - _hMod * 15 )
							ModelPanelDisplayModel:SetPos( _wMod * 15 , _hMod * 7.5 )
							ModelPanelDisplayModel:SetModel( v[2] )
							
							local ModelPanelPurchaseButton = vgui.Create( "DButton", ModelPanelBackground )
							ModelPanelPurchaseButton:SetPos( ModelPanelBackground:GetWide()*0.5 - _wMod * 50 , _hMod * 10 )
							ModelPanelPurchaseButton:SetSize( _wMod * 100 , _hMod * 35 )
							ModelPanelPurchaseButton.mdl = player_manager.TranslateToPlayerModelName( v[2] );
							function ModelPanelPurchaseButton:OnMousePressed( k )
							
								net.Start("modelchange_buyCartRemote")
									
									net.WriteString( self.mdl );
								
								net.SendToServer()
							
							end 
							ModelPanelPurchaseButton:SetText("")
							ModelPanelPurchaseButton.HoveredColor = Color( 145, 255 ,169, ModelPanelPurchaseButton.Alpha)
							ModelPanelPurchaseButton.PressedColor = Color( 255, 211 ,93 ,ModelPanelPurchaseButton.Alpha)
							ModelPanelPurchaseButton.DefaultColor = Color( 255 ,255 ,255 , ModelPanelPurchaseButton.Alpha );
							ModelPanelPurchaseButton.ActiveColor = Color( 0,0,0 ,0 )
							ModelPanelPurchaseButton.Alpha = 0;
							ModelPanelPurchaseButton.DoBeginning = true;
							ModelPanelPurchaseButton.IsAlphaVisible = true;
							ModelPanelPurchaseButton.FinishedBeginning = true;
							function ModelPanelPurchaseButton:Paint( w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								draw.SimpleText( "Purchase", "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
					
							grid:AddItem( ModelPanelBackground )
							i = i+1						
						end )
						/*
						local icon = ModelGrid:Add( "SpawnIcon" )
						icon:SetSize( 64, 64 )
						icon:InvalidateLayout( true )
						icon:SetModel( v[2] )
						icon.mdl = v[2];
						table.insert( modelSaleList, icon )
						icon.DoClick = function()
							
														
						_p:setFlag("modelchange_playerModel_cart",player_manager.TranslateToPlayerModelName( icon.mdl )  );
									
						//net.Start("modelchanger_updatePlayerModel" )
							//net.WriteString( player_manager.TranslateToPlayerModelName( icon.mdl ) )
						//net.SendToServer()
						
									
						end
						*/
						
					end
							//ModelList:AddLine( name, model )
						
						
				end)
			
				
					
				elseif ID == 7 && Desktop.Entity:getFlag("propertyDisplayProp",false) == true  && Desktop.Entity:getFlag("propertyPropID",-1) == LocalPlayer():getFlag("ResidingInControlledProperty", 0) then // TheOpenRoad

					local ScrollPanel = vgui.Create( "DScrollPanel", MainPanel )
					ScrollPanel:SetPos( _wMod * 15, _hMod * 210 )
					ScrollPanel:SetSize( MainPanel:GetWide() - _wMod * 30, MainPanel:GetTall() - _hMod * 230 )
					
					local grid = vgui.Create( "DGrid", ScrollPanel )
					grid:SetCols( 4 )
					grid:SetSize( ScrollPanel:GetWide() , ScrollPanel:GetTall() )
					grid:SetColWide( _wMod * 230 )
					grid:SetRowHeight( _hMod * 300 )
					grid.gridChildren = {};
					local _fileFormat = ( game.GetMap() == "rp_evocity_v33x" && "png" || "jpg" ) ;
				//timer.Simple( 0.1, function()
					
				function grid:Populate()	
					modelSaleList = {};local i = 0
					for k, v in pairs( fsrp.I_BusinessPropertyTable ) do
									i =0;
						timer.Simple( (i*0.2), function() 
												
							local _businesses = LocalPlayer():GetBusiness(true);

								_fileFormat = "jpg"
							
							
							//if LocalPlayer():HasBusinessIDTag(  v.BusinessInformation.Tag , true ) then return end

							local _foundBusiness = nil;
							for x , y in pairs( _businesses ) do
								if y[2] == v.BusinessInformation.Tag then
									_foundBusiness = x;
									break;
								end

							end


							if _foundBusiness != nil then return end
							

							local ModelPanelBackground = vgui.Create( "DPanel", grid )
							ModelPanelBackground:SetSize( _wMod * 225 , _hMod * 275 )
							ModelPanelBackground.Alpha = 0;
							ModelPanelBackground.Business = v;
							ModelPanelBackground.grid = grid;
							ModelPanelBackground.DoBeginning = true;
							ModelPanelBackground.PropertyImage = Material( "properties/" .. v.Mat )
							function ModelPanelBackground:Paint( w, h )
								
								if self.DoBeginning then
										
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.DoBeginning = false;
									
									end							
									
								end
								
								surface.SetDrawColor( 56, 56 ,56 ,self.Alpha ) 
								surface.DrawRect( 0,0, w, h )
								surface.SetDrawColor( 255, 255 ,255 ,self.Alpha ) 

								surface.DrawRect( _wMod*5,_hMod*45, w-(_wMod*10), h-(_hMod*50) )
								draw.SimpleText( self.Business.Name, "Trebuchet24", w/2,_hMod*60, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								
								local _canAfford = LocalPlayer():canAffordBank(self.Business.Cost) == true &&  Color( 56,95 ,56 , Desktop.Alpha ) ||  Color( 95 ,56 ,56 , Desktop.Alpha )
								draw.SimpleText( "Cost: $" .. self.Business.Cost, "Trebuchet24", _wMod*10,_hMod*210,_canAfford, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
								draw.SimpleText( "Type: " .. fsrp.config.IllegalBusinessTypes[self.Business.BusinessInformation.Type].Name, "Trebuchet24", _wMod*10,_hMod*232,_canAfford, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
							
								surface.SetDrawColor( 56, 56 ,56 ,self.Alpha ) 
								surface.DrawRect( 0,_wMod*75, w, _hMod*5 )
								surface.SetDrawColor( 255, 255 ,255 ,self.Alpha )
								surface.SetMaterial(ModelPanelBackground.PropertyImage );
								surface.DrawTexturedRect(_wMod*5, _hMod*80,w-(_wMod*10), _hMod*128);
								draw.NoTexture()
								surface.SetDrawColor( 56, 56 ,56 ,self.Alpha ) 
								surface.DrawRect( 0,_wMod*203, w, _hMod*5 )

							end 
							
							//local ModelPanelDisplayModel = vgui.Create( "DModelPanel", ModelPanelBackground )
							//ModelPanelDisplayModel:SetSize( ModelPanelBackground:GetWide() - _wMod * 30 , ModelPanelBackground:GetTall() - _hMod * 15 )
							//ModelPanelDisplayModel:SetPos( _wMod * 15 , _hMod * 7.5 )
							//ModelPanelDisplayModel:SetModel( v[2] )
							
							local ModelPanelPurchaseButton = vgui.Create( "DButton", ModelPanelBackground )
							ModelPanelPurchaseButton:SetPos( ModelPanelBackground:GetWide()*0.5 - _wMod * 50 , _hMod * 10 )
							ModelPanelPurchaseButton:SetSize( _wMod * 100 , _hMod * 30 )
							//ModelPanelPurchaseButton.mdl = player_manager.TranslateToPlayerModelName( v[2] );
							ModelPanelPurchaseButton.ParentPanel = ModelPanelBackground;
							ModelPanelPurchaseButton.grid = ModelPanelBackground.grid;

							function ModelPanelPurchaseButton:OnMousePressed( k )
								if !LocalPlayer():canAffordBank(self.ParentPanel.Business.Cost) then return LocalPlayer():Notify("You can not afford this property.") end
								net.Start("computerForeclosure")
								net.WriteInt(1,16)
								net.WriteInt(ModelPanelPurchaseButton.ParentPanel.Business.ID,16)
								local _diffmap = false;
								if self.ParentPanel.DifferentMap then
									_diffmap = self.ParentPanel.DifferentMap
								end
								net.WriteBool(_diffmap)
								net.SendToServer()
								
								ProgramPanel.Desktop:Close();
								//timer.Simple(1,function()if !MainPanel then return end	MainPanel:RefreshLayout() end)

							end 
							ModelPanelPurchaseButton:SetText("")
							ModelPanelPurchaseButton.HoveredColor = Color( 145, 255 ,169, ModelPanelPurchaseButton.Alpha)
							ModelPanelPurchaseButton.PressedColor = Color( 255, 211 ,93 ,ModelPanelPurchaseButton.Alpha)
							ModelPanelPurchaseButton.DefaultColor = Color( 255 ,255 ,255 , ModelPanelPurchaseButton.Alpha );
							ModelPanelPurchaseButton.ActiveColor = Color( 0,0,0 ,0 )
							ModelPanelPurchaseButton.Alpha = 0;
							ModelPanelPurchaseButton.DoBeginning = true;
							ModelPanelPurchaseButton.IsAlphaVisible = true;
							ModelPanelPurchaseButton.FinishedBeginning = true;
							function ModelPanelPurchaseButton:Paint( w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								draw.SimpleText( "Purchase", "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
					
							grid:AddItem( ModelPanelBackground )
							i = i+1	
							table.insert(grid.gridChildren , ModelPanelBackground)					
						end)
						/*
						local icon = ModelGrid:Add( "SpawnIcon" )
						icon:SetSize( 64, 64 )
						icon:InvalidateLayout( true )
						icon:SetModel( v[2] )
						icon.mdl = v[2];
						table.insert( modelSaleList, icon )
						icon.DoClick = function()
							
														
						_p:setFlag("modelchange_playerModel_cart",player_manager.TranslateToPlayerModelName( icon.mdl )  );
									
						//net.Start("modelchanger_updatePlayerModel" )
							//net.WriteString( player_manager.TranslateToPlayerModelName( icon.mdl ) )
						//net.SendToServer()
						
									
						end
						*/
						
					end
							//ModelList:AddLine( name, model )
						
						
				end
			//end is here from 6

					//grid:Clear()
					grid:Populate()
					
				elseif ID == 8 && Desktop.Entity:getFlag("ownedBy","") == _p:SteamID() then // MazeBank

					local ScrollPanel = vgui.Create( "DScrollPanel", MainPanel )
					ScrollPanel:SetPos( _wMod * 15, _hMod * 210 )
					ScrollPanel:SetSize( MainPanel:GetWide() - _wMod * 30, MainPanel:GetTall() - _hMod * 230 )
					
					grid = vgui.Create( "DGrid", ScrollPanel )
					grid:SetCols( 4 )
					grid:SetSize( ScrollPanel:GetWide() , ScrollPanel:GetTall() )
					grid:SetColWide( _wMod * 230 )
					grid:SetRowHeight( _hMod * 300 )

					local _fileFormat = ( game.GetMap() == "rp_evocity_v33x" && "png" || "jpg" ) ;
					grid.gridChildren = {};
					function grid:Populate()
					modelSaleList = {};
									local i = 0
									//grid:Clear()
					for k, v in pairs( fsrp.ClubhousePropertyTable ) do
						i =0;
						timer.Simple( (i*0.2), function() 
									

							local _businesses = LocalPlayer():getFlag("DT_ID_Business_DATA" , {} )	
							if v.DifferentMap && v.DifferentMap != true  || !v.DifferentMap then

								_pre = "rp_downtown_v4c_v2"
								_fileFormat = "jpg"
							else

								_pre = "fsrp"
								_fileFormat = "png"
								_businesses = LocalPlayer():getFlag("EVO_ID_Business_DATA" , {} )	

							end
							
							
							//if LocalPlayer():HasBusinessIDTag(  v.BusinessInformation.Tag , true ) then return end

							local _foundBusiness = nil;
							for x , y in pairs( _businesses ) do

								if y == v.ClubHouseInformation.Tag then
									_foundBusiness = x;
									break;
								end

							end

							if _foundBusiness != nil then return end

							if LocalPlayer():HasBusinessIDTag(  v.ClubHouseInformation.Tag , true ) then return  end
							
							local ModelPanelBackground = vgui.Create( "DPanel", grid )
							ModelPanelBackground:SetSize( _wMod * 225 , _hMod * 275 )
							ModelPanelBackground.Alpha = 0;
							ModelPanelBackground.Clubhouse = v;
							ModelPanelBackground.DoBeginning = true;
							ModelPanelBackground.GridPanel = grid;
							ModelPanelBackground.PropertyImage = Material( _pre .. "/properties/" .. v.Mat.. "." .. _fileFormat )
							function ModelPanelBackground:Paint( w, h )
								
								if self.DoBeginning then
										
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.DoBeginning = false;
									
									end							
									
								end
								
								surface.SetDrawColor( 56, 56 ,56 ,self.Alpha ) 
								surface.DrawRect( 0,0, w, h )
								surface.SetDrawColor( 255, 255 ,255 ,self.Alpha ) 

								surface.DrawRect( _wMod*5,_hMod*45, w-(_wMod*10), h-(_hMod*50) )
								draw.SimpleText( self.Clubhouse.Name, "Trebuchet24", w/2,_hMod*60, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								
								local _canAfford = LocalPlayer():canAffordBank(self.Clubhouse.Cost) == true &&  Color( 56,95 ,56 , Desktop.Alpha ) ||  Color( 95 ,56 ,56 , Desktop.Alpha )
								draw.SimpleText( "Cost: $" .. self.Clubhouse.Cost, "Trebuchet24", _wMod*10,_hMod*210,_canAfford, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
								//draw.SimpleText( "", "Trebuchet24", _wMod*10,_hMod*232,_canAfford, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
							
								surface.SetDrawColor( 56, 56 ,56 ,self.Alpha ) 
								surface.DrawRect( 0,_wMod*75, w, _hMod*5 )
								surface.SetDrawColor( 255, 255 ,255 ,self.Alpha )
								surface.SetMaterial(ModelPanelBackground.PropertyImage );
								surface.DrawTexturedRect(_wMod*5, _hMod*80,w-(_wMod*10), _hMod*128);
								draw.NoTexture()
								surface.SetDrawColor( 56, 56 ,56 ,self.Alpha ) 
								surface.DrawRect( 0,_wMod*203, w, _hMod*5 )

							end 
							
							//local ModelPanelDisplayModel = vgui.Create( "DModelPanel", ModelPanelBackground )
							//ModelPanelDisplayModel:SetSize( ModelPanelBackground:GetWide() - _wMod * 30 , ModelPanelBackground:GetTall() - _hMod * 15 )
							//ModelPanelDisplayModel:SetPos( _wMod * 15 , _hMod * 7.5 )
							//ModelPanelDisplayModel:SetModel( v[2] )
							
							local ModelPanelPurchaseButton = vgui.Create( "DButton", ModelPanelBackground )
							ModelPanelPurchaseButton:SetPos( ModelPanelBackground:GetWide()*0.5 - _wMod * 50 , _hMod * 10 )
							ModelPanelPurchaseButton:SetSize( _wMod * 100 , _hMod * 30 )
							//ModelPanelPurchaseButton.mdl = player_manager.TranslateToPlayerModelName( v[2] );
							ModelPanelPurchaseButton.ParentPanel = ModelPanelBackground.Clubhouse;
							ModelPanelPurchaseButton.grid = ModelPanelBackground.GridPanel;
							function ModelPanelPurchaseButton:OnMousePressed( k )
								if !LocalPlayer():canAffordBank(self.ParentPanel.Cost) then return LocalPlayer():Notify("You can not afford this property.") end
								net.Start("computerForeclosure")
								net.WriteInt(2,16)
								net.WriteInt(ModelPanelPurchaseButton.ParentPanel.ID,16)
								local _diffmap = false;
								if self.ParentPanel.DifferentMap then
									_diffmap = self.ParentPanel.DifferentMap
								end
								net.WriteBool(_diffmap)
								net.SendToServer()

								ProgramPanel.Desktop:Close();
								//timer.Simple(1,function()if !MainPanel then return end	MainPanel:RefreshLayout() end)

								//ModelPanelPurchaseButton.GridPanel:Clear()

							end 
							ModelPanelPurchaseButton:SetText("")
							ModelPanelPurchaseButton.HoveredColor = Color( 145, 255 ,169, ModelPanelPurchaseButton.Alpha)
							ModelPanelPurchaseButton.PressedColor = Color( 255, 211 ,93 ,ModelPanelPurchaseButton.Alpha)
							ModelPanelPurchaseButton.DefaultColor = Color( 255 ,255 ,255 , ModelPanelPurchaseButton.Alpha );
							ModelPanelPurchaseButton.ActiveColor = Color( 0,0,0 ,0 )
							ModelPanelPurchaseButton.Alpha = 0;
							ModelPanelPurchaseButton.DoBeginning = true;
							ModelPanelPurchaseButton.IsAlphaVisible = true;
							ModelPanelPurchaseButton.FinishedBeginning = true;
							function ModelPanelPurchaseButton:Paint( w, h )
								
								if self.DoBeginning && !self.IsAlphaVisible then
								
									self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
									
									if self.Alpha >= 254 then
									
										self.IsAlphaVisible = true;
										
									end
								
								elseif self.DoBeginning && self.IsAlphaVisible then
									
									if self:IsDown() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
									
									elseif self:IsHovered() then
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
									
									else
									
										self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
									
									end
								
								end
								
								surface.SetDrawColor( self.ActiveColor )
								surface.DrawRect( 0,0,w,h )
								
								draw.SimpleText( "Purchase", "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end 
					
							grid:AddItem( ModelPanelBackground )
							table.insert(grid.gridChildren , ModelPanelBackground)
							i = i+1						
						end )
						/*
						local icon = ModelGrid:Add( "SpawnIcon" )
						icon:SetSize( 64, 64 )
						icon:InvalidateLayout( true )
						icon:SetModel( v[2] )
						icon.mdl = v[2];
						table.insert( modelSaleList, icon )
						icon.DoClick = function()
							
														
						_p:setFlag("modelchange_playerModel_cart",player_manager.TranslateToPlayerModelName( icon.mdl )  );
									
						//net.Start("modelchanger_updatePlayerModel" )
							//net.WriteString( player_manager.TranslateToPlayerModelName( icon.mdl ) )
						//net.SendToServer()
						
									
						end
						*/
						
					end
							//ModelList:AddLine( name, model )
						
						
				end			//ModelList:AddLine( name, model )
					grid:Clear()
					grid:Populate()
					
			// end is here for 8
				end
				
		end )
		
	end )
	
		
	return ProgramPanel;
	
end

net.Receive( "sendDesktopClose" ,function( _l , _p )

	if LocalPlayer().ComputerDesktop && IsValid(LocalPlayer().ComputerDesktop)  then
	
		LocalPlayer().ComputerDesktop:Close()
		LocalPlayer().ComputerDesktop = nil
		
	end

end )
local function MakeComputerDesktop( _computerEnt )
	
	local _p = LocalPlayer();
	
	local Desktop = vgui.Create( "DFrame" )
	
	//_p:Notify( "Working on a computer with Speed:" .. _devSkew )
	Desktop:SetSize( ScrW() - _wMod * 100  , ScrH() - _hMod * 100 )
	Desktop:ShowCloseButton( false )
	Desktop:MakePopup( )
	Desktop:Center( )
	Desktop.Alpha = 0;
	Desktop.IntroTextAlpha = 0;
	Desktop.IntroColor = Color( _p:getFlag("computermenuUI_R", 56 ) , _p:getFlag("computermenuUI_B", 56 ) , _p:getFlag("computermenuUI_B", 56 ) , 128 )
	Desktop.BackgroundColor = Color( _p:getFlag("computermenuUI_R", 56 ) , _p:getFlag("computermenuUI_B", 56 ) , _p:getFlag("computermenuUI_B", 56 ) , 185 )
	Desktop.ActiveColor = Color( 0 , 0 , 0 , 0 )
	Desktop.Intro = false
	Desktop.IntroText = false;
	Desktop.Startup = false;
	Desktop.StartupHook = false;
	Desktop.Entity = _computerEnt;
	hook.Run( "DesktopStartUp" , Desktop );
	Desktop.HTMLPanels = {}
	_p.ComputerUI = true;
	Desktop.ActivePrograms = {};
	LocalPlayer():setFlag("restrictInv", true )
	local _genderPro = _p:getGender() == 1 && "her" || "his";
	LocalPlayer():ConCommand("say /me turns " .. _genderPro .. " computer on.")
	function Desktop:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false )
		for k , v in pairs( self.HTMLPanels ) do
		
			v:Remove()
			
		end
	
					net.Start("endWarehouse")
					net.SendToServer()
	end
	Desktop.Programs = { 
		{ Name = "Coin-Broker", Desc = "Trade coin and make money!"}; // 1
		{ Name = "Homebanker" , Desc = "Withdraw/Deposit cash on the go!"}; // 2 
		{ Name = "World Wide Web" , Desc = "Search the web!" }; // 3 
		{ Name = "Remote Warehouse" , Desc = "Store your items while at home!"};// 4
		{ Name = "Remote Memory Express" , Desc = "Upgrade your PC!" }; // 5
		{ Name = "Image as Designed" , Desc = "Remotely purchase outfits! $2000 per change." };// 6
		{ Name = "TheOpenRoad" , Desc = "Purchase freedom properties here!" };//7
		{ Name = "Maze Bank Foreclosures" , Desc = "Purchase special properties here!" };//8
	}

	Desktop.ActualPrograms = { 
		  ProgramMainPanel( Desktop ,1);
		  ProgramMainPanel( Desktop,2 ) ;
		  ProgramMainPanel( Desktop,3) ;
		  ProgramMainPanel( Desktop,4 ) ;
		  ProgramMainPanel( Desktop,5 ) ;
		  ProgramMainPanel( Desktop, 6 );
		  ProgramMainPanel( Desktop, 7 );
		  ProgramMainPanel( Desktop, 8 );
	}
	
	for k , v in pairs( Desktop.ActualPrograms ) do
		
		v:SetVisible( false )
		v:SetMouseInputEnabled( false )
	
	end
	
		local CloseButton = vgui.Create( "DButton" , Desktop )
		Desktop.CloseButton = CloseButton;
		Desktop.CloseButton.Desktop = Desktop;
		Desktop.CloseButton:SetSize( _wMod * 150 , _hMod * 75 )
		Desktop.CloseButton:SetPos( Desktop:GetWide() - _wMod * 200 , _hMod * 25 )
		
						
		Desktop.CloseButton.HoveredColor = Color( 145, 255 ,169, Desktop.CloseButton.Alpha)
		Desktop.CloseButton.PressedColor = Color( 255, 211 ,93 ,Desktop.CloseButton.Alpha)
		Desktop.CloseButton.DefaultColor = Color( 255 ,255 ,255 , Desktop.CloseButton.Alpha );
		Desktop.CloseButton.ActiveColor = Color( 0,0,0 ,0 )
		Desktop.CloseButton.Alpha = 0;
		Desktop.CloseButton.DoBeginning = true;
		Desktop.CloseButton.IsAlphaVisible = true;
		Desktop.CloseButton.FinishedBeginning = true;
		Desktop.CloseButton:SetText("")
		
	function Desktop.CloseButton:Paint( w, h )
			
		if self.DoBeginning && !self.IsAlphaVisible then
			
			self.Alpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
				
			if self.Alpha >= 254 then
				
				self.IsAlphaVisible = true;
					
			end
			
		elseif self.DoBeginning && self.IsAlphaVisible then
				
			if self:IsDown() then
				
				self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
			elseif self:IsHovered() then
				
				self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
			else
				
				self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
			end
			
		end
			
		surface.SetDrawColor( self.ActiveColor )
		surface.DrawRect( 0,0,w,h )
		
		draw.SimpleText( "Exit Computer" , "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					
	end 
		
	function Desktop.CloseButton:OnMousePressed( k ) 
				
		LocalPlayer():ConCommand("say /me puts their computer to sleep.")
		LocalPlayer():setFlag("restrictInv", false )
		for k , v in pairs( self.Desktop.HTMLPanels ) do
		
			v:Remove()
			
		end
		Desktop:Remove();
		
	end 
	
	function Desktop:StartProgram( ID )
				
		//if self.ActivePrograms[ID] then return end
		
		//_p:Notify("Starting program: " .. Desktop.Programs[ID].Name );
		
		for k , v in pairs( self.ActualPrograms ) do
		
			v:SetVisible( false )
			v:SetMouseInputEnabled( false )
			v:MoveToBack( false )
			
		end
		
		self.ActualPrograms[ID]:SetVisible( true )
		self.ActualPrograms[ID]:SetMouseInputEnabled( true )
		self.ActualPrograms[ID]:MoveToFront( )
		self.ActualPrograms[ID].ID = ID
		//self.ActivePrograms[ID] = {Name = self.Programs[ID].Name , Program = self.ActualPrograms[ID], ID = ID}
		
		if self.TaskBar.ProgramStache then
		
			self.TaskBar.ProgramStache:RefreshPrograms( )
			
		end
		
	end 
	
	function Desktop:OnMousePressed( )
		
		if self.TaskBar && self.TaskBar.StartMenuButton.StartMenu && self.TaskBar.StartMenuButton.StartMenu.IsReadyForPrograms == true then
		
			self.TaskBar.StartMenuButton.StartMenu.DoEndingAnimation = true;
			
		end
	
	end
	
	function Desktop:MakeComputerTaskbar(  )
 
		local TaskBar = vgui.Create( "DPanel" , self ) 
		TaskBar:SetSize( self:GetWide() , _hMod * 50 )
		TaskBar:SetPos( 0, self:GetTall() - _hMod * 51 );
		
		function TaskBar:Paint( w, h )
		
		surface.SetDrawColor( 255, 255 ,255 , Desktop.Alpha )
			
			surface.DrawOutlinedRect(0,0,w,h)
			/*
			//if( !SW.Time ) then return end
			local hr = math.floor( SW.Time );
			local min = math.floor( 60 * ( SW.Time - hr ) );
			
			local text = "Time";
			local ampm = "AM";
			if( hr > 12 ) then
				ampm = "PM";
			end
			if( hr > 12 ) then
				hr = hr - 12;
			end
				
			if( hr == 0 ) then
				hr = 12;
			end
				
			if( min < 10 ) then
				min = "0" .. min;
			end
				
			text = hr .. ":" .. min .. " " .. ampm;
			
			local x,y= surface.GetTextSize( text )
	
			draw.SimpleText( text, "Trebuchet24", _wMod * 25 , _hMod * 25, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			*/
				
		end 
		
		TaskBar.Desktop = self; 
		
		local ProgramStache = vgui.Create( "DPanel", TaskBar )
		TaskBar.ProgramStache =  ProgramStache
		TaskBar.ProgramStache.Desktop =  TaskBar.Desktop
		 
		TaskBar.ProgramStache:SetSize( TaskBar:GetWide() - _wMod * 125 , TaskBar:GetTall() )
		TaskBar.ProgramStache:SetPos( _wMod * 125 , 0 )
		
		function TaskBar.ProgramStache:RefreshPrograms( )
		
			if self:HasChildren() then
			
				for k , v in pairs( self:GetChildren( ) ) do 
				
					v:Remove()
			
				end
				
			end
			i = 0;
			/*
			for k , v in pairs( self.Desktop.ActivePrograms ) do
				
				local Program = vgui.Create( "DPanel" , self )
				Program = Program;
				//Program:Dock( FILL )
				Program:SetSize( _wMod * 200 , self:GetTall() )
				Program:SetPos( i * _wMod * 220 , 0)
				Program.ProgramName = v.Name;
				Program.ID = v.ID;
				Program.Desktop = self.Desktop
				function Program:OnMousePressed( k )
					
					for k , v in pairs( self.Desktop.ActualPrograms ) do
					
						v:SetVisible(false)
						v:SetMouseInputEnabled(false)
						v:MoveToBack()
						
					end
					self.Desktop:MoveToFront();
					
					if !self.Desktop.ActualPrograms[self.ID]:IsVisible() then
					
						self.Desktop.ActualPrograms[self.ID]:SetVisible(true)
						self.Desktop.ActualPrograms[self.ID]:SetMouseInputEnabled(true)
						self.Desktop.ActualPrograms[self.ID]:MoveToFront()
					
					
					end
					
				end 
							
				Program.PressedColor = Color( 145, 255 ,169, self.Alpha)
				Program.HoveredColor = Color( 255, 211 ,93 , self.Alpha)
				Program.DefaultColor = Color( 255 ,255 ,255 , self.Alpha );
				Program.ActiveColor = Color( 0,0,0 ,0 )
				function Program:Paint( w, h )
					
					
					if self:IsHovered() then
						
						self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
						
					else
						
						self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
						
					end
					
					surface.SetDrawColor( self.ActiveColor )
					surface.DrawRect(0,0,w,h)
					
					draw.SimpleText( self.ProgramName , "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 , Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				end
				
				//self:AddPanel( Program )
				i = i +1;
				
			end
			*/
			
		end
		
		function TaskBar:MakeStartMenuButton()
			
			local StartMenuButton = vgui.Create( "DButton", self )
			StartMenuButton:SetSize( _wMod * 125 , self:GetTall() )
			StartMenuButton:SetPos( 0 , 0)
			StartMenuButton:SetText( "" )
			
			StartMenuButton.TaskBar		 = self;
			StartMenuButton.Desktop		 = self.Desktop;
			
			// Start menu open
			StartMenuButton.OpenYPos	 = 0;
			StartMenuButton.OpenXPos	 = _wMod * 2.5;
			StartMenuButton.OpenWidth	 = _wMod *5;
			StartMenuButton.OpenHeight 	 = -_hMod *10;
			
			// Start menu closed
			StartMenuButton.ClosedYPos	 = _hMod * 5;
			StartMenuButton.ClosedXPos	 = _wMod * 2.5;
			StartMenuButton.ClosedWidth	 = _wMod *5;
			StartMenuButton.ClosedHeight = _hMod *10;
			
			// Start menu currently
			StartMenuButton.ActiveYPos	 = StartMenuButton.ClosedYPos;
			StartMenuButton.ActiveXPos	 = StartMenuButton.ClosedXPos;
			StartMenuButton.ActiveWidth	 = StartMenuButton.ClosedWidth;
			StartMenuButton.ActiveHeight = StartMenuButton.ClosedHeight;
			
			StartMenuButton.IsStartMenuOpenReady = false;
			
			function StartMenuButton:Paint( w , h )
				
				if self:IsHovered() then
						
					surface.SetDrawColor( 255, 211 ,93 , self.Alpha )
					
					surface.DrawRect(0,0,w,h)
				
					surface.SetDrawColor( 145, 255 ,169 , self.Alpha )
						
				else
						
					surface.SetDrawColor( 145, 255 ,169 , self.Alpha )
					
					surface.DrawRect(0,0,w,h)
					
					surface.SetDrawColor( 255, 211 ,93 , self.Alpha )
					
						
				end
					
				if self:IsHovered() then
													
					self.ActiveYPos	 	 = Lerp( 0.01* _devSkew , self.ActiveYPos,  self.OpenYPos );
					self.ActiveXPos	 	 = Lerp( 0.01* _devSkew , self.ActiveXPos,  self.OpenXPos );
					self.ActiveWidth	 = Lerp( 0.01* _devSkew , self.ActiveWidth, self.OpenWidth );
					self.ActiveHeight 	 = Lerp( 0.01* _devSkew , self.ActiveHeight, self.OpenHeight);					
					
					self.IsStartMenuOpenReady = true;						
					
				else
				
					self.ActiveYPos	 	 = Lerp( 0.01* _devSkew , self.ActiveYPos,  self.ClosedYPos );
					self.ActiveXPos	 	 = Lerp( 0.01* _devSkew , self.ActiveXPos,  self.ClosedXPos );
					self.ActiveWidth	 = Lerp( 0.01* _devSkew , self.ActiveWidth, self.ClosedWidth );
					self.ActiveHeight 	 = Lerp( 0.01* _devSkew , self.ActiveHeight, self.ClosedHeight);	
					
				end
				
				surface.DrawRect( self.ActiveXPos, self.ActiveYPos , w-self.ActiveWidth,h-self.ActiveHeight)
				
				draw.SimpleText( "Start", "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 ,self.Desktop.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
			end
						
			
			function StartMenuButton:OnMousePressed( key )
				
				if !self.StartMenu then
				
					if self.IsStartMenuOpenReady then
						
						self.StartMenu = self:MakeStartMenu()
						
					end
					
				else
					
					self.IsStartMenuOpenReady = false;
				 
					if self.StartMenu.IsReadyForPrograms == true then
					
						self.StartMenu.AchievedHeight = false;
						self.StartMenu.AchievedWidth = false;
						self.StartMenu.AchievedX = false;
						self.StartMenu.AchievedY = false;
						self.StartMenu.DoEndingAnimation = true;
					
					end
					
				end
			
			end
			
			function StartMenuButton:MakeStartMenu()
			
				local StartMenu = vgui.Create( "DPanel", self.TaskBar.Desktop )
				
				StartMenu:SetPos( 0, self.TaskBar.Desktop:GetTall() - _wMod * 550 )
				StartMenu:SetSize( _wMod * 750 , _hMod * 500 )
				
				StartMenu.DoStartingAnimation = true;
				StartMenu.Desktop 			= self.Desktop
				StartMenu.DoEndingAnimation = false;
				StartMenu.IsReadyForPrograms = false;
				// Start menu started
				StartMenu.OpenYPos	 	 = _hMod * 5;
				StartMenu.OpenXPos	 	 = _wMod * 5;
				StartMenu.OpenWidth	 	 = -_wMod *10;
				StartMenu.OpenHeight 	 = -_hMod *10;
				
				// Start menu begins
				StartMenu.ClosedYPos	 = _hMod * 500;
				StartMenu.ClosedXPos	 = _wMod * 5;
				StartMenu.ClosedWidth	 = -_wMod *655;
				StartMenu.ClosedHeight   = -_hMod *590;
				
				// Start menu currently
				StartMenu.ActiveYPos	 = StartMenu.ClosedYPos;
				StartMenu.ActiveXPos	 = StartMenu.ClosedXPos;
				StartMenu.ActiveWidth	 = StartMenu.ClosedWidth;
				StartMenu.ActiveHeight 	 = StartMenu.ClosedHeight;
				
				StartMenu.AchievedHeight = false;
				StartMenu.AchievedWidth = false;
				StartMenu.AchievedX = false;
				StartMenu.AchievedY = false;
				
				StartMenu.AccessButton = self
				StartMenu.Alpha = 255;
				StartMenu.NoAlpha = 0;
				StartMenu.SetClosingProgramAlpha = false;
				
				local StartMenuX , StartMenuY = StartMenu:GetSize()
				function StartMenu:Paint( w, h )
					
					
					surface.SetDrawColor( 255, 211 ,93 , self.Alpha )
				
					surface.DrawRect(0,0,w,h)
				
					surface.SetDrawColor( 145, 255 ,169 , self.Alpha )
					
					draw.SimpleText( "Thank you!", "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 ,self.NoAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					
					if self.DoStartingAnimation == true then
					
						self.ActiveYPos	 	 = Lerp( 0.05* _devSkew , self.ActiveYPos,  self.OpenYPos );
						self.ActiveXPos	 	 = Lerp( 0.05* _devSkew , self.ActiveXPos,  self.OpenXPos );
																	
						if self.AchievedY && !self.AchievedHeight then
						
							self.ActiveHeight 	 = Lerp( 0.05* _devSkew , self.ActiveHeight, self.OpenHeight);	
							
							if self.ActiveHeight >= self.OpenHeight-1 then
							
								self.AchievedHeight = true;
							
							end
							
						end
						
						if self.AchievedY && self.AchievedHeight && !self.AchievedWidth  then
												
							self.ActiveWidth	 = Lerp( 0.05* _devSkew, self.ActiveWidth, self.OpenWidth );			
						
							if self.ActiveWidth >= self.OpenWidth-1  then
							
								self.AchievedWidth = true;
								
							end
							
						end
						
						if self.ActiveXPos >= self.OpenXPos-1 then
							
							self.AchievedX = true;
							
						end						
						
						if self.AchievedX && self.ActiveYPos >= self.OpenYPos -1 then
							
							self.AchievedY = true;
							
						end
						
						if self.AchievedHeight && self.AchievedX && self.AchievedY && self.AchievedWidth then
						
							self.DoStartingAnimation = false;
							self.IsReadyForPrograms = true;
							hook.Run( "StartMenuAnimationFinished", self )
							
						end
						
					elseif self.DoEndingAnimation == true then
					
						if self.ProgramTileTable && !self.SetClosingProgramAlpha then
						
							for x, y in pairs( self.ProgramTileTable ) do
							
								y.DoClosingAlpha = true;
								
							end
							
							self.SetClosingProgramAlpha = true;
							
						end
						
						self.ActiveYPos	 	 = Lerp( 0.01* _devSkew , self.ActiveYPos,  self.ClosedYPos );
						self.ActiveXPos	 	 = Lerp( 0.01* _devSkew , self.ActiveXPos,  self.ClosedXPos );
																	
						if !self.AchievedHeight then
						
							self.ActiveHeight 	 = Lerp( 0.01* _devSkew , self.ActiveHeight, self.ClosedHeight);	
							
							if self.ActiveHeight >= self.ClosedHeight-1 then
							
								self.AchievedHeight = true;
							
							end
							
						end
						
						if !self.AchievedWidth  then
												
							self.ActiveWidth	 = Lerp( 0.01* _devSkew, self.ActiveWidth, self.ClosedWidth );			
						
							if self.ActiveWidth >= self.ClosedWidth-1  then
							
								self.AchievedWidth = true;
								
							end
							
						end
						
						if self.ActiveYPos >= self.ClosedYPos-1 then
							
							self.AchievedY = true;
							
						end						
						
						if self.AchievedY && self.ActiveXPos >= self.ClosedXPos -1 then
							
							self.AchievedX = true;
							
						end
						self.NoAlpha = Lerp( 0.01* _devSkew , self.Alpha , 255 )
						
						if self.AchievedHeight && self.AchievedX && self.AchievedY && self.AchievedWidth then
						
							self.Alpha = Lerp( 0.025 * _devSkew , self.Alpha , 0 )
							
							if self.NoAlpha <= 128 then
							
								self.NoAlpha = self.Alpha 
								
							end
							
							if self.Alpha <= 1 then
							
								hook.Run( "StartMenuEndAnimationFinished" )
								self.AccessButton.StartMenu = nil;
								self:Remove();
							
							end
							
						end
					
					end
					surface.DrawRect( StartMenu.ActiveXPos ,StartMenu.ActiveYPos ,w + StartMenu.ActiveWidth,h+ StartMenu.ActiveHeight )
				
				end 
				
				hook.Add( "StartMenuAnimationFinished", "MakeStartMenuProgramScrollListHook", function( StartMenu ) 

					StartMenu:MakeStartMenuProgramScrollList( )
					
					
				end )
						
				StartMenu.ProgramTileTable = {};
				
				function StartMenu:MakeStartMenuProgramScrollList( )
					
					if self.ProgramScrollPanel then
					
						self.ProgramScrollPanel:Remove()
						
					end
					
					self.ProgramTileTable = {};
					
					local ScrollPanel = vgui.Create( "DScrollPanel" , self )
					ScrollPanel:SetPos( _wMod * 5 , _hMod * 5 )
					ScrollPanel:SetSize( StartMenuX *0.5 - _wMod * 10 , StartMenuY - _hMod * 10 )
					ScrollPanel.Desktop = self.Desktop
					
					for i = 1 , #ScrollPanel.Desktop.Programs do
						
						timer.Simple( i * 0.1 , function()
							if !self then return end
							if !ScrollPanel then return end
							if !ScrollPanel.Desktop then return end
							if !ScrollPanel.Desktop.Programs then return end
							//if i == 1 && LocalPlayer():SteamID() != ScrollPanel.Desktop.Entity:getFlag("ownedBy","") then return end
							//if i == 5 && LocalPlayer():SteamID() != ScrollPanel.Desktop.Entity:getFlag("ownedBy","") then return end
							
							//if i == 7 && LocalPlayer():SteamID() == ScrollPanel.Desktop.Entity:getFlag("ownedBy","")  then return end // if you own the pc dont show
			
							if ScrollPanel.Desktop.Entity:getFlag("propertyDisplayProp",false) == true && LocalPlayer():SteamID() != ScrollPanel.Desktop.Entity:getFlag("ownedBy","")  then 

								if i != 7 then return end
								
							end

							if LocalPlayer():SteamID() == ScrollPanel.Desktop.Entity:getFlag("ownedBy",nil) then
								
								if i == 7 then return end
								
							end

							if ScrollPanel.Desktop.Entity:getFlag("propertyDisplayProp",false) != true then

								if i == 7 then return end
								
							end
							
							//if i == 7 && ScrollPanel.Desktop.Entity:getFlag("propertyDisplayProp",false) != true then return end// dont show if this isnt the club pc
				
							
							if LocalPlayer():SteamID() != ScrollPanel.Desktop.Entity:getFlag("ownedBy",nil) then
								
								if i == 8 then return end
								
							end
							//if i != 7 && ScrollPanel.Desktop.Entity:getFlag("propertyDisplayProp",false) == true then return end // if this is the club pc
							//if i == 8 && LocalPlayer():SteamID() != ScrollPanel.Desktop.Entity:getFlag("ownedBy","") then return end// if you dont own the pc dont show
							
							local ProgramTile = ScrollPanel:Add( "DButton" )
							ProgramTile:DockMargin( 0 ,_hMod * 5 , 0 ,0 )
							ProgramTile:SetSize( _wMod * 100 , _hMod * 100 )
							ProgramTile:Dock( TOP )
							ProgramTile:SetText("");
							ProgramTile.StartMenu = self;
							ProgramTile.Alpha = 0 ;
							ProgramTile.ID = i;
							ProgramTile.ProgramName = ScrollPanel.Desktop.Programs[i].Name;
							ProgramTile.DoClosingAlpha = false;
							
							function ProgramTile:OnMousePressed( k )
							
								if self.StartMenu.IsReadyForPrograms == true then
									
									self.StartMenu.DoEndingAnimation = true;
									
									self.StartMenu.Desktop:StartProgram( self.ID )						
								
								end
								
							end 
							
							function ProgramTile:Paint( w, h )
								
								if self.DoClosingAlpha == true then
										
									self.Alpha = Lerp( 0.1 , self.Alpha , 0 )
									//_p:Notify( self.Alpha )
									if self.Alpha <= 1 then
									
										self.StartMenu.ProgramScrollPanel:Remove()
									end
								else
								
									self.Alpha = Lerp( 0.1 , self.Alpha , 255 )								
								
								end
								if i % 2 == 0 then
								
									surface.SetDrawColor( 145, 255 ,169 , self.Alpha )
								
								surface.DrawRect(0,0,w,h)
								
									surface.SetDrawColor( 255, 211 ,93 , self.Alpha  )
								
								else
																
									surface.SetDrawColor( 255, 211 ,93 , self.Alpha  )
									
								surface.DrawRect(0,0,w,h)
								
									surface.SetDrawColor( 145, 255 ,169 , self.Alpha )
									
								end
								
								if self:IsHovered() then
								
									surface.DrawOutlinedRect( _wMod * 5, _hMod * 5, w- _wMod * 10,h - _hMod * 10)
								
								else
								
									surface.DrawRect( _wMod * 5, _hMod * 5, w- _wMod * 10,h - _hMod * 10)
								
								end
								
								draw.SimpleText( self.ProgramName, "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 ,self.StartMenu.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
							end
							
							table.insert( self.ProgramTileTable, ProgramTile )
								
						end)					
						
					 
						
					end
					
				self.ProgramScrollPanel = ScrollPanel
						
			end
					
					
		StartMenu.AccessButton = self
					
		return StartMenu;						
							
	end
							
		self.StartMenuButton = StartMenuButton;
			
	end
			
		TaskBar:MakeStartMenuButton()
			
		self.TaskBar = TaskBar;
			
	end
		
	Desktop.StartupDone = false;

	function Desktop:Paint( w , h )
	
		if !self.Intro && !self.FinishedIntro then
			
			self.ActiveColor = lerpColor( 0.1 * _devSkew , self.ActiveColor, self.IntroColor )
			self.Alpha = Lerp( 0.5, self.Alpha , 255 )
			
			if self.Alpha >= 254 then
			
				self.Intro = true;
				
				//_p:ChatPrint("Doing Intro")
							
			end
		
		elseif self.Intro && !self.FinishedIntro then
			
			if !self.IntroText then
			
				self.IntroTextAlpha = Lerp( 0.1, self.IntroTextAlpha , 255 )
				
				if self.IntroTextAlpha >= 254 then
														
					self.IntroText = true;
								
				end					
			
			else
			
				self.IntroTextAlpha = Lerp( 0.1, self.IntroTextAlpha , 0 )				
				
				if self.IntroTextAlpha < 1 then
										
					//_p:ChatPrint("startup done")
					self.Startup = true;					
					self.FinishedIntro = true;
					
				end
				
			
			
			end
		end
		
		surface.SetDrawColor( self.ActiveColor )
		
		surface.DrawRect( 0 , 0 , w , h )
		
		if self.Intro then
			
			draw.SimpleText( "Your desktop " .. rpcomputer.helper.GetName( _p ) , "Trebuchet20" , w*0.5, _hMod * 50, Color( 255 ,255 ,255 , self.IntroTextAlpha ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
			
		end
		
		if self.Startup then
		
			
			self.Startup = false;
			self.StartupDone = true;
			
			
				
			
			
		end
		
	end
	
	Desktop.BroughTaskbarUp = false;

	function Desktop:Think()

		if !self.BroughTaskbarUp && self.StartupDone == true then
		
			self:MakeComputerTaskbar()
			self.BroughTaskbarUp = true;
		
		end
		
	end
	
	LocalPlayer().ComputerDesktop = Desktop
	
	return Desktop 
end

local function ShowComputer( _computerIndex , _monitorIndex )

	local _p = LocalPlayer();
	local _computerEnt = ents.GetByIndex( _computerIndex )
	local _monitorEnt = ents.GetByIndex( _monitorIndex )
	
	if _computerEnt:GetClass() != "fsrpcomputer" then
	
		return rpcomputer.helper.MessagePlayer( _p , "Not accessing a true computer, aborting." )
		
	end
	
	local _computerSpecs = _computerEnt:getFlag("computerSpecifications", _computerEnt.Specifications );
	
	//rpcomputer.helper.MessagePlayer( _p , "Starting Computer" )
	//computer = true;
	MakeComputerDesktop( _computerEnt )
	
end

net.Receive( "fsrpSendComputer" , function ( _l , _p )
	
	local _computerIndex = net.ReadInt( 16 )
	local _monitorIndex = net.ReadInt( 16 )
	
	ShowComputer( _computerIndex , _monitorIndex )
	
end ) 