ESX = nil

Citizen.CreateThread(function()
	TriggerServerEvent('boutique:getpoints')
	if pointjoueur == nil then pointjoueur = 0 end
	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end
end)

local menuColor = {4, 20, 111}
Citizen.CreateThread(function()
    Wait(1000)
    menuColor[1] = GetResourceKvpInt("menuR")
    menuColor[1] = GetResourceKvpInt("menuG")
    menuColor[1] = GetResourceKvpInt("menuB")
    ReloadColor()
end)

local AllMenuToChange = nil
function ReloadColor()
    Citizen.CreateThread(function()
        if AllMenuToChange == nil then
            AllMenuToChange = {}
            for Name, Menu in pairs(RMenu['boutique']) do
                if Menu.Menu.Sprite.Dictionary == "commonmenu" then
                    table.insert(AllMenuToChange, Name)
                end
            end
        end
        for k,v in pairs(AllMenuToChange) do
            RMenu:Get('boutique', v):SetRectangleBanner(9, 24, 118)
        end
    end)
end

RMenu.Add('boutique', 'main', RageUI.CreateMenu("Menu Playeurs", "Menu jouers"))
RMenu.Add('boutique', 'vehiclemenu', RageUI.CreateSubMenu(RMenu:Get('boutique', 'main'), "Menu Playeurs", "Menu de Touche"))
RMenu.Add('boutique', 'armesmenu', RageUI.CreateSubMenu(RMenu:Get('boutique', 'main'), "Menu Playeurs", "Menu d'information"))
RMenu.Add('boutique', 'moneymenu', RageUI.CreateSubMenu(RMenu:Get('boutique', 'main'), "Touche", "Menu de money"))

Citizen.CreateThread(function()
    while true do
		RageUI.IsVisible(RMenu:Get('boutique', 'main'), true, true, true, function()

            RageUI.Separator("~r~createur TheZerox#3947", nil, {}, true, function(_, _, _) end)
                RageUI.Separator("Voice ton ~r~ID~s~ : ~r~" ..GetPlayerServerId(PlayerId()))
                
				RageUI.ButtonWithStyle("Touche", "Menu de Touche", { RightLabel = "→" },true, function() 
				end, RMenu:Get('boutique', 'vehiclemenu'))

				RageUI.ButtonWithStyle("Informations", "Menu d'information", { RightLabel = "→" },true, function() 
				end, RMenu:Get('boutique', 'armesmenu'))

				RageUI.ButtonWithStyle("Money", "Menu de money", { RightLabel = "→" },true, function() 
				end, RMenu:Get('boutique', 'moneymenu'))
				end)

-------------------------------------------------------------------------- Véhicules
		
        RageUI.IsVisible(RMenu:Get('boutique', 'vehiclemenu'), true, true, true, function()
            
            RageUI.Separator("~h~Voie", nil, {}, true, function(_, _, _) end)
			RageUI.ButtonWithStyle("Radio", nil, { RightLabel = "~r~SHIFT + F1" }, true,function(h,a,s)
				if a then
					--RenderSprite("RageUI", "rt70", 0, 565, 535, 290, 100)
				end
            end) 

			RageUI.ButtonWithStyle("Telephone", nil, { RightLabel = "~r~G" }, true,function(h,a,s)
				if a then
					--RenderSprite("RageUI", "rt70", 0, 565, 535, 290, 100)
				end
            end) 

            RageUI.Separator("~h~General", nil, {}, true, function(_, _, _) end)
            RageUI.ButtonWithStyle("MenuF5", nil, { RightLabel = "~r~F5" }, true,function(h,a,s)
				if a then
					--RenderSprite("RageUI", "rt70", 0, 565, 535, 290, 100)
				end
            end) 

            RageUI.ButtonWithStyle("Menu Animation", nil, { RightLabel = "~r~F3 ou =" }, true,function(h,a,s)
				if a then
                end
            end)

            RageUI.Separator("~h~Voiture", nil, {}, true, function(_, _, _) end)
            RageUI.ButtonWithStyle("clignotent", nil, { RightLabel = "~r~Fleche de Gauche ou de Droite" }, true,function(h,a,s)
				if a then
					--RenderSprite("RageUI", "rt70", 0, 565, 535, 290, 100)
				end
            end) 

            RageUI.ButtonWithStyle("Ceinture", nil, { RightLabel = "~r~K" }, true,function(h,a,s)
				if a then
					--RenderSprite("RageUI", "rt70", 0, 565, 535, 290, 100)
				end
            end) 
end)



-------------------------------------------------------------------------- Armes


    RageUI.IsVisible(RMenu:Get('boutique', 'armesmenu'), true, true, true, function()

        RageUI.Separator("~r~Create by TheZerox", nil, {}, true, function(_, _, _) end)
		RageUI.ButtonWithStyle("Discord de dev fivem", nil, { RightLabel = "~r~https://discord.gg/4fG49VfJ8b " }, true,function(h,a,s)
			if a then
				--RenderSprite("RageUI", "Screenshot_127", 0, 565, 535, 290, 100)
            end
        end) 

        RageUI.ButtonWithStyle("Discord du Serveur", nil, { RightLabel = "~r~https://discord.gg/a changer" }, true,function(h,a,s)
			if a then
				--RenderSprite("RageUI", "Screenshot_127", 0, 565, 535, 290, 100)
            end
        end) 

end)

-------------------------------------------------------------------------- Argent

        RageUI.IsVisible(RMenu:Get('boutique', 'moneymenu'), true, true, true, function()
        

			for k, itemmoy in pairs(itemmoney) do
                RageUI.ButtonWithStyle(itemmoy.name, itemmoy.desc, {RightLabel = "~r~"..tostring(itemmoy.point).." ~b~"}, true, function(Hovered, Active, Selected)
					if (Selected) then

						curentvehicle_name = itemmoy.name
						curentvehicle_model = itemmoy.model
						curentvehicle_point = itemmoy.point
						curentvehicle_finalpoint = itemmoy.point

						if pointjoueur >= curentvehicle_finalpoint then
							buying(curentvehicle_finalpoint)
							gmoney(curentvehicle_model, curentvehicle_name)
						else 
							TriggerEvent('esx:showNotification', '~r~Vous n\'avez pas assez de fond pour acheter ceci !')
						end
					end
				end)
			end
		end)
		
        Citizen.Wait(0)
    end
end)

--------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustPressed(0, 83) then
			TriggerServerEvent('boutique:getpoints')
			RageUI.Visible(RMenu:Get('boutique', 'main'), not RageUI.Visible(RMenu:Get('boutique', 'main')))
		end -- Touche F1
	end
end)
