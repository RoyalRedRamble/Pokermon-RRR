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
        info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
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
    megas = { "mega_sableye" },
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

local honedge = {
    name = "honedge",
    pos = {x = 1, y=2},
    config = {
        extra = {probability = 1/7, mult = 10, scored_cards = 10},
    },
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.mult, center.ability.extra.scored_cards}}
    end,
    rarity = 3,
    cost = 6,
    stage = "Basic",
    ptype = "Metal",
    atlas = "Pokedex6",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and not context.end_of_round and context.cardarea == G.hand then
            if context.other_card.facing == "back" then
                if card.ability.extra.scored_cards then
                    card.ability.extra.scored_cards = card.ability.extra.scored_cards - 1
                end
                return {
                    mult = card.ability.extra.mult,
                    card = card,
                }
            end
        end
        if card.ability.extra.scored_cards == 0 then
            poke_evolve(card, 'j_rrr_doublade')
        end
    end,
}

local doublade = {
    name = "doublade",
    pos = {x = 2, y=2},
    config = {
        extra = {probability = 1/7, mult = 16, scored_cards = 8},
    },
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.mult, center.ability.extra.scored_cards}}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "Basic",
    ptype = "Metal",
    atlas = "Pokedex6",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and not context.end_of_round and context.cardarea == G.hand then
            if context.other_card.facing == "back" then
                if card.ability.extra.scored_cards then
                    card.ability.extra.scored_cards = card.ability.extra.scored_cards - 1
                end
                return {
                    mult = card.ability.extra.mult,
                    card = card,
                }
            end
        end
        if card.ability.extra.scored_cards == 0 then
            poke_evolve(card, 'j_rrr_aegislash')
        end
    end,
}

-- TODO: Just had a thought
-- Defaults to sword forme, face down cards give steel bonus
-- Swapping to shield forme alternates the face down cards BUT
-- Either:
-- -- - Lesser Xmult, so you have to debate whether to swap formes
-- -- - Some other bonus that correlates to defence?
local aegislash = {
    name = "aegislash",
    pos = {x = 3, y=2},
    config = {
        extra = {probability = 1/7, Xmult = 1.5, shield = false},
    },
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "Basic",
    ptype = "Metal",
    atlas = "Pokedex6",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and not context.end_of_round and context.cardarea == G.hand then
            if context.other_card.facing == "back" then
                return {
                    Xmult = card.ability.extra.Xmult,
                    card = card,
                }
            end
        end

        if context.selling_self then
            -- Need to remove the button while selling or it's visible when the card is dissapearing 
            -- Using remove keeps the element around for some reason? Setting to nil is more immediate.
            card.children.forme_button = nil
        end

        if context.end_of_round and card.ability.extra.shield then
            card:forme_change_flip()
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if initial then
            -- Adding a function for the UI flip and to change state
            card.forme_change_flip = function(self)
                -- Flip and delay so the flip animation actually plays
                self:flip()
                -- Change the FRONT sprite. 
                -- I wanted to just change the back sprite but while the joker is flipped the sell value is hidden, this is just easier
                if self.ability.extra.shield then
                    self.children.center:set_sprite_pos({x = 3, y = 2})
                else
                    self.children.center:set_sprite_pos({x = 11, y = 7})
                end
                -- remember to flip back or we won't see the sprite!
                self:flip()
                self.ability.extra.shield = not self.ability.extra.shield
            end

            -- Custom change forme button
            card.children.forme_button = UIBox({
                definition = {
                    n = G.UIT.ROOT,
                    config = {
                        minh = 0.7,
                        maxh = 0.9,
                        minw = 2,
                        maxw = 4,
                        r = 0.08,
                        padding = 0.1,
                        align = "cl",
                        colour = G.C.GREEN,
                        hover = true,
                        shadow = true,
                        button = "aegislash_forme_change",
                        func = "can_flip_aegislash",
                        ref_table = card,
                    },
                    nodes = {
                       {n=G.UIT.C, config={align = "tm"}, nodes={
                        {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                            {n=G.UIT.T, config={text = "Change",colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}}
                        }},
                        {n=G.UIT.R, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config={text = "Forme",colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                        }}
                        }}
                    },
                },
                config = {
                    align = "cli",
                    offset = {
                        x = -1,
                        y = 0.3,
                    },
                    bond = "Strong",
                    parent = card,
                },
            })
        end
    end,
}

G.FUNCS.aegislash_forme_change = function(e)
    -- Flip every card in hand
    if G.hand.cards and #G.hand.cards > 0 then
        for i = 1, #G.hand.cards do
            G.hand.cards[i]:flip()
        end
    end
    local card = e.config.ref_table
    -- Unhighlight yourself, otherwise the buttons are very visible underneath the flipping cards which looks weird
    card:highlight(false)

    -- Make the card flip and update state
    if card.forme_change_flip then
        card:forme_change_flip()
    end
end

G.FUNCS.can_flip_aegislash = function(e)
	local card = e.config.ref_table
    -- Early out if ability is on cooldown
    if card.ability.extra.shield then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
        return
    end

	if
		not (G.CONTROLLER.locked or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
		and not G.SETTINGS.paused
		and card.area and card.area.config.type == "joker"
        and G.hand.cards and #G.hand.cards > 0
	then
		e.config.colour = G.C.GREEN
		e.config.button = "aegislash_forme_change"
		e.states.visible = true
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Temporary, just to bulk out families!

local tadbulb={
    name = "tadbulb",
    pos = {x = 9, y=2},
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 3,
    cost = 6,
    stage = "Basic",
    ptype = "Colorless",
    atlas = "Pokedex9",
    blueprint_compat = true,
    calculate = function(self, card, context)
        
    end,
}

local orthworm={
    name = "orthworm",
    pos = {x = 3, y=5},
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 3,
    cost = 6,
    stage = "Basic",
    ptype = "Colorless",
    atlas = "Pokedex9",
    blueprint_compat = true,
    calculate = function(self, card, context)
        
    end,
}

local frigibax={
    name = "frigibax",
    pos = {x = 8, y=6},
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 3,
    cost = 6,
    stage = "Basic",
    ptype = "Colorless",
    atlas = "Pokedex9",
    blueprint_compat = true,
    calculate = function(self, card, context)
        
    end,
}

local flamigo={
    name = "flamigo",
    pos = {x = 8, y=5},
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 3,
    cost = 6,
    stage = "Basic",
    ptype = "Colorless",
    atlas = "Pokedex9",
    blueprint_compat = true,
    calculate = function(self, card, context)
        
    end,
}

local list = {
    slakoth, vigoroth, slaking, 
    makuhita, hariyama, 
    sableye, mega_sableye, 
    zangoose, 
    seviper, 
    combee, vespiquen, 
    tandemaus, maushold_three, maushold_four, 
    honedge, doublade, aegislash,
    tadbulb,
    orthworm,
    frigibax,
    flamigo
}


return {
    name = "RoyalRedRamble's Jokers 1",
    list = list,
  }