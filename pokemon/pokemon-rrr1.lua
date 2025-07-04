local slakoth = {
    name = "slakoth",
    pos = {x = 5, y=3},
    config = {extra = {mult = 20, yawn = true, rounds = 8, }},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        local message = localize("rrr_ready")
        if center.ability.extra.yawn then
            message = localize("rrr_slacking")
        end
        return {vars = {center.ability.extra.mult, message, center.ability.extra.rounds}}
    end,
    rarity = 1,
    cost = 3,
    stage = "Basic",
    ptype = "Colorless",
    atlas = "Pokedex3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and context.full_hand then
            if card.ability.extra.yawn then
                card.ability.extra.yawn = false
                return {
                    message = localize("rrr_yawn")
                }
            else
                card.ability.extra.yawn = true
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end

        return level_evo(self, card, context, 'j_rrr_vigoroth')
    end,
}

local vigoroth = {
    name = "vigoroth",
    pos = {x = 6, y=3},
    config = {extra = {mult = 30, rounds = 4}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.mult, center.ability.extra.rounds}}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "One",
    ptype = "Colorless",
    atlas = "Pokedex3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and context.full_hand then
            return {
                mult = card.ability.extra.mult,
            }
        end

        return level_evo(self, card, context, 'j_rrr_slaking')
    end,
}

local slaking = {
    name = "slaking",
    pos = {x = 7, y=3},
    config = {extra = {Xmult = 4, yawn = true }},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        local message = localize("rrr_ready")
        if center.ability.extra.yawn then
            message = localize("rrr_slacking")
        end
        return {vars = {center.ability.extra.Xmult, message}}
    end,
    rarity = "poke_safari",
    cost = 10,
    stage = "Two",
    ptype = "Colorless",
    atlas = "Pokedex3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and context.full_hand then
            if card.ability.extra.yawn then
                card.ability.extra.yawn = false
                return {
                    message = localize("rrr_yawn")
                }
            else
                card.ability.extra.yawn = true
                return {
                    Xmult = card.ability.extra.Xmult,
                }
            end
        end
    end,
}

local makuhita={
    name = "makuhita",
    pos = {x = 4, y=4},
    config = {extra = {hands = 1, h_size = 1, rounds = 5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.hands, center.ability.extra.h_size, center.ability.extra.rounds}}
    end,
    rarity = 2,
    cost = 6,
    stage = "Basic",
    ptype = "Fighting",
    atlas = "Pokedex3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        return level_evo(self, card, context, 'j_rrr_hariyama')
    end,
    add_to_deck = function(self, card, from_debuff)
        -- Hands
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        if not from_debuff then
            ease_hands_played(card.ability.extra.hands)
        end

        -- Hand size
        G.hand:change_size(card.ability.extra.h_size)

    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Hands
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
        if to_decrease > 0 then
          ease_hands_played(-to_decrease)
        end
        -- Hand size
        G.hand:change_size(-card.ability.extra.h_size)

    end,
}

local hariyama={
    name = "hariyama",
    pos = {x = 5, y=4},
    config = {extra = {hands = 2, h_size = 2, orig_h_size = 2}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.hands, center.ability.extra.h_size}}
    end,
    rarity = 2,
    cost = 6,
    stage = "Basic",
    ptype = "Fighting",
    atlas = "Pokedex3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        -- Every hand played increases your hand size by one
        if context.after then
            local changed_size = 1
            card.ability.extra.h_size = card.ability.extra.h_size + changed_size
            G.hand:change_size(changed_size)
        end

        -- reset to original size when finished
        if context.end_of_round and context.cardarea == G.jokers then
            G.hand:change_size(-(card.ability.extra.h_size-card.ability.extra.orig_h_size))
            card.ability.extra.h_size = card.ability.extra.orig_h_size
        end


    end,
    add_to_deck = function(self, card, from_debuff)
        -- Hands
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        if not from_debuff then
            ease_hands_played(card.ability.extra.hands)
        end

        -- Hand size
        G.hand:change_size(card.ability.extra.h_size)

    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Hands
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
        if to_decrease > 0 then
          ease_hands_played(-to_decrease)
        end

        -- Hand size
        G.hand:change_size(-card.ability.extra.h_size)

    end,
}

local sableye = {
    name = "sableye",
    pos = {x = 0, y=5},
    config = {extra = {money_mod = 1}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.money_mod}}
    end,
    rarity = 2,
    cost = 6,
    stage = "Basic",
    ptype = "Dark",
    atlas = "Pokedex3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.after then
            local eaten = 0
            for i=1, #G.hand.cards do
                if G.hand.cards[i]:is_suit('Diamonds') then
                    eaten = eaten + 1
                    poke_remove_card(G.hand.cards[i], card)
                    card.ability.extra_value = card.ability.extra_value + card.ability.extra.money_mod
                    card:set_cost()
                end
            end
            if eaten  > 0 then
                ease_poke_dollars(card, "sableye", eaten * card.ability.extra.money_mod)
                return {
                    message = "Delicious"
                }
            end
        end
    end,
}

local mega_sableye = {
    name = "mega_sableye",
    pos = {x = 5, y=3},
    soul_pos = {x = 6, y=3},
    config = {extra = {money_mod = 3, Xmult = 0.05}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.money_mod, center.ability.extra.Xmult, 1 + center.ability.extra.Xmult * center.sell_cost }}
    end,
    rarity = "poke_mega",
    cost = 10,
    stage = "Mega",
    ptype = "Dark",
    atlas = "Megas",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.after then
            local eaten = 0
            for i=1, #G.hand.cards do
                if G.hand.cards[i]:is_suit('Diamonds') then
                    eaten = eaten + 1
                    poke_remove_card(G.hand.cards[i], card)
                    card.ability.extra_value = card.ability.extra_value + card.ability.extra.money_mod
                    card:set_cost()
                end
            end
            if eaten  > 0 then
                ease_poke_dollars(card, "sableye", eaten * card.ability.extra.money_mod)
                return {
                    message = "MORE!"
                }
            end
        end

        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
              return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {1 + card.ability.extra.Xmult * card.sell_cost}}, 
                colour = G.C.MULT,
                Xmult_mod = 1 + card.ability.extra.Xmult * card.sell_cost
              }
            end
        end
    end,
}

local zangoose={
    name = "zangoose",
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
    atlas = "Pokedex3",
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
}


local seviper={
    name = "seviper",
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
    atlas = "Pokedex3",
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
}

local combee={
    name = "combee",
    pos = {x = 0, y=2},
    config = {extra = {chips = 10, mult = 2, chipSuit = 'Spades', multSuit = 'Diamonds', can_evo = false}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key= 'bee_suits'}
        return {vars = {
            center.ability.extra.chips, center.ability.extra.chipSuit,
            center.ability.extra.mult, center.ability.extra.multSuit,
            center.ability.extra.can_evo
        }}
    end,
    rarity = 2,
    cost = 3,
    stage = "Basic",
    ptype = "Grass",
    atlas = "Pokedex4",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local chips = 0
        local mult = 0
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.chipSuit) then
                if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
                    chips = card.ability.extra.chips
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
}


local vespiquen={
    name = "vespiquen",
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
    atlas = "Pokedex4",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local chips = 0
        local mult = 0
        local xMult = 1
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.chipSuit) then
                if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
                    chips = card.ability.extra.chips
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
}

local get_tandemaus_evo = function(chance)
    if pseudorandom('tandemaus') < chance then
        return 'j_rrr_maushold_three'
    end
    return 'j_rrr_maushold_four'
end

local tandemaus={
    name = "tandemaus",
    pos = {x = 5, y=1},
    config = {extra = {mult = 5, origMult = 5, odds=90, threeChance = 0.3, rounds = 5, combo = true, hand = "Pair"}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'population_bomb', vars={center.ability.extra.odds, center.ability.extra.mult}}
        return {vars = {center.ability.extra.hand, center.ability.extra.rounds}}
    end,
    rarity = 1,
    cost = 4,
    stage = "Basic",
    ptype = "Colorless",
    atlas = "Pokedex9",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and next(context.poker_hands[card.ability.extra.hand]) then
            if card.ability.extra.combo then
                if pseudorandom('tandemaus') < card.ability.extra.odds/100 then
                    local mult = card.ability.extra.mult
                    card.ability.extra.mult = card.ability.extra.mult * 2
                    return {
                        message = localize("rrr_population_bomb"),
                        mult = mult,
                        card = card
                    }
                else
                    card.ability.extra.combo = false
                    return {
                        message = localize("rrr_miss"),
                    }
                end
            end
        end

        if context.after then
            card.ability.extra.mult = card.ability.extra.origMult
            card.ability.extra.combo = true
        end



        return level_evo(self, card, context, get_tandemaus_evo(card.ability.extra.threeChance))

    end,
}

local maushold_three={
    name = "maushold_three",
    pos = {x = 6, y=1},
    config = {extra = {Xmult = 1.5, totalXMult = 1.5, incMult = 0.5, odds=90, combo = true, hand = "Three of a Kind", handTwo = "Full House"}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'population_bomb_ex', vars={center.ability.extra.odds, center.ability.extra.Xmult, center.ability.extra.incMult}}
        return {vars = {center.ability.extra.hand, center.ability.extra.handTwo}}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "One",
    ptype = "Colorless",
    atlas = "Pokedex9",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if card.ability.extra.combo and (next(context.poker_hands[card.ability.extra.hand]) or next(context.poker_hands[card.ability.extra.handTwo])) then
                if pseudorandom('maushold_three') < card.ability.extra.odds/100 then
                    local Xmult = card.ability.extra.totalXMult
                    local message = localize("rrr_population_bomb")
                    card.ability.extra.totalXMult = card.ability.extra.totalXMult + card.ability.extra.incMult
                    -- If it's a full house it'll count for both
                    if (next(context.poker_hands[card.ability.extra.hand]) and next(context.poker_hands[card.ability.extra.handTwo])) then
                        -- Double double!
                        card.ability.extra.totalXMult = card.ability.extra.totalXMult + card.ability.extra.incMult
                        message = localize("rrr_population_bomb_big")
                    end
                    return {
                        message = message,
                        xmult = Xmult,
                        card = card
                    }
                else
                    card.ability.extra.combo = false
                    return {
                        message = localize("rrr_miss"),
                    }
                end
            end
        end

        if context.after then
            card.ability.extra.totalXMult = card.ability.extra.Xmult 
            card.ability.extra.combo = true
        end

    end,
}

local maushold_four={
    name = "maushold_four",
    pos = {x = 7, y=1},
    config = {extra = {Xmult = 1.5, totalXMult = 1.5, incMult = 0.5, odds=90, combo = true, hand = "Four of a Kind", handTwo = "Full House"}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'population_bomb_ex', vars={center.ability.extra.odds, center.ability.extra.Xmult, center.ability.extra.incMult}}
        return {vars = {center.ability.extra.hand, center.ability.extra.handTwo}}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "One",
    ptype = "Colorless",
    atlas = "Pokedex9",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if card.ability.extra.combo and (next(context.poker_hands[card.ability.extra.hand]) or next(context.poker_hands[card.ability.extra.handTwo])) then
                if pseudorandom('maushold_four') < card.ability.extra.odds/100 then
                    local Xmult = card.ability.extra.totalXMult
                    card.ability.extra.totalXMult = card.ability.extra.totalXMult + card.ability.extra.incMult
                    return {
                        message = localize("rrr_population_bomb"),
                        xmult = Xmult,
                        card = card
                    }
                else
                    card.ability.extra.combo = false
                    return {
                        message = localize("rrr_miss"),
                    }
                end
            end
        end

        if context.after then
            card.ability.extra.totalXMult = card.ability.extra.Xmult
            card.ability.extra.combo = true
        end

    end,
}


return {
    name = "RoyalRedRamble's Jokers 1",
    list = {slakoth, vigoroth, slaking,  makuhita, hariyama, sableye, mega_sableye, zangoose, seviper, combee, vespiquen, tandemaus, maushold_three, maushold_four,},
  }