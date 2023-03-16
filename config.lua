Config = {}

Config.Amount = { -- If you don't configure the number, the default will be 1
['water_bottle'] = 10,
['nitrous'] = math.random(1, 5) -- Random Amount
}
Config.SpawnRewards = {
    [1] = { 
        active = true,      
        coords = vec3(-1696.31, -3176.23, 13.94),
        items = { -- You must specify all categories
            ['water_bottle'] = 'rare',
            ['nitrous'] = 'common',
            ['sandwich'] = 'easy'
        },
        object = 'prop_tool_box_06',
    },
    [2] = { 
        active = true, 
        coords = vec3(-1633.58, -3172.3, 17.11),
        items = { -- You must specify all categories
            ['water_bottle'] = 'rare',
            ['nitrous'] = 'common',
            ['sandwich'] = 'easy'
        },
        object = 'prop_tool_box_06',
    },
    [3] = { 
        active = true, 
        coords = vec3(-1505.63, -3228.18, 16.26),
        items = { -- You must specify all categories
            ['water_bottle'] = 'rare',
            ['nitrous'] = 'common',
            ['sandwich'] = 'easy'
        },
        object = 'prop_tool_box_06',
    },
    [4] = { 
        active = true, 
        coords = vec3(-1104.78, -3447.5, 16.81),
        items = { -- You must specify all categories
            ['water_bottle'] = 'rare',
            ['nitrous'] = 'common',
            ['sandwich'] = 'easy'
        },
        object = 'prop_tool_box_06',
    },
}