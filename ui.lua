local family_toggles = {
    {ref_value = "slakoth_fam", label = "rrr_settings_fam_slakoth"}, 
    {ref_value = "makuhita_fam", label = "rrr_settings_fam_makuhita"}, 
    {ref_value = "sableye_fam", label = "rrr_settings_fam_sableye"}, 
    {ref_value = "zangoose_fam", label = "rrr_settings_fam_zangoose"}, 
    {ref_value = "seviper_fam", label = "rrr_settings_fam_seviper"}, 
    {ref_value = "combee_fam", label = "rrr_settings_fam_combee"}, 
    {ref_value = "tandemaus_fam", label = "rrr_settings_fam_tandemaus"}, 
    {ref_value = "honedge_fam", label = "rrr_settings_fam_honedge"}, 

}

local create_menu_toggles = function (parent, toggles)
    -- for k, v in ipairs(toggles) do
    --   parent.nodes[#parent.nodes + 1] = create_toggle({
    --         label = localize(v.label),
    --         ref_table = rrr_config,
    --         ref_value = v.ref_value,
    --         callback = function(_set_toggle)
    --           NFS.write(mod_dir.."/config.lua", STR_PACK(rrr_config))
    --         end,
    --   })
    --   if v.tooltip then
    --     parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
    --   end
    -- end
    local MAX_COL_LENGTH = 4

    local card = Card(G.CARD_W/2, G.CARD_H, G.CARD_W, G.CARD_H, nil, G.P_CENTERS['j_rrr_slakoth'])
    local leftSide = {
      n = G.UIT.C, 
      config={
        align = "cl", 
        -- colour = G.C.RED
      }, 
      nodes = {
        {
          n = G.UIT.R, 
          config={
            -- colour = G.C.MONEY,
            outline = 1.5,
            outline_colour = HEX("FF7ABF"),
          }, 
          nodes = {
            {
              n = G.UIT.O, 
              config={object = card},
            },
            create_toggle({
              label = "",
              col = true,
              w = 0,
              ref_table = rrr_config,
              ref_value = 'slakoth_fam',
              callback = function(_set_toggle)
                NFS.write(mod_dir.."/config.lua", STR_PACK(rrr_config))
              end,
            }),
          }
        },
      }
    }

    local cardr = Card(G.CARD_W/2, G.CARD_H, G.CARD_W, G.CARD_H, nil, G.P_CENTERS['j_rrr_makuhita'])
    local rightSide = {
      n = G.UIT.C, 
      config={
        align = "cr", 
        -- colour = G.C.RED
      }, 
      nodes = {
        {
          n = G.UIT.R, 
          config={
            -- colour = G.C.MONEY,
            outline = 1.5,
            outline_colour = HEX("FF7ABF"),
          }, 
          nodes = {
            {
              n = G.UIT.O, 
              config={object = cardr}
            },
            create_toggle({
              label = "",
              col = true,
              w = 0,
              ref_table = rrr_config,
              ref_value = 'makuhita_fam',
              callback = function(_set_toggle)
                NFS.write(mod_dir.."/config.lua", STR_PACK(rrr_config))
              end,
            }),
          }
        },
      }
    }

    local container = {n = G.UIT.R, config={padding = 0.2}, nodes ={leftSide, rightSide}}
    parent.nodes[#parent.nodes + 1] = container
  end
  
config = function()
  local family_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
  -- create_menu_toggles(family_settings, family_toggles)
  
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
        },
      },
    },
    UIBox_button({
      minw = 3.85,
      colour = HEX("FF7ABF"),
      button = "rrr_families",
      label = {"Energy Options"}
    }),
  }
  return config_nodes
end

function G.FUNCS.rrr_families(e)
  local ttip = {set = 'Other', key = 'precise_energy_tooltip'}
  local energy_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR}, nodes = {}}
  create_menu_toggles(energy_settings, family_toggles)
  
  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
      contents = {energy_settings}
  })
  G.FUNCS.overlay_menu{definition = t}
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


-- By default any child of a card that isn't already a specially reserved 'named' child will be drawn on top of the card
-- Which is lame if you want to add buttons, in a similar fashion to 'use' and 'sell' which are usually a little underneath
-- SO you have to add a custom DrawStep to SMODS so that it knows WHEN to draw the child.
SMODS.DrawStep {
    key = 'forme_buttons',
    order = -30, -- Buttons are -30 priority. Duplicate priorities are fine so just match it
    func = function(self)
        --Draw any tags/buttons
        -- TODO: would be nice to allow this to support N forme changes but pre-mature optimization is the root of all evil
        if self.children.forme_button then
            if self.highlighted then
                self.children.forme_button.states.visible = true
                self.children.forme_button:draw()
            else
                self.children.forme_button.states.visible = false
            end
        end
    end,
} 
-- NEED to add your draw step key to the list of keys to ignore
-- We're telling the drawing engine of SMODS "Hey, we have a rule set up to specifically draw this child, so don't worry about it"
SMODS.draw_ignore_keys.forme_buttons = true