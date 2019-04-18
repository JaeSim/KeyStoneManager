local addonName, KeyStoneManager = ...;

chatflag = 0

function createsButton()
	--Button--
	buttonSizeX = 60
	buttonSizeY = 20
	updateButton = CreateFrame("Button", "updateButton", uiFrame, "GameMenuButtonTemplate")
	updateButton:SetText("Update")
	updateButton:SetSize(buttonSizeX, buttonSizeY)
	updateButton:SetPoint("TOP", -30 , -5) 
	updateButton:SetScript("OnClick", KeyStoneManager.OnClick_UpdateButton) 

	chatButton = CreateFrame("Button", "chatButton", uiFrame, "GameMenuButtonTemplate")
	chatButton:SetText("Chat")
	chatButton:SetSize(buttonSizeX, buttonSizeY)
	chatButton:SetPoint("TOP", 30, -5) 
	chatButton:SetScript("OnClick", toggleChatFrame) 
	
	clearButton = CreateFrame("Button", "clearButton", uiFrame, "GameMenuButtonTemplate")
	clearButton:SetText("Clear")
	clearButton:SetSize(buttonSizeX, buttonSizeY)
	clearButton:SetPoint("BOTTOM", 0, 5) 
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
	
	if chatflag == 1 then
		createChatFrame()
	end
end

function toggleChatFrame()
    chatflag = 1 - chatflag
	if chatflag == 1 then 
		createChatFrame()
	elseif chatflag == 0 then
		chatFrame:Hide()
	end
end

function createChatFrame()
	chatFrame = CreateFrame("Frame", "chatFrame", chatButton)
	
	chatFrame:SetSize(100, 150)
	
	chatFrame:SetPoint("BOTTOMLEFT", 20, 5)
	chatFrame:SetBackdrop( {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = true,
		tilesize = 5,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 10,
		insets = { left = 4, right = 3, top = 4, bottom = 3}
		} )
	chatFrame:SetBackdropColor(0.2,0.2,0.2,0.7)
	
	cancelButton = CreateFrame("Button", "cancelButton", chatFrame, "GameMenuButtonTemplate")
	cancelButton:SetText("CANCEL")
	cancelButton:SetSize(80, 20)
	cancelButton:SetPoint("BOTTOM", 0, 5) 
	cancelButton:SetScript("OnClick", toggleChatFrame) 
	
	local strarray = { "일반", "파티" , "인스" ,"길드" }
	local chattypearry = { "SAY", "PARTY", "RAID", "GUILD" }
	local chatbuttons = {}
	
	
	for i =1 , 4, 1 do
		sayButton = CreateFrame("Button", "sayButton", chatFrame, "GameMenuButtonTemplate")
		local displaytext = "["..i.."] "..strarray[i]
		local info = ChatTypeInfo[chattypearry[i]]
		displaytext = format("|cff%02x%02x%02x%s|r", info.r*255, info.g*255, info.b*255, displaytext)
		sayButton:SetText(displaytext)
		sayButton:SetSize(80, 20)
		local ypos = 20 + (i * -25)
		sayButton:SetPoint("TOP", 0, ypos) 
		sayButton:SetScript("OnClick", function() 
		    KeyStoneManager.OnClick_ChatButton(chattypearry[i]) 
			toggleChatFrame()
		end)	
		sayButton:SetNormalTexture("Interface\\Common\\dark-goldframe-button")
		chatButton[i] = sayButton
	end	
end