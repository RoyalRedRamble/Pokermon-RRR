return {
    descriptions = {
        Joker = {
            j_rrr_zangoose = {
                name = "Zangoose",
                text = {
                    "{X:mult,C:white}X#1#{} if {C:attention}#2#{} or fewer",
                    "cards held in hand",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Applies {C:attention}The Hook{}",
                } 
            },
            j_rrr_seviper = {
                name = "Seviper",
                text = {
                    "{X:mult,C:white}X#1#{} if {C:attention}#2#{} or more",
                    "cards held in hand",
                    "{br:3}ERROR - CONTACT STEAK",
                    "Applies {C:attention}The Serpent{}",
                    "{C:inactive,s:0.8}(Only during a {C:attention,s:0.8}Blind{C:inactive,s:0.8})",
                } 
            },
            j_rrr_combee = {
                name = "Combee",
                text = {
                    "Applies {C:attention}Bee Suits{}",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Played {C:attention}Bee Suit{} cards give",
                    "{C:chips}+#1#{} Chips and {C:mult}+#3#{} Mult",
                    "when scored",
                    "{C:inactive,s:0.8}(Evolves after playing a {C:attention,s:0.8}Flush Five",
                    "{C:inactive,s:0.8}of {C:attention,s:0.8}Bee Suit Queens{C:inactive,s:0.8})",
                } 
            },
            j_rrr_vespiquen = {
                name = "Vespiquen",
                text = {
                    "Applies {C:attention}Bee Suits{}",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Played {C:attention}Bee Suit{} cards give",
                    "{C:chips}+#1#{} Chips and {C:mult}+#3#{} Mult",
                    "when scored",
                    "{br:2}ERROR - CONTACT STEAK",
                    "{C:attention}Bee Suit Queens{} give",
                    "{X:mult,C:white}X#5#{} when scored"
                } 
            },
            j_rrr_tandemaus = {
                name = "Tandemaus",
                text = {
                    "Uses {C:attention}Population Bomb{} if hand",
                    "contains a {C:attention}#1#{}",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#2#{C:inactive,s:0.8} rounds)"
                } 
            },
            j_rrr_maushold_three = {
                name = "Maushold",
                text = {
                    "Uses {C:attention}Population Bomb{} if hand",
                    "contains a {C:attention}#1#{}",
                    "or a {C:attention}#2#{}",
                    "{C:inactive,s:0.8}(Yes these stack)"
                } 
            },
            j_rrr_maushold_four = {
                name = "Maushold",
                text = {
                    "Uses {C:attention}Population Bomb{} if hand",
                    "contains a {C:attention}#1#{}", 
                    "or a {C:attention}#2#{}"
                } 
            },
        },
        Other = {
            bee_suits = {
                name = "Bee Suits",
                text = {
                    "{C:spades}Spades{} and {C:diamonds}Diamonds{}",
                    "count as the same suit",
                }
            },
            population_bomb = {
                name = "Population Bomb",
                text = {
                    "{C:green}#1#%{} chance to give",
                    "{C:mult}+#2#{} Mult when card is scored",
                    "Mult is {C:attention}doubled{} per trigger",
                    "but stops triggering on failure.",
                    "{C:attention}Resets{} after each hand."
                }
            },
            population_bomb_ex = {
                name = "Population Bomb",
                text = {
                    "{C:green}#1#%{} chance to give",
                    "{X:mult,C:white}X#2#{} Mult when card is scored",
                    "Increased by {X:mult,C:white}#3#{} per trigger",
                    "but stops triggering on failure.",
                    "{C:attention}Resets{} after each hand."
                }
            },
        },
    }, 
    misc = {
        challenge_names = {
            c_rrr_the_rivals = "The Rivals",
            c_rrr_combee = "Combee",
        },

    }
}