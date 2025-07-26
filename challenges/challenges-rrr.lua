-- local combee = {
--     object_type = "Challenge",
--     key = "combee",
--     jokers = {
--         {id = "j_rrr_combee"},
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

local list = {
    the_rivals,
    -- combee
}

return {name = "Challenges",
    list = list,
}