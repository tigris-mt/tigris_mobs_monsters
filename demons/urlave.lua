-- Urlave - Annoying mob that infests stone blocks.
tigris.mobs.register(":tigris_mobs:urlave", {
    description = "Urlave",
    collision = {-0.25, -0.1, -0.5, 0.25, 0.1, 0.5},
    box = {
        {-0.25, -0.1, -0.5, 0.25, 0.1, 0.5},
        {-0.05, 0.05, 0.5, 0.05, 0.1, 1},
        {-0.1, -0.1, -0.5, 0.1, 0.1, -0.75},
        {-0.25, -0.1, -0.5, -0.1, 0.25, -0.6},
        {0.1, -0.1, -0.5, 0.25, 0.25, -0.6},
    },
    textures = {
        "wool_white.png",
        "wool_white.png",
        "wool_white.png",
        "wool_white.png",
        "wool_white.png",
        "wool_white.png^tigris_mobs_urlave_face.png",
    },

    group = "ur-demons",
    level = 1,

    drops = {},

    -- Will seek out infestable nodes.
    habitat_nodes = {"group:can_urlave_infest"},

    on_init = function(self, data)
        self.hp_max = 5
        data.jump = 5
        data.speed = 4
        data.fast_speed = 4
        data.regen = 5
        data.damage = {fleshy = 2}
    end,

    start = "wander",
    -- Hunter with actions to alert other resting urlaves and infest blocks when inactive.
    script = tigris.mobs.common.hunter(nil, function(s)
        table.insert(s.flee.actions, "break_urlave_infested")
        table.insert(s.standing.actions, "urlave_infest")
    end),
})

-- Every x seconds, try to break other infested blocks to release the urlaves.
local break_time = 10
tigris.mobs.register_action("break_urlave_infested", {
    func = function(self, context)
        local pos = self.object:getpos()
        self.break_infested_timer = (self.break_infested_timer or break_time) + context.dtime
        if self.break_infested_timer > break_time then
            local r = vector.new(5, 3, 5)
            -- For all infested nodes in area, remove (thus triggering spawn).
            for _,pos in ipairs(minetest.find_nodes_in_area(vector.subtract(pos, r), vector.add(pos, r), {"group:tigris_mobs_urlave_infested"})) do
                minetest.remove_node(pos)
            end
            self.break_infested_timer = 0
        end
    end,
})

-- Search for infestable node and infest it.
tigris.mobs.register_action("urlave_infest", {
    func = function(self, context)
        local pos = self.object:getpos()
        local r = vector.new(2, 2, 2)
        local poses = minetest.find_nodes_in_area(vector.subtract(pos, r), vector.add(pos, r), {"group:can_urlave_infest"})
        if #poses > 0 then
            local pos = poses[math.random(#poses)]
            local node = minetest.get_node(pos)
            self.object:set_hp(0)
            node.name = node.name .. "_urlave_infested"
            minetest.set_node(pos, node)
        end
    end,
})

-- Create a new "_urlave_infested" node which will spawn an urlave when broken. Adds can_urlave_infest group to original node.
function tigris.mobs.register_urlave_infested(node, groups)
    local def = table.copy(minetest.registered_nodes[node])
    def.description = "Urlave Infested " .. def.description
    def.drop = ""
    def.groups = def.groups or {}

    local passgroups = table.copy(def.groups)
    passgroups.can_urlave_infest = 1
    minetest.override_item(node, {groups = passgroups})

    def.groups.tigris_mobs_urlave_infested = 1
    for k,v in pairs(groups or {}) do
        def.groups[k] = v
    end
    def.on_destruct = function(pos)
        tigris.mobs.spawn("tigris_mobs:urlave", pos)
    end
    minetest.register_node(":" .. node .. "_urlave_infested", def)
end

-- Basic stone registry.
for _,n in ipairs{
    {"default:stone", {cracky = 1}},
    {"default:cobble", {cracky = 1}},
    {"default:stonebrick", {cracky = 1}},
    {"default:mossycobble", {cracky = 1}},
    {"default:sandstone", {cracky = 1}},
    {"default:sandstonebrick", {cracky = 1}},
} do
    tigris.mobs.register_urlave_infested(n[1], n[2])
end

-- Spawn infested stone mixed among normal stone.
minetest.register_ore({
    ore_type = "scatter",
    ore = "default:stone_urlave_infested",
    wherein = "default:stone",
    clust_scarcity = 13 * 13 * 13,
    clust_num_ores = 1,
    clust_size = 1,
    y_max = tigris.world_limits.max.y,
    y_min = tigris.world_limits.min.y,
})

-- Under y -500, possible to have groups of 2.
minetest.register_ore({
    ore_type = "scatter",
    ore = "default:stone_urlave_infested",
    wherein = "default:stone",
    clust_scarcity = 24 * 24 * 24,
    clust_num_ores = 2,
    clust_size = 2,
    y_max = -500,
    y_min = tigris.world_limits.min.y,
})
