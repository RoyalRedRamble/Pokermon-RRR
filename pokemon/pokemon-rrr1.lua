local zangoose={
    name = "zangoose",
    poke_custom_prefix = 'rrr',
    pos = {x = 3, y=8},
    config = {extra = {Xmult = 2, handSize = 3}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Blind', key= 'bl_hook', config={}}
            return {vars = {center.ability.extra.Xmult, center.ability.extra.handSize}}
    end,
    rarity = 3,
    cost = 6,
    stage = "Basic",
    ptype = "Colorless",
    atlas = "poke_Pokedex3",
    debuff = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.full_hand then
            if context.joker_main then
                if #G.hand.cards <= card.ability.extra.handSize then
                    return {
                        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
                        colour = G.C.XMULT,
                        Xmult_mod = card.ability.extra.Xmult
                    }
                end
            end
        end
    end,
    prefix_config = {
        atlas = false,
    },
}


local seviper={
    name = "seviper",
    poke_custom_prefix = 'rrr',
    pos = {x = 4, y=8},
    config = {extra = {Xmult = 1.5, handSize = 5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Blind', key= 'bl_serpent', config={}}
            return {vars = {center.ability.extra.Xmult, center.ability.extra.handSize}}
    end,
    rarity = 3,
    cost = 6,
    stage = "Basic",
    ptype = "Dark",
    atlas = "poke_Pokedex3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.full_hand then
            if context.joker_main then
                if #G.hand.cards >= card.ability.extra.handSize then
                    return {
                        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
                        colour = G.C.XMULT,
                        Xmult_mod = card.ability.extra.Xmult
                    }
                end
            end
        end
    end,
    prefix_config = {
        atlas = false,
    },
}

local combee={
    name = "combee",
    poke_custom_prefix = 'rrr',
    pos = {x = 0, y=2},
    config = {extra = {chip = 10, mult = 2, chipSuit = 'Spades', multSuit = 'Diamonds', can_evo = false}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key= 'bee_suits'}
        return {vars = {
            center.ability.extra.chip, center.ability.extra.chipSuit,
            center.ability.extra.mult, center.ability.extra.multSuit,
            center.ability.extra.can_evo
        }}
    end,
    rarity = 2,
    cost = 3,
    stage = "Basic",
    ptype = "Grass",
    atlas = "poke_Pokedex4",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local chips = 0
        local mult = 0
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.chipSuit) then
                if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
                    chips = card.ability.extra.chip
                    mult = card.ability.extra.mult
                end
            end
        end

        if context.cardarea == G.jokers and context.scoring_hand then
            if context.before and not context.blueprint then
                local queen_count = 0
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() == 12 and v:is_suit(card.ability.extra.chipSuit) then queen_count = queen_count + 1 end
                end
                card.ability.extra.can_evo = queen_count >= 5
            end
        end
        -- I don't need to seperate like this with the custom smear but it makes things clearer for now
        if chips > 0 or mult > 0 then
            return {
                mult = mult,
                chips = chips,
                card = card
            }
        end

        -- Evolving
        if can_evolve(self, card, context, "j_rrr_vespiquen") and card.ability.extra.can_evo then
            return {
                message = poke_evolve(card, "j_rrr_vespiquen")
            }
        end
    end,
    prefix_config = {
        atlas = false,
    },
}


local vespiquen={
    name = "vespiquen",
    poke_custom_prefix = 'rrr',
    pos = {x = 1, y=2},
    config = {extra = {chips = 20, mult = 5, chipSuit = 'Spades', multSuit = 'Diamonds', Xmult = 1.2}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'bee_suits'}
        return {vars = {
            center.ability.extra.chips, center.ability.extra.chipSuit,
            center.ability.extra.mult, center.ability.extra.multSuit,
            center.ability.extra.Xmult,
        }}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "One",
    ptype = "Grass",
    atlas = "poke_Pokedex4",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local chips = 0
        local mult = 0
        local xMult = 1
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.chipSuit) then
                if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
                    chips = card.ability.extra.chip
                    mult = card.ability.extra.mult
                    if context.other_card:get_id() == 12 then
                        xMult = card.ability.extra.Xmult
                    end
                end
            end
        end
        -- I don't need to seperate like this with the custom smear but it makes things clearer for now
        if chips > 0 or mult > 0 or xMult > 1 then
            return {
                mult = mult,
                chips = chips,
                xmult = xMult,
                card = card
            }
        end

    end,
    prefix_config = {
        atlas = false,
    },
}



return {
    name = "RoyalRedRamble's Jokers 1",
    list = {zangoose, seviper, combee, vespiquen},
  }