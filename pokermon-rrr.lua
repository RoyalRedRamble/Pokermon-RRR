--Load all Atlas
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
})


-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
rrr_config = SMODS.current_mod.config

if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
    -- load family entries
    pokermon.add_family({"combee", "vespiquen"})
    pokermon.add_family({"tandemaus", "maushold_three", "maushold_four"})
    pokermon.add_family({"makuhita", "hariyama"})
    pokermon.add_family({"slakoth", "vigoroth", "slaking"})
    pokermon.add_family({"sableye", "mega_sableye"})
    pokermon.add_family({"honedge", "doublade", "aegislash"})
end

local helper, load_error = SMODS.load_file("functions/utilfunctions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end

-- print("PARTY TIEM")

--Load UI file
local UI, load_error = SMODS.load_file("ui.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  UI()
end

rrr_base_evos = {}

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
            -- if the item has a ptype we can reasonably guess it's a pokemon
            if (item.ptype) then
              local base_name = get_base_evo_name(item)
              -- Record the base evo names for later.
              if base_name == item.name then
                rrr_base_evos[#rrr_base_evos + 1] = base_name
              end

              -- I'd really like to look into if I can dynamically make the config...
              if (rrr_config['families'][get_base_evo_name(item)] ~= nil) then
                item.custom_pool_func = true
                item.in_pool = disableable_pool
              else
                sendDebugMessage("Couldn't find a relevant config flag for "..item.name)
                sendDebugMessage("Might have forgotten to add one?")
              end
            end
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