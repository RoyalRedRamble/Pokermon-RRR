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



return {
    name = "RoyalRedRamble's Jokers 1",
    list = {zangoose, seviper},
  }