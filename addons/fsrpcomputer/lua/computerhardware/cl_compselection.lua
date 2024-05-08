

net.Receive( "fsrpRPComputerSelection" , function( _l , _p )

	local _isNearEnt = net.ReadBool();
	local _isMonitor = net.ReadBool();
	local _usedEntity = net.ReadInt( 16 ) 
	local _otherEnt = nil
	if _isNearEnt then
	
		_otherEnt = net.ReadInt( 16 ) 
	
	end
	
	ShowComputerSelection( _isNearEnt , _isMonitor, _usedEntity, _otherEnt  )
	
end )


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;


function ShowComputerSelection( allowComputer , isMonitor, _usedEntity, _otherEnt )


					if _otherEnt == nil then return LocalPlayer():Notify("You need to have a monitor close by to use this.") end
					

				net.Start( "fsrpuseComputer" )
					net.WriteInt( _usedEntity ,16 )
					net.WriteInt( _otherEnt ,16 )
				net.SendToServer( )

				return end
				/*
	
	local MainPanel = vgui.Create( "DFrame" )
	local _entInUse = ents.GetByIndex( _usedEntity );
	local _p = LocalPlayer()
	local _activateComputerButton = vgui.Create( "DButton" , MainPanel )
	
	_otherEntInCall = nil;
	if _otherEnt != nil then
	
		_otherEntInCall = ents.GetByIndex( _otherEnt );
	
	end
	
	if !_otherEntInCall then
	
		_p:Notify( "You need another peripheral to use this.")
	
	end
	
	MainPanel:SetSize( _wMod * 420 , _hMod * 250 )
	MainPanel:Center()
	MainPanel:MakePopup()
	
	
	MainPanel:SetTitle( "Computer Hardware Menu" )
	MainPanel:ShowCloseButton( true )
	MainPanel.Alpha = 0;
	
	function MainPanel:Paint( w,  h )
		
		if self.Alpha != 255 then
		
			self.Alpha = Lerp( 0.05, self.Alpha , 255 )
			
		end
		
		surface.SetDrawColor( 56, 56 , 56 , self.Alpha * 0.5 )
		surface.DrawRect( 0,0,w, h)
	
	end
	
	local ToggleSystemButton = vgui.Create( "DButton" , MainPanel )
	ToggleSystemButton:SetSize( MainPanel:GetWide()*0.5 - _wMod * 20, _hMod * 125 )
	ToggleSystemButton:SetPos( _wMod * 10 , _hMod * 30 )
	ToggleSystemButton:SetText( "" )
	function ToggleSystemButton:Paint( w,  h )
	
		if !_entInUse:IsOn() then
		
			surface.SetDrawColor( 255, 0, 0 ,  MainPanel.Alpha * 0.5 )
			
		else
		
			surface.SetDrawColor( 0, 255 , 0 ,  MainPanel.Alpha * 0.5 )
			
		end
		
		surface.DrawRect( 0, 0 , w , h )
		local _IsOnTxt = _entInUse:IsOn() && "Online:" || "Offline:";
		local _offMsg = isMonitor && " Monitor" || " Computer";		
		draw.SimpleText( _IsOnTxt .. _offMsg   , "Trebuchet24" , w*0.5, h*0.5, Color( 255 ,255 ,255 ,MainPanel.Alpha ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		
	end
	function ToggleSystemButton:OnMousePressed( key )
		
		net.Start("toggleSystemActivity")
			net.WriteInt( _usedEntity , 16 )
		net.SendToServer( )
		
		
	end
	
	local ToggleOtherSystem = vgui.Create( "DButton" , MainPanel )
	ToggleOtherSystem:SetSize( MainPanel:GetWide() * 0.5 - _wMod * 20, _hMod * 125 )
	ToggleOtherSystem:SetPos( MainPanel:GetWide() * 0.5 + _wMod * 10, _hMod * 30 )
	ToggleOtherSystem:SetText( "" )
	if !allowComputer then
	
		ToggleOtherSystem:SetEnabled( false )
	
	end
	
	function ToggleOtherSystem:Paint( w,  h )
	
		if _otherEntInCall && !_otherEntInCall:IsOn() && allowComputer then
		
			surface.SetDrawColor( 255, 0, 0 ,  MainPanel.Alpha * 0.5 )
			
		elseif allowComputer && self:IsEnabled() then
		
			surface.SetDrawColor( 0, 255 , 0 ,  MainPanel.Alpha * 0.5 )
			
		elseif !allowComputer then 
		
			surface.SetDrawColor( 128, 128, 128, MainPanel.Alpha * 0.5 )
			
		end
	
		surface.DrawRect( 0, 0 , w , h )
		
		if _otherEntInCall then
			
			local _IsOnTxt =  _otherEntInCall && _otherEntInCall:IsOn() && "Online:" || "Offline:";
			local _offMsg = ( _otherEntInCall && _otherEntInCall:GetClass() == "fsrpcomputer" ) && " Computer" || " Monitor";		
			
			
			draw.SimpleText( _IsOnTxt .. _offMsg   , "Trebuchet24" , w*0.5, h*0.5, Color( 255 ,255 ,255 ,MainPanel.Alpha ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		
		else
			
			
			local _IsOnTxt =  "Unavailable:"
			local _offMsg = ( _entInUse:GetClass() != "fsrpcomputer" ) && " Computer" || " Monitor";		
			
			draw.SimpleText( _IsOnTxt .. _offMsg   , "Trebuchet24" , w*0.5, h*0.5, Color( 255 ,255 ,255 ,MainPanel.Alpha ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		
		
		end
		
	end
	
	function ToggleOtherSystem:OnMousePressed( key )
		
		if !allowComputer then return rpcomputer.helper.MessagePlayer( _p , "You haven't got the other peripheral to your computer" ) end
		
		net.Start("toggleSystemActivity")
			net.WriteInt( _otherEnt , 16 )
		net.SendToServer( )
			
				
	
	end
	
	if _otherEntInCall then
	
		if allowComputer then
			_activateComputerButton:SetVisible( true )
			_activateComputerButton:SetSize( MainPanel:GetWide() - _wMod * 30 , _hMod * 50 )
			_activateComputerButton:SetPos( _wMod * 15 , _hMod * 165 )
			_activateComputerButton:SetEnabled( (_otherEntInCall:IsOn() && _entInUse:IsOn()) ) 
			_activateComputerButton:SetEnabled( false )		
			_activateComputerButton:SetText( "" )			
			function _activateComputerButton:Paint( w,  h )
			
				if self:IsEnabled() then
			
					surface.SetDrawColor( 0, 255 , 0 ,  MainPanel.Alpha * 0.5 )
					
				else
				
					surface.SetDrawColor( 255, 0, 0, MainPanel.Alpha * 0.5 )
					
				end
			
				surface.DrawRect( 0, 0 , w , h )
				
				surface.SetDrawColor( 255 ,255 ,255 , MainPanel.Alpha );
				draw.SimpleText( "Access your Computer"   , "Trebuchet24" , w*0.5, h*0.5, Color( 255 ,255 ,255 ,MainPanel.Alpha ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

			end
			//( _usedEntity , _otherEnt )
			
			function _activateComputerButton:Think()
						
				if ents.GetByIndex( _otherEnt ):IsOn() &&  ents.GetByIndex( _usedEntity ):IsOn() then
						
					_activateComputerButton:SetEnabled( true )
					
				else
					
					_activateComputerButton:SetEnabled( false )		
						
					
				end
			
			end
			
			function _activateComputerButton:OnMousePressed( key )
				
				net.Start( "fsrpuseComputer" )
					net.WriteInt( _usedEntity ,16 )
					net.WriteInt( _otherEnt ,16 )
				net.SendToServer( )
				MainPanel:Close()
			end 
		
		end
		
	else
		
		_activateComputerButton:SetVisible( false ) 
		
	end
	
end

*/