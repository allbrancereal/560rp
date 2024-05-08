

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

function ShowBusinessInvestingPanel( BusinessID )

	local _p = LocalPlayer();
	//if !_p:getFlag("organization",nil) then return _p:Notify( "You must join an organization to view it's members!" ) end
	local businessCachedInformation = fsrp.business.cache[BusinessID];
	local businessInformation = fsrp.business.config.Companies[BusinessID];

	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( _wMod * 500 , _hMod * 600 )
	Frame:ShowCloseButton( false )
	Frame:Center()
	Frame:MakePopup()
	Frame:SetTitle("")
	
	function Frame:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false)
		LocalPlayer().OrgMenu = nil
		
	end 
	
	Frame.Alpha = 0;
	Frame.Alpha2 = 0;
	Frame.DoBeginning = true;
	Frame.FinBeginning = false;
	Frame.DoBeginning2 = false;
	
	function Frame:Paint( w , h )
	
		if self.DoBeginning && !self.FinBeginning then
		
			self.Alpha = Lerp( 0.1 , self.Alpha , 255 ) 
			
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
			
			if self.Alpha2 > 254 then
			
				self.DoBeginning2 = false;
			
			end
			
		end
		
		surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
		surface.DrawRect( 0,0, w , h )
		
		//surface.SetDrawColor( 140, 138,255, self.Alpha2 ) 
		//surface.DrawRect( _wMod * 10, _hMod * 10, w  - _wMod * 20, h - _hMod * 20 )
		
	end
	

	// Exit Button
	local ExitBut = vgui.Create( "DButton" , Frame )
	ExitBut:SetSize( _wMod * 125 , _hMod * 50 )
	ExitBut:SetPos( Frame:GetWide() - (_wMod* 15 + ExitBut:GetWide()) , Frame:GetTall() - ( _hMod * 15 +  ExitBut:GetTall() ) )
	ExitBut:SetText("")
	ExitBut.NormalCol =Color(255,255,255,Frame.Alpha2 * 0.8)
	ExitBut.SelectCol = Color( 120,120,120,Frame.Alpha2 * 0.8 )
	ExitBut.HoveredCol = Color( 185, 185 ,185 , Frame.Alpha2 * 0.8 )
	ExitBut.ActiveCol = Color(0,0,0,0)
	function ExitBut:DoClick( )

		Frame:Close()

	end

	function ExitBut:Paint( w , h )
		if self:IsHovered() && !self:IsDown() then

			self.ActiveCol = lerpColor( 0.05, self.ActiveCol , self.HoveredCol )

		elseif self:IsDown() then

			self.ActiveCol = lerpColor( 0.05, self.ActiveCol , self.SelectCol )

		else

			self.ActiveCol = lerpColor( 0.05, self.ActiveCol , self.NormalCol )

		end

		surface.SetDrawColor( Color(self.ActiveCol["r"],self.ActiveCol["g"],self.ActiveCol["b"], Frame.Alpha2 ) )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Exit", "Trebuchet24", w/2 , h/2, Color(0,0,0, Frame.Alpha2 * 0.8 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end

	// Investing Button
	local InvestBut = vgui.Create( "DButton" , Frame )
	InvestBut:SetSize( _wMod * 330 , _hMod*50 )
	InvestBut:SetPos( _wMod * 15 , Frame:GetTall() - ( _hMod * 15 +  InvestBut:GetTall() ) )
	InvestBut:SetText("")
	InvestBut.NormalCol =Color(255,255,255,Frame.Alpha2 * 0.8)
	InvestBut.SelectCol = Color( 120,120,120,Frame.Alpha2 * 0.8 )
	InvestBut.HoveredCol = Color( 185, 185 ,185 , Frame.Alpha2 * 0.8 )
	InvestBut.ActiveCol = Color(0,0,0,0)
	function InvestBut:DoClick( )

		Frame:Close()

	end
	function InvestBut:Paint( w , h )
		

		if self:IsHovered() && !self:IsDown() then

			self.ActiveCol = lerpColor( 0.05, self.ActiveCol , self.HoveredCol )
			
		elseif self:IsDown() then

			self.ActiveCol = lerpColor( 0.05, self.ActiveCol , self.SelectCol )

		else

			self.ActiveCol = lerpColor( 0.05, self.ActiveCol , self.NormalCol )

		end

		surface.SetDrawColor( Color(self.ActiveCol["r"],self.ActiveCol["g"],self.ActiveCol["b"], Frame.Alpha2 ) )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Invest", "Trebuchet24", w/2 , h/2, Color(25,25,25, Frame.Alpha2 * 0.8 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	
	local Panel = vgui.Create( "DPanel" , Frame )
	Panel:SetPos( _wMod * 15 , _hMod * 15 )
	Panel:SetSize( Frame:GetWide() - _wMod * 30, Frame:GetTall() - (InvestBut:GetTall() + _hMod * 45 ) )
	function Panel:Paint( w , h )
	
		surface.SetDrawColor( 58,5,94 ,Frame.Alpha2 * 0.8 )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( businessInformation.Name, "Trebuchet24", w/2 ,  _hMod *20, Color(255,255,255, Frame.Alpha2 * 0.8 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		surface.SetDrawColor(255,255,255,Frame.Alpha2*0.8)
		surface.DrawLine( _wMod * 10 , _hMod * 40 , (w - _wMod * 10) , _hMod * 40 )
		//print(businessIndex)
	end

	//fsrp.business.functions.IsShareholder( _p , id )
	//print( fsrp.business.functions.IsShareholder( LocalPlayer() , "airport") )
	return Frame

end
