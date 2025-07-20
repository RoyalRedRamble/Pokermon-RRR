  
-- Callback for joker pool button
function G.FUNCS.rrr_families(e)
  G.FUNCS.overlay_menu{definition = create_UIBox_rrr_joker_pool()}
end


--# Part 1 Start of attempt 2
-- Entry point, create function for container

function create_UIBox_rrr_joker_pool()

  -- SMODS call an event manager option, maybe to preload the content?
  return {
      n = G.UIT.O,
      config = { object = UIBox{
        definition = create_UIBox_rrr_joker_pool_content(),
        config = { offset = {x=0, y=0}, align = 'cm' }
      }, id = 'rrr_joker_pool_content', align = 'cm' },
    }

end

--# Part 2
-- This contains the page cycler, and most importantly the actual UIBox!
function create_UIBox_rrr_joker_pool_content(page)
  local MAX_SLOTS_PER_ROW = 3
  local MAX_ROW = 3
  local current_row = 1

  local MAX_PAGE_CONTENTS = MAX_ROW*MAX_SLOTS_PER_ROW

  -- page selector
  local current_page = page or 1
  -- print("current_row is "..current_row)
  local page_limit = math.ceil(#rrr_base_evos/(MAX_PAGE_CONTENTS))
  local page_options = {}
  for i = 1, page_limit do
    table.insert(page_options, localize('k_page')..' '..tostring(i)..'/'..tostring(page_limit))
  end

  G.rrr_family_config_container = {
    n = G.UIT.C, 
    config = {
      padding = 0.2
    }, 
    nodes = {
      {
        n = G.UIT.R,
        nodes = {}
      },
      {
        n = G.UIT.R,
        nodes = {}
      },
      {
        n = G.UIT.R,
        nodes = {}
      },
      create_option_cycle({
        options = page_options,
        opt_callback =
          'rrr_joker_pool_page',
        current_option = current_page,
        colour = G.C.RED,
      })    
    }
  }

  -- ANOTHER TODO: Right clicking on card is great, going back however returns to the collection, not the previous ui route.


  -- MAN I really hate how this isn't zero indexed sometimes.
  local startSlice = ((current_page - 1) * (MAX_PAGE_CONTENTS)) + 1
  local endSlice = current_page * MAX_PAGE_CONTENTS

  for k, v in ipairs({unpack(rrr_base_evos, startSlice, endSlice)}) do

    -- First we figure out which row we go into

    -- Are we due for a row change
    if #G.rrr_family_config_container.nodes[current_row].nodes >= MAX_SLOTS_PER_ROW then
      current_row = current_row + 1
      -- If we've hit the cap, return what we have so far.
      if current_row > MAX_ROW then
        break
      end
    end

    local slot_entry = {
      n = G.UIT.C, 
      config={
        align = "cr", 
      }, 
      nodes = {
        {
          n = G.UIT.R, 
          config={
            r = 0.1,
            outline = 1.5,
            outline_colour = HEX("FF7ABF"),
          }, 
          nodes = {
            {
              n = G.UIT.O, 
              config={object = Card(G.CARD_W/2, G.CARD_H, G.CARD_W, G.CARD_H, nil, G.P_CENTERS['j_rrr_'..v])}
            },
            create_toggle({
              label = "",
              col = true,
              w = 0,
              ref_table = rrr_config['families'],
              ref_value = v,
              callback = function(_set_toggle)
                NFS.write(mod_dir.."/config.lua", STR_PACK(rrr_config))
              end,
            }),
          }
        },
      }
    }

    G.rrr_family_config_container.nodes[current_row].nodes[#G.rrr_family_config_container.nodes[current_row].nodes+1] = slot_entry
  end


  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
    contents = {G.rrr_family_config_container}
  })

  return t

end


--#Part 3
-- The cleaner and callback enabler
G.FUNCS.rrr_joker_pool_page = function(args)
  local page = args.cycle_config.current_option or 1
	local t = create_UIBox_rrr_joker_pool_content(page)
	local e = G.OVERLAY_MENU:get_UIE_by_ID('rrr_joker_pool_content')
	if e.config.object then e.config.object:remove() end
    e.config.object = UIBox{
      definition = t,
      config = {offset = {x=0,y=0}, align = 'cm', parent = e}
    }
end

config = function()
  local family_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
  
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
      label = {"Family Config"}
    }),
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