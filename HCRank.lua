local HCRank = CreateFrame("Frame", nil, UIParent)
HCRank:RegisterEvent("PLAYER_ENTERING_WORLD")
HCRank:RegisterEvent("PLAYER_LEVEL_UP")
HCRank:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

function HCRank:color(rank)
  -- https://colorkit.co/gradient-palette/ff0000-f7ef00/?steps=4
  local color = "ffffff"
  if rank >= 75 then
    color = "f7ef00"
  elseif rank >= 50 then
    color = "faa000"    
  elseif rank >= 25 then
    color = "fc5100"    
  elseif rank >= 1 then
    color = "ff0000"
  end
  return color
end

function HCRank:loadData()
  HCRank.mobs = nil
  HCRank.players = nil
  HCRank.mobs = HCRank_mobs(UnitLevel("player"))
  HCRank.players = HCRank_players()
end

HCRank:SetScript("OnEvent", function()
  if (event == "UPDATE_MOUSEOVER_UNIT") then
    local mob
    local name = UnitName("mouseover")
    
    if UnitIsPlayer("mouseover") then
      mob = HCRank.players[name]
    elseif HCRank.mobs then
      mob = HCRank.mobs[name]
    end

    if mob then      
      local kills = mob["Kills"]
      local rank = mob["Rank"]
      local color = HCRank:color(rank)
      GameTooltip:AddLine("Players Killed: " .. kills)
      GameTooltip:AddLine("|cff" .. color .. "Rank: " .. rank .. "|r")
      GameTooltip:Show()
    end
  else
    HCRank:loadData()
  end
end)

DEFAULT_CHAT_FRAME:AddMessage("HCRank Loaded!", 1, 0.5, 0)