local addonName, LiteKeyStoneManager = ...;

local PlayerName = GetUnitName("player")
local localizedClass, englishClass, classIndex = UnitClass("player")
local mythicApiFlag = true
local dgNames = {
	[244] = '아탈',
	[245] = '자유',
	[246] = '톨다',
	[247] = '왕노',
	[248] = '저택',
	[249] = '왕안',
	[250] = '세스',
	[251] = '썩굴',
	[252] = '폭사',
	[353] = '보랄',
	[369] = '고철',
	[370] = '작업',
};

function nodeSortByNameUp(a, b) return (a.name < b.name) end
function nodeSortByItemLevelUp(a, b) return (a.itemlevel < b.itemlevel) end
function nodeSortByDgNameUp(a, b) return (a.dgname < b.dgname) end
function nodeSortByDgLevelUp(a, b) return (a.dglevel < b.dglevel) end
function nodeSortByParkLevelUp(a, b) return (a.parkLevel < b.parkLevel) end

function nodeSortByNameDown(a, b) return (a.name > b.name) end
function nodeSortByItemLevelDown(a, b) return (a.itemlevel > b.itemlevel) end
function nodeSortByDgNameDown(a, b) return (a.dgname > b.dgname) end
function nodeSortByDgLevelDown(a, b) return (a.dglevel > b.dglevel) end
function nodeSortByParkLevelDown(a, b) return (a.parkLevel > b.parkLevel) end

local sortFunctions = { 
	nodeSortByNameUp,
	nodeSortByItemLevelUp,
	nodeSortByDgNameUp,
	nodeSortByDgLevelUp,
	nodeSortByParkLevelUp,
	nodeSortByNameDown,
	nodeSortByItemLevelDown,
	nodeSortByDgNameDown,
	nodeSortByDgLevelDown,
	nodeSortByParkLevelDown,
}

local defaultsDb = {
	node = {},
	config = {
	    uiPositionL = nil,
		uiPositionB = nil,
		clickedButton = 1,
		clickedButtonToggle = 0,
	}
};

function LiteKeyStoneManager:OnClick_UpdateButton(self)
	--SendChatMessage("한글","SAY") 
	C_MythicPlus.RequestRewards()
	--updateKeyStoneDb()
	--UpdateUI()
end

function LiteKeyStoneManager:OnClick_ChatButton(arg1)
	Node = LiteKeyStoneManager:GetSortedNode()
	local idx = 1
	for _, node in ipairs(Node) do
	    
        local strlen = string.len(node.name)
	    if not (isAlphaStr(node.name)) then 
		    -- Korean case
		    -- Korean case, it is 3 len per each character.
		    -- But, displayed lenght is below.
		    -- 1 English < 1 Korean char < 2 English . and it can be wrong by font style.
			strlen = (strlen / 3) * 2
		end
		local blankStr = ""
		for blank = strlen, 12 do
		    -- WOW system diplays string had many space as just 4 black.. So, i just set it as '-'
		    blankStr = blankStr .. "."    
		end
		
		local temp = format('%s%s%d %s %2d단....주차:%2d\n', node.name, blankStr, node.itemlevel, node.dgname, node.dglevel,node.parkLevel)

		-- It has timing issue. when it is called SendChatMessage without delay, The order of line is twisted.
		-- It seems that The order is changed by WOW's engine.
		C_Timer.After(0.20 * idx, function() SendChatMessage(temp,self) end)
		-- lua does not support i++ operation
		idx = idx + 1
		--print(temp)
	end
end

function LiteKeyStoneManager:clearc(self)
	keystone_table.node = {}
	keystone_table.config.clickedButton = 1
	keystone_table.clickedButtonToggle = 0,
	UpdateUI()
end

function initialize() 
	C_MythicPlus.RequestRewards()
end

local function OnEvent(self, event, msg, _, _, _, lootingUser)
	-- SendChatMessage("접속","SAY") 
    if (event =="PLAYER_LOGIN") then
		print("Enter World!")
		initialize()
		--updateKeyStoneDb()
	elseif event == "CHALLENGE_MODE_MAPS_UPDATE" then
	    -- below logic will be called when MythicPlus is finished.
	    updateKeyStoneDb()
    end
end


function updateKeyStoneDb()
	-- print("updateKeyStoneDb")
	FindCurrentKeystone()
	--https://www.wowinterface.com/forums/showthread.php?t=56454
	--for _, node in pairs(keystone_table.node) do
	--	print(format('%s %d  %s %2d단 주차- %2d', node.name, node.itemlevel, node.dgname, node.dglevel,
    --	                                          node.parkLevel))
	-- end
	UpdateUI()
end

MyAddonFrame = CreateFrame("Frame", nil, UIParent) 
MyAddonFrame:SetScript("OnEvent",OnEvent) 
MyAddonFrame:RegisterEvent("PLAYER_LOGIN")
MyAddonFrame:RegisterEvent("CHAT_MSG_LOOT")
MyAddonFrame:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE")
	
function FindCurrentKeystone()
	-- print("findkeystone")
    local itemID = 138019
    local BFAkey = 158923
    local exists = false

    if UnitLevel("player") == 120 then
		--print("player 120")
        for bag = 0, NUM_BAG_SLOTS do
            for slot = 0, GetContainerNumSlots(bag) do
                if(GetContainerItemID(bag, slot) == itemID or GetContainerItemID(bag, slot) == BFAkey) then                    					
                    exists = true
                    break 
                end
                if not exists then
                    -- clear
                end
            end   
			if exists then
				break
			end
        end
    end
	
	if exists then 
		local mapId = C_MythicPlus.GetOwnedKeystoneChallengeMapID();
		local level = C_MythicPlus.GetOwnedKeystoneLevel();
		local park,_,_,_ = C_MythicPlus.GetWeeklyChestRewardLevel();
		
		local overall, equipped = GetAverageItemLevel()
		if not keystone_table or type(keystone_table) ~= 'table' then 
			keystone_table = defaultsDb
		end
		--print(mapId)
		keystone_table.node[PlayerName] = {
			name = PlayerName,
			cl = englishClass,
			itemlevel = equipped,
			dgname = dgNames[mapId],
			dglevel = level,
			parkLevel = park
		}    
	end
end

function LiteKeyStoneManager:GetSortedNode() 
	sortedNode = {}
	for k , v in pairs(keystone_table.node) do
		v.name = k --Store the key in an entry called "name"
		table.insert(sortedNode, v)
	end	
	
	-- lua does not support to multiplexing '0'    (e.g. 0 * 5 -> ERROR)
	if keystone_table.config.clickedButtonToggle == 0 then
		table.sort(sortedNode, sortFunctions[keystone_table.config.clickedButton])
	else 
		table.sort(sortedNode, sortFunctions[keystone_table.config.clickedButton+5])
	end
	return sortedNode
end

function isAlphaStr(str) 
    return (string.match(str, "[^%w]") == nil)
end
