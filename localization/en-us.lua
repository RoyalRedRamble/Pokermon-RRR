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
        },
        Other = {
            bee_suits = {
                name = "Bee Suits",
                text = {
                    "{C:spades}Spades{} and {C:diamonds}Diamonds{}",
                    "count as the same suit",
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