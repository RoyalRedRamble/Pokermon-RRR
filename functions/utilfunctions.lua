rrr_hook_copy = function()
    G.E_MANAGER:add_event(Event({ func = function()
        local any_selected = nil
        local _cards = {}
        for k, v in ipairs(G.hand.cards) do
            _cards[#_cards+1] = v
        end
        for i = 1, 2 do
            if G.hand.cards[i] then 
                local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('hook'))
                G.hand:add_to_highlighted(selected_card, true)
                table.remove(_cards, card_key)
                any_selected = true
                play_sound('card1', 1)
            end
        end
        if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
    return true end }))
end 

function rrr_bee_suit_check(card, suit)
    if not (next(SMODS.find_card('j_rrr_combee')) or next(SMODS.find_card('j_rrr_vespiquen'))) then
        return false
    end
    if ((card.base.suit == 'Spades' or card.base.suit == 'Diamonds') and (suit == 'Spades' or suit == 'Diamonds')) then
        return true
    end
    return false
end


function rrr_should_flip(card)
    -- Ignore the flip while in shop, I could leave this to be cruel
    if (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) then
        return
    end

    local flip_jokers = {'j_rrr_honedge', 'j_rrr_doublade', 'j_rrr_aegislash'}
    for _, f in ipairs(flip_jokers) do
        -- Iterate through each card, in case we have double ups of different stages
        for _, joker in ipairs(SMODS.find_card(f)) do
            if joker.ability.extra.probability and pseudorandom(pseudoseed('rrr_should_flip')) < joker.ability.extra.probability then
                card:flip()
                -- If one probability hits, commit to the flip. Otherwise we have to contend with flips back and forth.
                -- TODO: maybe that's just more fun to commit to though?
                return
            end
        end
    end
end

function get_base_evo_name(card)
    -- Get the name of the base form if you can
    local fam = poke_get_family_list(card.name)
    -- Default is your own name, you may have no family T.T
    local base_evo_name = card.name
    if #fam > 0 then
        -- Found a base evo, use it's name
        base_evo_name = fam[1]
    end
    return base_evo_name
end

disableable_pool = function(self)
    local base_evo_name = get_base_evo_name(self)
    
    -- Convert the name to a config key, check if it's in the config at all
    if (rrr_config[base_evo_name..'_fam']) then
        -- If enabled, it's in the back poke pool
        return pokemon_in_pool(self)
    end
    
    -- Removed from pool otherwise
    return false
end