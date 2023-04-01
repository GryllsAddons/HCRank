MobWarn = CreateFrame("Frame", nil, UIParent)	
MobWarn:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

local function colorRank(num)
  -- https://colorkit.co/gradient-palette/ff0000-f7ef00/?steps=4
  local color = "ffffff"
  if num >= 75 then
    color = "f7ef00"
  elseif num >= 50 then
    color = "faa000"    
  elseif num >= 25 then
    color = "fc5100"    
  elseif num >= 1 then
    color = "ff0000"
  end
  return color
end

MobWarn:SetScript("OnEvent", function()
    local name = UnitName("mouseover")
    local mob = MobWarn.mobs[name]
    if mob then
      local rank = MobWarn.mobs[name]["Rank"]
      local kills = MobWarn.mobs[name]["Kills"]
      local color = colorRank(rank)
      GameTooltip:AddLine("|cff" .. color .. "Players Killed: " .. kills .. "|r")
      GameTooltip:AddLine("|cff" .. color .. "Mob Rank: " .. rank .. "|r")
      GameTooltip:Show()
    end
end)