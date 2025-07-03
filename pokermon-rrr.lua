--Load all Atlas
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
})


-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
    -- load family entries
    pokermon.add_family({"combee", "vespiquen"})
    pokermon.add_family({"tandemaus", "maushold_three", "maushold_four"})
    pokermon.add_family({"makuhita", "hariyama"})
    pokermon.add_family({"slakoth", "vigoroth", "slaking"})
end

local helper, load_error = SMODS.load_file("functions/utilfunctions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end

-- print("PARTY TIEM")

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pfiles) do
    sendDebugMessage ("The file is: "..file)
    local pokemon, load_error = SMODS.load_file("pokemon/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_pokemon = pokemon()
      if curr_pokemon.init then curr_pokemon:init() end
      
      if curr_pokemon.list and #curr_pokemon.list > 0 then
        for i, item in ipairs(curr_pokemon.list) do
          if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only then
            pokermon.Pokemon(item, 'rrr', nil)
          end
        end
      end
    end
  end
end 


--Load challenges file
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  local pchallenges = NFS.getDirectoryItems(mod_dir.."challenges")

  for _, file in ipairs(pchallenges) do
    local challenge, load_error = SMODS.load_file("challenges/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_challenge = challenge()
      if curr_challenge.init then curr_challenge:init() end
      
      for i, item in ipairs(curr_challenge.list) do
        SMODS.Challenge(item)
      end
    end
  end
end