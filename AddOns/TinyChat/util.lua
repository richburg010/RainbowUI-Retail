local addon, ns = ...local locale = GetLocale()local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")local L = {    Emote       = { zhTW = "表情", zhCN = "表情" },	VoiceChat  = { zhTW = "加入內建語音", zhCN = "加入语音聊天" },    GlassConfig  = { zhTW = "設定聊天視窗", zhCN = "聊天窗口设置" },    EditBoxPos  = { zhTW = "輸入框位置", zhCN = "输入框位置" },    Top         = { zhTW = "頂部", zhCN = "顶部" },    Bottom      = { zhTW = "底部", zhCN = "底部" },    ChatSwitch  = { zhTW = "頻道按鈕管理", zhCN = "快捷频管理" },	ChatMainButtonPos = { zhTW = "頻道按鈕位置", zhCN = "频道按钮位置" },	Drag = { zhTW = "按住 Alt 鍵拖曳最左側的按鈕來移動位置", zhCN = "按住 Alt 键拖曳曳最左侧的按钮来移动位置" },	Reset = { zhTW = "重置位置", zhCN = "重置位置" },    ToggleShortName = { zhTW = "縮寫名稱", zhCN = "显示简称" },    ToggleSwitch    = { zhTW = "顯示頻道按鈕", zhCN = "显示快捷栏" },    ToogleBackdrop  = { zhTW = "按鈕背景", zhCN = "按钮材质" },    ToogleSocial  = { zhTW = "社群頻道", zhCN = "社群频道" },    ToggleDock      = { zhTW = "顯示分頁標籤", zhCN = "显示标签栏" },    ToggleLinkIcon  = { zhTW = "顯示物品圖示", zhCN = "显示链接图" },    ToggleLinkLevel = { zhTW = "顯示物品等級", zhCN = "显示物品等级" },    ToggleHistory   = { zhTW = "上下鍵輸入歷史", zhCN = "聊天历史上下箭頭選取" },    ToggleHistoryNote   = { zhTW = "上下鍵輸入歷史: 啟用時只要按方向鍵上/下便可選擇輸入過的字句，停用時需要按住 Alt+方向鍵上/下來選擇。", zhCN = "聊天历史上下箭頭選取: 启用时只要按方向键上/下便可选择输入过的字句，禁用时需要按住 Alt+方向键上/下来选择。" },	-- ToggleLag   = { zhTW = "過濾發話延遲", zhCN = "过滤发话延迟" },	-- ToggleLagNote  = { zhTW = "過濾發話延遲: 離開副本自動時關閉說和大喊頻道，避免看到因為伺服器延遲的發話，進入副本會自動開啟說和大喊頻道，並且關閉對話泡泡。同時也會過濾掉你不在隊伍/團隊中的系統洗頻訊息。", zhCN = "过滤发话延迟: 离开副本自动时关闭说和大喊频道，避免看到因为伺服器延迟的发话，进入副本会自动开启说和大喊频道，并且关闭对话泡泡。同时也会过滤掉你不在队伍/团队中的系统洗频讯息。" },	-- ToggleLagTimer   = { zhTW = "晚上 9-12 點定時開關", zhCN = "晚上 9-12 点定时开关" },	-- ToggleLagTimerNote   = { zhTW = "定時開關: 晚上 9-12 點會自動開啟發話延遲過濾功能，其他時間會自動關閉。若想要手動開關發話延遲過濾功能，請停用此選項。", zhCN = "定时开关: 定时开关: 晚上 9-12 点会自动开启发话延迟过滤功能，其他时间会自动关闭。若想要手动开关发话延迟过滤功能，请停用此选项。" },	-- ToggleBubble   = { zhTW = "進出副本自動開關", zhCN = "进出副本自动开关" },	-- ToggleBubbleNote   = { zhTW = "進出副本自動開關: 進副本自動開啟對話泡泡，方便看見 DBM 喊話。出副本自動關閉，避免看到廣告。晚上 9-12 點 (或手動) 開啟發話延遲過濾功能時，副本內外都會關閉對話泡泡。若想要手動開關對話泡泡，請停用此選項。", zhCN = "进出副本自动开关: 进副本自动开启对话泡泡，方便看见 DBM 喊话。出副本自动关闭，避免看到广告。晚上 9-12 点 (或手动) 开启发话延迟过滤功能时，副本内外都会关闭对话泡泡。若想要手动开关对话泡泡，请停用此选项。" },	NeedReload = { zhTW = "(更改此設定需要重新載入介面)", zhCN = "(更改此设定需要重新载入介面)" },	Pull		= { zhTW = "開怪倒數", zhCN = "开怪倒数" },	PullYell	= { zhTW = "喊話", zhCN = "喊话" },	s3			= { zhTW = "3 秒", zhCN = "3 秒" },	s5			= { zhTW = "5 秒", zhCN = "5 秒" },	s8			= { zhTW = "8 秒", zhCN = "8 秒" },	s10			= { zhTW = "10 秒", zhCN = "10 秒" },	s16			= { zhTW = "16 秒", zhCN = "16 秒" },}TinyChatDB = {	PullTime = 5,	PullText = false,    EditBoxPos = "BOTTOM",    HideSwitchBackdrop = false,    HideSocialSwitch = false,    HideDockManager = false,    HideSwitch = false,	HideLinkIcon = false,	HideLinkLevel = false,    FirstWord = true,	HistoryNeedAlt = false,	Spam = false,	LagFilter = false,	LagFilterAuto = false,	Listen = {}	-- BubbleManually = false}---------------------------------------增加表情按钮到频道切换框架--------------------------------------- if (ns.emotes) then --     tinsert(CHATSWITCH["CUSTOM"], { static=true, default = L["Emote"][locale] or "Emote", func = function(self) ToggleFrame(CustomEmoteFrame) end})-- end---------------------------------------整體框架-------------------------------------local ChatMainFrame, ChatMainButtonlocal LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")local isGlassEnabled = IsAddOnLoaded("ls_Glass") -- ls_Glass 相容性修正-- 重設社交按鈕的位置local function resetQuickJoinToastButton()	-- 自行加入與 ConsolePort 的相容性	if IsAddOnLoaded("ConsolePort") then		QuickJoinToastButton:Hide()		return	end	QuickJoinToastButton:ClearAllPoints()	QuickJoinToastButton:SetPoint("BOTTOM", ChatMainButton, "TOP", 0, 0)end-- 重設聊天選單按鈕的位置local function resetChatFrameMenuButton()	ChatFrameMenuButton:ClearAllPoints()	ChatFrameMenuButton:SetPoint("RIGHT", ChatSwitchFrame, "LEFT", 4, 0)	resetQuickJoinToastButton()enddo    --創建框架    ChatMainFrame = CreateFrame("Frame", "ChatMainFrame", UIParent)    ChatMainFrame:SetSize(10, 10)    ChatMainFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)    --设置父框架要在PLAYER_LOGIN事件处理    GeneralDockManager:SetParent(ChatMainFrame)    QuickJoinToastButton:SetParent(ChatMainFrame)    -- ChatFrameChannelButton:SetParent(ChatMainFrame)    --ChatFrameToggleVoiceDeafenButton:SetParent(ChatMainFrame)    --ChatFrameToggleVoiceMuteButton:SetParent(ChatMainFrame)    --隱藏顯示按鈕    ChatMainButton = CreateFrame("Button", "ChatMainButton", UIParent)    ChatMainButton:SetWidth(24)    ChatMainButton:SetHeight(24)    ChatMainButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-Maximize-Up")    ChatMainButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-Maximize-Down")    ChatMainButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")    ChatMainButton:SetPoint("TOPLEFT", _G["ChatFrame1"], "BOTTOMLEFT", -30, -25)  --這裡調整位置	    -- 重設社交按鈕	ChatMainFrame:SetScript("OnShow", resetQuickJoinToastButton)	resetQuickJoinToastButton()	-- C_Timer.After(1, function() resetQuickJoinToastButton() end)		-- 重設聊天選單按鈕，為了 ls_Glass 的相容性所以延遲調整	C_Timer.After(1, function()		--重設ChatSwitchFrame		if (ChatSwitchFrame) then			ChatSwitchFrame:SetParent(ChatMainButton)			ChatSwitchFrame:ClearAllPoints()			ChatFrameMenuButton:SetParent(ChatSwitchFrame)			resetChatFrameMenuButton()			if isGlassEnabled then				ChatFrameMenuButton:SetWidth(20)				ChatFrameMenuButton:SetHeight(20)				ChatSwitchFrame:SetPoint("LEFT", ChatMainButton, "RIGHT", 14, 0)			else				ChatFrameMenuButton:SetWidth(24)				ChatFrameMenuButton:SetHeight(24)				ChatSwitchFrame:SetPoint("LEFT", ChatMainButton, "RIGHT", 18, 0)			end		end	end)		-- 隱藏對話頻道按鈕	if not isGlassEnabled then		ChatFrameChannelButton:Hide()	end			ChatMainButton:SetMovable(true)	ChatMainButton:SetClampedToScreen(true)    ChatMainButton:SetFrameStrata("LOW")    ChatMainButton:SetFrameLevel(GeneralDockManager:GetFrameLevel() + 100)    ChatMainButton:RegisterForDrag("LeftButton")    ChatMainButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")    ChatMainButton:SetScale(1.1) --覺得整排按鈕小的，調整此數值就可        ChatMainButton.dropDown = CreateFrame("Frame", "ChatMainButtonDropDown", ChatMainButton, "UIDropDownMenuTemplate")		-- 重置位置的全域函數	function resetTinyChat()		ChatMainButton:ClearAllPoints()		ChatMainButton:SetPoint("TOPLEFT", _G["ChatFrame1"], "BOTTOMLEFT", -30, -25)  --這裡調整位置		TinyChatDB.point = nil		TinyChatDB.xOfs = nil		TinyChatDB.yOfs = nil	end		--拖曳完成後保存位置	local function OnDragStop(self)		self:StopMovingOrSizing()		TinyChatDB.point, _, _, TinyChatDB.xOfs, TinyChatDB.yOfs = self:GetPoint();	end		ChatMainButton:SetScript("OnDragStart", function(self) if IsAltKeyDown() then self:StartMoving() end end)    ChatMainButton:SetScript("OnDragStop", OnDragStop)	    --按鈕點擊事件	local function OnClick(self, button)        if (button == "LeftButton") then            ToggleFrame(ChatMainFrame)            if (ChatSwitchFrame and not TinyChatDB.HideSwitch) then ToggleFrame(ChatSwitchFrame) end        elseif (button == "RightButton") then            LibDD:ToggleDropDownMenu(1, nil, self.dropDown, self, 24, 24)        end    end    ChatMainButton:SetScript("OnClick", OnClick)	    --輸入框上下調整    local function TopOrBottom(self)  --調整位置在此處		if isGlassEnabled then return end -- 與聊天視窗美化的相容性		local editbox        local editboxA = "BOTTOM"        local editboxY = -34        -- local buttonY  = 28		local fontSize        if (self.value == "TOP") then            editboxA = "TOP"            editboxY = 22            -- buttonY  = 50            if (not GeneralDockManager:IsShown()) then                editboxY = editboxY - 20                -- buttonY  = buttonY - 20            end        end		for i = 1, NUM_CHAT_WINDOWS do            editbox = _G["ChatFrame"..i.."EditBox"]            if (editbox) then                editbox:ClearAllPoints()                editbox:SetPoint("BOTTOM", _G["ChatFrame"..i], editboxA, 0, editboxY)                editbox:SetPoint("LEFT", _G["ChatFrame"..i], 0, 0)                editbox:SetPoint("RIGHT", _G["ChatFrame"..i], -20, 0)				-- 調整文字輸入框的文字大小，和聊天內容一致				_, fontSize = GetChatWindowInfo(i);				if (fontSize and fontSize > 18) then					editbox:SetFont("Fonts\\arheiuhk_bd.ttf", fontSize-2, "")					editbox.header:SetFont("Fonts\\arheiuhk_bd.ttf", fontSize-2, "")					editbox.headerSuffix:SetFont("Fonts\\arheiuhk_bd.ttf", fontSize-2, "")					editbox.NewcomerHint:SetFont("Fonts\\arheiuhk_bd.ttf", fontSize-2, "")					editbox.prompt:SetFont("Fonts\\arheiuhk_bd.ttf", fontSize-2, "")				end            end        end        TinyChatDB.EditBoxPos = self.value    end	-- 開怪倒數秒數設定	local function setPullTime(self)		TinyChatDB.PullTime = self.value		if not TinyChatDB.PullTime then TinyChatDB.PullTime = 5 end	end    --右鍵下拉菜單    local function initializeDropMenu(self, level)        local info        if (level == 1) then            --大標題            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = "TinyChat"            info.notCheckable = true            info.isTitle = true            LibDD:UIDropDownMenu_AddButton(info, 1)						-- 顯示語音對話頻道			info = LibDD:UIDropDownMenu_CreateInfo()			info.text  = L["VoiceChat"][locale] or "Voice Chat"			info.value = "Voice"			info.notCheckable = 1			info.keepShownOnClick = 1			info.func = function() ChatFrameChannelButton:GetScript("OnClick")(ChatFrameChannelButton) LibDD:CloseDropDownMenus() end			LibDD:UIDropDownMenu_AddButton(info, level)			          			if isGlassEnabled then				-- 打開聊天視窗美化的設定選項				info = LibDD:UIDropDownMenu_CreateInfo()				info.text  = L["GlassConfig"][locale] or "ChatFrame Options"				info.value = "Glass"				info.notCheckable = 1				info.keepShownOnClick = 1				info.func = function() SlashCmdList["LSGLASS"]("") LibDD:CloseDropDownMenus() end				LibDD:UIDropDownMenu_AddButton(info, level)			else				--文字輸入框位置				info = LibDD:UIDropDownMenu_CreateInfo()				info.text  = L["EditBoxPos"][locale] or "EditBox Position"				info.value = "EditBox"				info.notCheckable = 1				info.hasArrow = 1				info.keepShownOnClick = 1				info.func = nil				LibDD:UIDropDownMenu_AddButton(info, level)			end			--頻道按鈕位置位置            info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["ChatMainButtonPos"][locale] or "Chat Buttons Position"            info.value = "ChatMainButtonPos"            info.notCheckable = 1            info.hasArrow = 1            info.keepShownOnClick = 1            info.func = nil            LibDD:UIDropDownMenu_AddButton(info, level)            --顯示頻道按鈕            if (CHATSWITCH and ChatSwitchFrame) then                info = LibDD:UIDropDownMenu_CreateInfo()                info.text  = L["ToggleSwitch"][locale] or "Toggle switch panel"                info.value = "ChatSwitch"                info.arg1 = TinyChatDB.HideSwitch and 1 or 0                info.checked = not TinyChatDB.HideSwitch                info.hasArrow = 1                info.keepShownOnClick = 1                info.func = function(self, arg1)                    if (arg1==1) then                        TinyChatDB.HideSwitch = false                    else                        TinyChatDB.HideSwitch = true                    end                    ToggleFrame(ChatSwitchFrame)                end                LibDD:UIDropDownMenu_AddButton(info, level)            end			            --顯示分頁標籤			info = LibDD:UIDropDownMenu_CreateInfo()			info.text = L["ToggleDock"][locale] or "Toggle DockManager"			info.checked = not TinyChatDB.HideDockManager			info.func = function(self)				ToggleFrame(GeneralDockManager)				TinyChatDB.HideDockManager=not GeneralDockManager:IsShown()				TopOrBottom({value=TinyChatDB.EditBoxPos})			end			LibDD:UIDropDownMenu_AddButton(info, level)            --聊天鏈接圖標            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["ToggleLinkIcon"][locale] or "Toggle ChatLinkIcon"            info.checked = not TinyChatDB.HideLinkIcon            info.func = function(self)                TinyChatDB.HideLinkIcon = not TinyChatDB.HideLinkIcon            end            LibDD:UIDropDownMenu_AddButton(info, level)            --物品等級            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["ToggleLinkLevel"][locale] or "Toggle ItemLevel"            info.checked = not TinyChatDB.HideLinkLevel            info.func = function(self)                TinyChatDB.HideLinkLevel = not TinyChatDB.HideLinkLevel            end            LibDD:UIDropDownMenu_AddButton(info, level)						-- 對話泡泡			info = LibDD:UIDropDownMenu_CreateInfo()            info.text = SHOW .. CHAT_BUBBLES_TEXT			info.value = "ToggleBubble"			-- info.arg1 = tonumber(C_CVar.GetCVar("ChatBubbles")			info.checked = (tonumber(C_CVar.GetCVar("ChatBubbles")) == 1 and true or false)			-- info.hasArrow = 1			info.keepShownOnClick = 1            info.func = function(self)                if tonumber(C_CVar.GetCVar("ChatBubbles")) == 1 then					C_CVar.SetCVar("ChatBubbles", 0)					print(DISABLE..CHAT_BUBBLES_TEXT)				else					C_CVar.SetCVar("ChatBubbles", 1)					print(ENABLE..CHAT_BUBBLES_TEXT)				end            end            LibDD:UIDropDownMenu_AddButton(info, level)			--上下鍵歷史記錄            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["ToggleHistory"][locale] or "Toggle Up/Down Key Select History"            info.checked = not TinyChatDB.HistoryNeedAlt            info.func = function(self)                TinyChatDB.HistoryNeedAlt = not TinyChatDB.HistoryNeedAlt				print(L["ToggleHistoryNote"][locale] or "Toggle Up/Down Key Select History: Use Up/Down arrow key to select input history with or without hold Alt key.")            end            LibDD:UIDropDownMenu_AddButton(info, level)			-- 過濾延遲			--[[			info = LibDD:UIDropDownMenu_CreateInfo()			info.text  = L["ToggleLag"][locale] or "Toggle Lag Filter"			info.value = "ToggleLag"			info.checked = TinyChatDB.LagFilter			info.hasArrow = 1			info.keepShownOnClick = 1			info.func = function(self)				-- 手動開關會把定時一起關掉				TinyChatDB.LagFilter = not TinyChatDB.LagFilter				TinyChatDB.LagFilterAuto = false				print(L["ToggleLagNote"][locale] or "Toggle Lag Filter: Filter out messages delayed by the server by automatically enable/disable SAY and YELL.")				print("|cffFF2D2D" .. (L["NeedReload"][locale] or "(Requires Reload UI)") .. "|r")			end			LibDD:UIDropDownMenu_AddButton(info, level)			--]]						-- 開怪倒數秒數設定選單			info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["Pull"][locale] or "Pull"            info.value = "Pull"            info.notCheckable = 1            info.hasArrow = 1            info.keepShownOnClick = 1            info.func = nil            LibDD:UIDropDownMenu_AddButton(info, level)            --表情            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["Emote"][locale] or "Emote"            info.notCheckable = 1            info.func = function(self) ToggleFrame(CustomEmoteFrame) end            LibDD:UIDropDownMenu_AddButton(info, level)            --取消            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = CANCEL or "cancel"            info.notCheckable = 1            info.func = function(self) self:GetParent():Hide() end            LibDD:UIDropDownMenu_AddButton(info)        end				-- 過濾延遲子選單		--[[		if (level == 2 and L_UIDROPDOWNMENU_MENU_VALUE == "ToggleLag") then            -- 定時開關			info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["ToggleLagTimer"][locale] or "Timer"            info.checked = TinyChatDB.LagFilterAuto            info.func = function(self)                TinyChatDB.LagFilterAuto = not TinyChatDB.LagFilterAuto				print(L["ToggleLagTimerNote"][locale] or "Timer: pm9-12 on. If you want to manually switch, please disable this option.")				print("|cffFF2D2D" .. (L["NeedReload"][locale] or "(Requires Reload UI)") .. "|r")            end            LibDD:UIDropDownMenu_AddButton(info, level)		end		--]]				-- 對話泡泡子選單		--[[		if (level == 2 and L_UIDROPDOWNMENU_MENU_VALUE == "ToggleBubble") then            -- 自動開關			info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["ToggleBubble"][locale] or "Auto Toggle Bubble"            info.checked = not TinyChatDB.BubbleManually            info.func = function(self)                TinyChatDB.BubbleManually = not TinyChatDB.BubbleManually				print(L["ToggleBubbleNote"][locale] or "Automatically enable/disable chat bubbles.")            end            LibDD:UIDropDownMenu_AddButton(info, level)		end		--]]		-- 開怪倒數設定		if (level == 2 and L_UIDROPDOWNMENU_MENU_VALUE == "Pull") then			-- 是否喊話            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["PullYell"][locale] or "Yell"            info.value = TinyChatDB.PullText            info.checked = TinyChatDB.PullText            info.func = function(self)                if (self.value == true) then                    TinyChatDB.PullText = false                else                    TinyChatDB.PullText = true                end            end            LibDD:UIDropDownMenu_AddButton(info, level)			-- 秒數設定            info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["s3"][locale] or "3s"            info.value = 3            info.notCheckable = 1            info.func = setPullTime            LibDD:UIDropDownMenu_AddButton(info, level)            info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["s5"][locale] or "5s"            info.value = 5            info.notCheckable = 1            info.func = setPullTime            LibDD:UIDropDownMenu_AddButton(info, level)			info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["s8"][locale] or "8s"            info.value = 8            info.notCheckable = 1            info.func = setPullTime            LibDD:UIDropDownMenu_AddButton(info, level)			info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["s10"][locale] or "10s"            info.value = 10            info.notCheckable = 1            info.func = setPullTime            LibDD:UIDropDownMenu_AddButton(info, level)			info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["s16"][locale] or "16s"            info.value = 16            info.notCheckable = 1            info.func = setPullTime            LibDD:UIDropDownMenu_AddButton(info, level)        end		if (level == 2 and L_UIDROPDOWNMENU_MENU_VALUE == "EditBox") then			info = LibDD:UIDropDownMenu_CreateInfo()			info.text  = L["Top"][locale] or "Top"			info.value = "TOP"			info.notCheckable = 1			info.func = TopOrBottom			LibDD:UIDropDownMenu_AddButton(info, level)			info = LibDD:UIDropDownMenu_CreateInfo()			info.text  = L["Bottom"][locale] or "Bottom"			info.value = "BOTTOM"			info.notCheckable = 1			info.func = TopOrBottom			LibDD:UIDropDownMenu_AddButton(info, level)		end		if (level == 2 and L_UIDROPDOWNMENU_MENU_VALUE == "ChatMainButtonPos") then            info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["Drag"][locale] or "Drag"            info.value = nil            info.notCheckable = 1            info.func = nil            LibDD:UIDropDownMenu_AddButton(info, level)            info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["Reset"][locale] or "Reset"            info.value = nil            info.notCheckable = 1            info.func = function(self)				resetTinyChat()				LibDD:CloseDropDownMenus()			end            LibDD:UIDropDownMenu_AddButton(info, level)        end        if (level == 2 and L_UIDROPDOWNMENU_MENU_VALUE == "ChatSwitch") then			--是否顯示社群頻道按鈕            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["ToogleSocial"][locale] or "Toogle Social Channels"            info.value = CHATSWITCH.ShowSocial            info.checked = not TinyChatDB.HideSocialSwitch            info.func = function(self)                if (self.value==1) then                    CHATSWITCH.ShowSocial = 0                    TinyChatDB.HideSocialSwitch = true                else                    CHATSWITCH.ShowSocial = 1                    TinyChatDB.HideSocialSwitch = false                end                ChatSwitchFrame:OnEvent("CUSTOM_EVENT")            end            LibDD:UIDropDownMenu_AddButton(info, level)            --全稱或簡稱            info = LibDD:UIDropDownMenu_CreateInfo()            info.text  = L["ToggleShortName"][locale] or "Toggle Short Name"            info.value = CHATSWITCH.FirstWord            info.checked = TinyChatDB.FirstWord            info.func = function(self)                if (self.value==1) then                    CHATSWITCH.FirstWord = 0                    TinyChatDB.FirstWord = false                else                    CHATSWITCH.FirstWord = 1                    TinyChatDB.FirstWord = true                end                ChatSwitchFrame:OnEvent("CUSTOM_EVENT")            end            LibDD:UIDropDownMenu_AddButton(info, level)            --是否显示材质            info = LibDD:UIDropDownMenu_CreateInfo()            info.text = L["ToogleBackdrop"][locale] or "Toogle Backdrop"            info.value = CHATSWITCH.ShowBackdrop            info.checked = not TinyChatDB.HideSwitchBackdrop            info.func = function(self)                if (self.value==1) then                    CHATSWITCH.ShowBackdrop = 0                    TinyChatDB.HideSwitchBackdrop = true                else                    CHATSWITCH.ShowBackdrop = 1                    TinyChatDB.HideSwitchBackdrop = false                end                ChatSwitchFrame:OnEvent("CUSTOM_EVENT")            end            LibDD:UIDropDownMenu_AddButton(info, level)        end    end    LibDD:UIDropDownMenu_Initialize(ChatMainButton.dropDown, initializeDropMenu, "MENU")    --配置存檔事件    ChatMainButton:SetScript("OnEvent", function(self, event, ...)        if event == "ZONE_CHANGED_NEW_AREA" then			-- 進出副本時聊天選單按鈕位置會跑掉，所以每次都要重置			resetChatFrameMenuButton()		elseif event == "PLAYER_LOGIN" then			-- self:UnregisterAllEvents()			local chatframe, r, t, p, x, y			local adjust = select(5, UIParent:GetPoint(2)) or 0			for i = 1, NUM_CHAT_WINDOWS do				chatframe = _G["ChatFrame"..i]				r, t, p, x, y = chatframe:GetPoint()				chatframe:SetParent(ChatMainFrame)				chatframe:SetPoint(r, t, p, x, (y or 0)-adjust) -- Glass 相容性修正			end			if (TinyChatDB.HideDockManager) then				ToggleFrame(GeneralDockManager)			end			if (ChatSwitchFrame) then				if (TinyChatDB.HideSwitch) then ChatSwitchFrame:Hide() end				CHATSWITCH.ShowSocial = TinyChatDB.HideSocialSwitch and 0 or 1				CHATSWITCH.ShowBackdrop = TinyChatDB.HideSwitchBackdrop and 0 or 1				CHATSWITCH.FirstWord = TinyChatDB.FirstWord and 1 or 0				ChatSwitchFrame:OnEvent("CUSTOM_EVENT")			end			TopOrBottom({value=TinyChatDB.EditBoxPos})			if TinyChatDB.point then				ChatMainButton:ClearAllPoints()				ChatMainButton:SetPoint(TinyChatDB.point, TinyChatDB.xOfs, TinyChatDB.yOfs)			end						if not TinyChatDB.Listen then				TinyChatDB.Listen = {}			end						-- 自行加入與 ConsolePort 的相容性			C_Timer.After(1, function()				if IsAddOnLoaded("ConsolePort") then					if (ChatSwitchFrame and not TinyChatDB.HideSwitch) then 						TinyChatDB.HideSwitch = true						TinyChatDB.HideDockManager = true						ToggleFrame(ChatSwitchFrame)						ToggleFrame(GeneralDockManager)					end				end			end)		end    end)    	ChatMainButton:RegisterEvent("PLAYER_LOGIN") --考慮到位置重置等各種因素,這裡不用VARIABLES_LOADED	ChatMainButton:RegisterEvent("ZONE_CHANGED_NEW_AREA")end-- 新增聊天文字大小清單if not isGlassEnabled then	table.insert(CHAT_FONT_HEIGHTS, 5, 20)	table.insert(CHAT_FONT_HEIGHTS, 6, 24)	table.insert(CHAT_FONT_HEIGHTS, 7, 28)	table.insert(CHAT_FONT_HEIGHTS, 8, 32)	table.insert(CHAT_FONT_HEIGHTS, 9, 36)	table.insert(CHAT_FONT_HEIGHTS, 10, 40)end-- 過濾掉所有 不願被打擾 自動回覆的廣告訊息ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", function()	return trueend)