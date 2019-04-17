local addonName, KeyStoneManager = ...;

function createsButton()
	--Button--
	buttonSizeX = 60
	buttonSizeY = 20
	updateButton = CreateFrame("Button", "updateButton", uiFrame, "GameMenuButtonTemplate")
	updateButton:SetText("Update")
	updateButton:SetSize(buttonSizeX, buttonSizeY)
	updateButton:SetPoint("TOP", 0 - buttonSizeX - 5 , -5) 
	updateButton:SetScript("OnClick", KeyStoneManager.OnClick_UpdateButton) 

	chatButton = CreateFrame("Button", "chatButton", uiFrame, "GameMenuButtonTemplate")
	chatButton:SetText("Chat")
	chatButton:SetSize(buttonSizeX, buttonSizeY)
	chatButton:SetPoint("TOP", 0, -5) 
	chatButton:SetScript("OnClick", KeyStoneManager.OnClick_ChatButton) 
	
	clearButton = CreateFrame("Button", "clearButton", uiFrame, "GameMenuButtonTemplate")
	clearButton:SetText("Clear")
	clearButton:SetSize(buttonSizeX, buttonSizeY)
	clearButton:SetPoint("TOP", 0 + buttonSizeX + 5, -5) 
	clearButton:SetScript("OnClick", KeyStoneManager.clearc) 
	
	closeButton = CreateFrame("Button", "closeButton", uiFrame, "UIPanelCloseButton")
	closeButton:SetText("X")
	closeButton:SetSize(30, 30)
	closeButton:SetPoint("TOPRIGHT", 0,0) 
	closeButton:SetScript("OnClick", toggleUI) 
	
	-- lable button
	local commonPosy = -25
	local buttonArray = {}
	nameButton = CreateFrame("Button", "nameButton", uiFrame, "UIPanelButtonGrayTemplate")
	nameButton:SetText("이름")
	nameButton:SetSize(30, 20)
	nameButton:SetPoint("TOPLEFT", 10 ,commonPosy) 
	nameButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 1 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 1
		reDrawUI()
		print(ksmDb.config.clickedButtonToggle)
	end) 
	buttonArray[1] = nameButton
	
	itemLevelButton = CreateFrame("Button", "itemLevelButton", uiFrame, "UIPanelButtonGrayTemplate")
	itemLevelButton:SetText("템렙")
	itemLevelButton:SetSize(30, 20)
	itemLevelButton:SetPoint("TOPLEFT", 10 + 80,commonPosy) 
	itemLevelButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 2 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 2
		reDrawUI()
	end) 
	buttonArray[2] = itemLevelButton
	
	dgnameButton = CreateFrame("Button", "dgnameButton", uiFrame, "UIPanelButtonGrayTemplate")
	dgnameButton:SetText("던전")
	dgnameButton:SetSize(30, 20)
	dgnameButton:SetPoint("TOPLEFT", 10 + 80 + 40,commonPosy) 
	dgnameButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 3 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 3
		reDrawUI()
	end) 
	buttonArray[3] = dgnameButton
	
	dglevelButton = CreateFrame("Button", "dglevelButton", uiFrame, "UIPanelButtonGrayTemplate")
	dglevelButton:SetText("단수")
	dglevelButton:SetSize(30, 20)
	dglevelButton:SetPoint("TOPLEFT", 10 + 80 + 40 + 40,commonPosy) 
	dglevelButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 4 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 4
		reDrawUI()
	end) 
	buttonArray[4] = dglevelButton
		
	parkLevelButton = CreateFrame("Button", "parkLevelButton", uiFrame, "UIPanelButtonGrayTemplate")
	parkLevelButton:SetText("주차")
	parkLevelButton:SetSize(30, 20)
	parkLevelButton:SetPoint("TOPLEFT", 10 + 80 + 40 + 40 + 40,commonPosy) 
	parkLevelButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 5 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 5
		reDrawUI()
	end) 
	buttonArray[5] = parkLevelButton
	
	--clicked button
	buttonArray[ksmDb.config.clickedButton]:SetBackdrop( {
		bgFile = [[Interface\Common\dark-goldframe-button]],
		insets = { left = 0, right = 0, top = 0, bottom = 0}
	})
	
	buttonArray[ksmDb.config.clickedButton]:SetNormalTexture(nil)
	
end