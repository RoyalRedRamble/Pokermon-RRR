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
                    "Uses {C:attention}Population Bomb EX{} if hand",
                    "contains a {C:attention}#1#{}",
                    "or a {C:attention}#2#{}",
                    "{C:inactive,s:0.8}(Yes these stack)",
                } 
            },
            j_rrr_maushold_four = {
                name = "Maushold",
                text = {
                    "Uses {C:attention}Population Bomb EX{} if hand",
                    "contains a {C:attention}#1#{}", 
                    "or a {C:attention}#2#{}",
                } 
            },
            j_rrr_makuhita = {
                name = "Makuhita",
                text = {
                    "{C:blue}+#1#{} hand",
                    "{C:attention}+#2#{} hand size",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
                } 
            },
            j_rrr_hariyama = {
                name = "Hariyama",
                text = {
                    "{C:blue}+#1#{} hands",
                    "{C:attention}+#2#{} hand size",
                    "Gain {C:attention}+1{} hand size for",
                    "every hand used this round",
                } 
            },
            j_rrr_slakoth = {
                name = "Slakoth",
                text = {
                    "{C:mult}+#1#{} Mult every {C:attention}second{} hand",
                    "{C:inactive}#2#{}",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
                } 
            },
            j_rrr_vigoroth = {
                name = "Vigoroth",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#2#{C:inactive,s:0.8} rounds)",
                } 
            },
            j_rrr_slaking = {
                name = "Slaking",
                text = {
                    "{X:mult,C:white}X#1#{} Mult every {C:attention}second{} hand",
                    "{C:inactive}#2#{}",
                } 
            },
            j_rrr_sableye = {
                name = "Sableye",
                text = {
                    "{C:attention}Destroys {C:diamonds}Diamonds{} cards",
                    "left in hand after scoring.",
                    "Gives {C:money}$#1#{} and gains {C:money}$#1#{} of",
                    "sell value for every card",
                    "consumed.",
                } 
            },
            j_rrr_mega_sableye = {
                name = "Mega Sableye",
                text = {
                    "{C:attention}Destroys {C:diamonds}Diamonds{} cards",
                    "left in hand after scoring.",
                    "Gives {C:money}$#1#{} and gains {C:money}$#1#{} of",
                    "sell value for every card",
                    "consumed.",
                    "{br:2}ERROR - CONTACT STEAK",
                    "Gives {X:mult,C:white}X#2#{} Mult for each",
                    "{C:money}${} of sell value this Joker has",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive,s:0.8} Mult)",
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
                    "but stops triggering on first failure.",
                    "{C:attention}Resets{} after each hand."
                }
            },
            population_bomb_ex = {
                name = "Population Bomb EX",
                text = {
                    "{C:green}#1#%{} chance to give",
                    "{X:mult,C:white}X#2#{} Mult when card is scored",
                    "Increased by {X:mult,C:white}#3#{} per trigger",
                    "but stops triggering on first failure.",
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
        dictionary = {
            rrr_slacking = "Slacking Off!",
            rrr_ready = "Ready!",
            rrr_yawn = "Yawn",
            rrr_miss = "Miss",
            rrr_population_bomb = "Population Bomb!",
            rrr_population_bomb_big = "POPULATION BOMB!",
        },

    }
}