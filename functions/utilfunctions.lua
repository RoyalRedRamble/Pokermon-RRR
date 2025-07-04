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
    local i, joker = next(SMODS.find_card('j_rrr_honedge'))
    if (i) then
        if joker.ability.extra.probability and pseudorandom(pseudoseed('rrr_should_flip')) < joker.ability.extra.probability then
            card:flip()
        end
    end
end