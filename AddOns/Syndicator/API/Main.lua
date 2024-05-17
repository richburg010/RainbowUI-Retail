local _, addonTable = ...

-- Returns details about which not hidden characters and guilds contain items
-- matching the item link.
--   itemLink: string
--   sameConnectedRealms: boolean
--   sameCurrentFaction: boolean
function Syndicator.API.GetInventoryInfo(itemLink, sameConnectedRealm, sameFaction)
  local success, key = pcall(Syndicator.Utilities.GetItemKey, itemLink)
  if not success then
    error("Bad item link. Try using one generated by a call to GetItemInfo.")
    return
  end

  return Syndicator.ItemSummaries:GetTooltipInfo(key, sameConnectedRealm == true, sameFaction == true)
end

Syndicator.API.GetInventoryInfoByItemLink = Syndicator.API.GetInventoryInfo

-- Returns details about which not hidden characters and guilds contain items
-- matching the item ID (does not work for battle pet cages).
--   itemID: number
--   sameConnectedRealms: boolean
--   sameCurrentFaction: boolean
function Syndicator.API.GetInventoryInfoByItemID(itemID, sameConnectedRealm, sameFaction)
  local key = Syndicator.Utilities.GetItemKeyByItemID(itemID)
  return Syndicator.ItemSummaries:GetTooltipInfo(key, sameConnectedRealm == true, sameFaction == true)
end

-- Returns currency counts for a specific currency on all characters
--   currencyID: number
--   sameConnectedRealms: boolean
--   sameCurrentFaction: boolean
function Syndicator.API.GetCurrencyInfo(currencyID, sameConnectedRealm, sameFaction)
  assert(type(currencyID) == "number")
  return Syndicator.Tracking.GetCurrencyTooltipData(currencyID, sameConnectedRealm == true, sameFaction == true)
end

-- Set the callback used when an item's location is clicked in the /syns search results
-- callback: function(mode, entity, container, itemLink, searchText)
--    mode: "character" or "guild"
--    entity: Name of character or guild
--    container: "bag", "bank" or guild bank tab (number)
--    itemLink: Item Link for the item who's owner has been clicked on
--    searchText: Search text to help focus the item
function Syndicator.API.RegisterShowItemLocation(callback)
  addonTable.ShowItemLocationCallback = callback
end

function Syndicator.API.GetAllCharacters()
  return GetKeysArray(SYNDICATOR_DATA.Characters)
end

-- characterFullName: string, e.g. "Martin-NormalizedRealmName"
function Syndicator.API.GetByCharacterFullName(characterFullName)
  return SYNDICATOR_DATA.Characters[characterFullName]
end

Syndicator.API.GetCharacter = Syndicator.API.GetByCharacterFullName

function Syndicator.API.GetAllGuilds()
  return GetKeysArray(SYNDICATOR_DATA.Guilds)
end

-- guildFullName: string, e.g. "The Jokesters-NormalizedRealmName"
function Syndicator.API.GetByGuildFullName(guildFullName)
  if SYNDICATOR_DATA.Guilds[guildFullName] then
    return SYNDICATOR_DATA.Guilds[guildFullName], guildFullName
  end

  local guildName, realmName = strsplit("-", guildFullName)

  -- The guild isn't stored in Syndicator against this realmName, so it must be
  -- stored against another connected realm's name, try to find it.
  for guild, data in pairs(SYNDICATOR_DATA.Guilds) do
    if data.details.guildName == guildName and tIndexOf(data.details.realms, realmName) ~= nil then
      return data, guild
    end
  end
end

Syndicator.API.GetGuild = Syndicator.API.GetByGuildFullName

function Syndicator.API.GetWarband(index)
  index = index or 1
  return SYNDICATOR_DATA.Warband[index]
end

function Syndicator.API.GetCurrentCharacter()
  return Syndicator.BagCache.currentCharacter
end

function Syndicator.API.GetCurrentGuild()
  return Syndicator.GuildCache.currentGuild
end

function Syndicator.API.DeleteCharacter(characterFullName)
  assert(characterFullName ~= Syndicator.BagCache.currentCharacter, "Cannot delete live character")
  local characterData = Syndicator.API.GetByCharacterFullName(characterFullName)

  if not characterData then
    error("Character does not exist")
  end

  SYNDICATOR_DATA.Characters[characterFullName] = nil

  local realmSummary = SYNDICATOR_SUMMARIES.Characters.ByRealm[characterData.details.realmNormalized]
  if realmSummary and realmSummary[characterData.details.character] then
    realmSummary[characterData.details.character] = nil
  end
  Syndicator.CallbackRegistry:TriggerEvent("CharacterDeleted", characterFullName)
end

function Syndicator.API.DeleteGuild(guildFullName)
  local guildData, guildFullName = Syndicator.API.GetByGuildFullName(guildFullName)
  assert(guildFullName ~= Syndicator.GuildCache.currentGuild, "Cannot delete current guild")

  if not guildData then
    error("Guild does not exist")
    return
  end

  SYNDICATOR_DATA.Guilds[guildFullName] = nil

  local realmSummary = SYNDICATOR_SUMMARIES.Guilds.ByRealm[guildData.details.realms[1]]
  if realmSummary and realmSummary[guildData.details.guild] then
    realmSummary[guildData.details.guild] = nil
  end
  Syndicator.CallbackRegistry:TriggerEvent("GuildDeleted", guildFullName)
end

function Syndicator.API.ToggleCharacterHidden(characterFullName)
  local characterData = Syndicator.API.GetByCharacterFullName(characterFullName)
  assert(characterData, "Character does not exist")
  characterData.details.hidden = not characterData.details.hidden
end

function Syndicator.API.ToggleGuildHidden(guildFullName)
  local guildData, guildFullName = Syndicator.API.GetByGuildFullName(guildFullName)
  assert(guildData, "Guild does not exist")
  guildData.details.hidden = not guildData.details.hidden
end

-- Returns if the tracking data is ready for use
function Syndicator.API.IsReady()
  return Syndicator.Tracking.isReady
end

function Syndicator.API.IsBagEventPending()
  return Syndicator.BagCache.isUpdatePending
end

function Syndicator.API.IsGuildEventPending()
  return Syndicator.GuildCache.isUpdatePending
end
