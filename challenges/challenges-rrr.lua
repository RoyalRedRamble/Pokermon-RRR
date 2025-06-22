-- local zangoose_debug = {
--     object_type = "Challenge",
--     key = "zangoose_debug",
--     jokers = {
--         {id = "j_poke_magmortar"},
--         {id = "j_rrr_zangoose"},
--     },
--     consumeables = {
--         {id = "c_poke_pokeball"},
--     },
--     rules = {
--         modifiers = {
--             {id = 'dollars', value = '60000'}
--         }
--     },
--     vouchers = {
--         {id = "v_retcon"},
--         {id = "v_directors_cut"},
--     }
-- }

local the_rivals = {
    object_type = "Challenge",
    key = "the_rivals",
    jokers = {
        {id = "j_rrr_seviper", eternal = true},
        {id = "j_rrr_zangoose", eternal = true},
    },
}

return {name = "Challenges",
    list = {the_rivals}
}