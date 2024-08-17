KT_CAMPAIGN_QUEST_TRACKER_MODULE = KT_ObjectiveTracker_GetModuleInfoTable("KT_CAMPAIGN_QUEST_TRACKER_MODULE", KT_QUEST_TRACKER_MODULE);
KT_CAMPAIGN_QUEST_TRACKER_MODULE.updateReasonModule = KT_OBJECTIVE_TRACKER_UPDATE_MODULE_QUEST;
KT_CAMPAIGN_QUEST_TRACKER_MODULE.updateReasonEvents = KT_OBJECTIVE_TRACKER_UPDATE_QUEST + KT_OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED + KT_OBJECTIVE_TRACKER_UPDATE_SUPER_TRACK_CHANGED;

KT_CAMPAIGN_QUEST_TRACKER_MODULE:SetHeader(KT_ObjectiveTrackerFrame.BlocksFrame.CampaignQuestHeader, TRACKER_HEADER_CAMPAIGN_QUESTS, KT_OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED);

function KT_CAMPAIGN_QUEST_TRACKER_MODULE:ShouldDisplayQuest(questID)
	--return quest:GetSortType() == QuestSortType.Campaign and not quest:IsDisabledForSession();
	local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID);
	local campaignID, isHeader = C_QuestLog.GetInfo(questLogIndex).campaignID, C_QuestLog.GetInfo(questLogIndex).isHeader;
	return (campaignID ~= nil and isHeader == false) and not C_QuestLog.IsQuestDisabledForSession(questID);
end