tigris.mobs.register(":tigris_mobs:fallen_flower", {
    description = "Fallen Flower",
    collision = {-0.2, -0.4, -0.2, 0.2, 0.4, 0.2},
    box = {
        {-0.1, -0.4, -0.1, 0.1, 0.4, 0.1},
        {-0.4, 0.3, -0.4, 0.4, 0.4, 0.4},
    },

    textures = {"tigris_mobs_fallen_flower.png"},

    groups = "ur-demons",
    level = 1,

    drops = {
        {20, "flowers:rose"},
        {20, "flowers:tulip"},
        {20, "flowers:dandelion_yellow"},
        {20, "flowers:chrysanthemum_green"},
        {20, "flowers:geranium"},
        {20, "flowers:viola"},
        {20, "flowers:dandelion_white"},
        {20, "flowers:tulip_black"},
    },

    on_init = function(self, data)
        self.hp_max = 1
        data.speed = 4
        data.fast_speed = 4
        data.damage = {heat = 2, cold = 1, fleshy = 1}
        data.jump = 10
    end,

    start = "wander",
    script = tigris.mobs.common.hunter(),
})

tigris.mobs.register_spawn("tigris_mobs:fallen_flower", {
    ymax = -100,
    ymin = -500,

    light_min = 0,
    light_max = minetest.LIGHT_MAX,

    chance = 12000,

    nodes = {"default:stone"},
})
