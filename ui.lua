local family_toggles = {
    {ref_value = "slakoth_fam", label = "rrr_settings_fam_slakoth"}, 
    {ref_value = "makuhita_fam", label = "rrr_settings_fam_makuhita"}, 
    {ref_value = "sableye_fam", label = "rrr_settings_fam_sableye"}, 
    {ref_value = "zangoose_fam", label = "rrr_settings_fam_zangoose"}, 
    {ref_value = "seviper_fam", label = "rrr_settings_fam_seviper"}, 
    {ref_value = "combee_fam", label = "rrr_settings_fam_combee"}, 
    {ref_value = "tandemaus_fam", label = "rrr_settings_fam_tandemaus"}, 

}

local create_menu_toggles = function (parent, toggles)
    for k, v in ipairs(toggles) do
      parent.nodes[#parent.nodes + 1] = create_toggle({
            label = localize(v.label),
            ref_table = rrr_config,
            ref_value = v.ref_value,
            callback = function(_set_toggle)
              NFS.write(mod_dir.."/config.lua", STR_PACK(rrr_config))
            end,
      })
      if v.tooltip then
        parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
      end
    end
  end
  
config = function()
    local family_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
    create_menu_toggles(family_settings, family_toggles)
    
    local config_nodes =   
    {
      {
        n = G.UIT.R,
        config = {
          padding = 0,
          align = "cm"
        },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              text = localize("rrr_settings_fam_toggle_header"),
              shadow = true,
              scale = 0.75 * 0.8,
              colour = HEX("ED533A")
            }
          }
        },
      },
      family_settings,
    }
    return config_nodes
  end

-- TODO toggles are bare minimum, I'd like to have a paginated ui element with the cards of the base form and the toggle
-- Using the family UI code we should be able to right click the card element to see the whole family line.
-- UI is hard, future problems! Toggles work for now.
SMODS.current_mod.config_tab = function()
    return {
      n = G.UIT.ROOT,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
      },
      nodes = config()
    }
end