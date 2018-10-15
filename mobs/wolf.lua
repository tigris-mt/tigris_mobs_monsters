tigris.mobs.register("tigris_mobs_monsters:wolf", {
    description = "Wolf",
    collision = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4},
    box = {
        {-0.25, 0, -0.5, 0.25, 0.6, 0.5},
        {-0.25, -0.5, -0.5, -0.1, 0, -0.35},
        {0.1, -0.5, -0.5, 0.25, 0, -0.35},
        {-0.25, -0.5, 0.35, -0.1, 0, 0.5},
        {0.1, -0.5, 0.35, 0.25, 0, 0.5},
        {-0.25, 0, -0.5, 0.25, 0.5, -0.75},
        {-0.25, 0, -0.5, 0.25, 0.25, -1.2},
        {-0.1, 0.4, 0.5, 0.1, 0.5, 0.75},
    },
    textures = {
        "wool_dark_grey.png",
        "wool_dark_grey.png",
        "wool_dark_grey.png",
        "wool_dark_grey.png",
        "wool_dark_grey.png",
        "wool_dark_grey.png^tigris_mobs_wolf_face.png",
    },

    group = "hunters",
    level = 2,

    drops = {
        {100, "mobs:meat_raw"},
        {100, "tigris_mobs:bone"},
        {100, "tigris_mobs:fang"},
        {25, "tigris_mobs:fang"},
        {25, "tigris_mobs:eye"},
        {15, "tigris_mobs:eye"},
    },

    habitat_nodes = {"group:soil"},

    on_init = function(self, data)
        self.hp_max = 6
        data.jump = 5
        data.speed = 3.5
        data.fast_speed = 4
        data.damage = {fleshy = 2}
        data.regen = 5
    end,

    start = "wander",

    script = tigris.mobs.common.hunter(),
})

tigris.mobs.register_spawn("tigris_mobs_monsters:wolf", {
    ymax = tigris.world_limits.max.y,
    ymin = -24,

    light_min = 0,
    light_max = minetest.LIGHT_MAX,

    chance = 20000,

    nodes = {"group:soil"},
})
