local Timer = require 'vendor/timer'
local controls = require 'controls'

local Platform = {}
Platform.__index = Platform
Platform.isPlatform = true

function Platform.new(node, collider)
    local platform = {}
    setmetatable(platform, Platform)

    --If the node is a polyline, we need to draw a polygon rather than rectangle
    if node.polyline or node.polygon then
        local polygon = node.polyline or node.polygon
        local vertices = {}

        for i, point in ipairs(polygon) do
            table.insert(vertices, node.x + point.x)
            table.insert(vertices, node.y + point.y)
        end
           
        platform.bb = collider:addPolygon(unpack(vertices))
        platform.bb.polyline = polygon
    else
        platform.bb = collider:addRectangle(node.x, node.y, node.width, node.height)
        platform.bb.polyline = nil
    end
    
    platform.node = node
    
    platform.drop = node.properties.drop ~= 'false'

    platform.down_dt = 0

    platform.bb.node = platform
    collider:setPassive(platform.bb)

    return platform
end

function Platform:update( dt )
    if controls.isDown( 'DOWN' ) then
        self.down_dt = 0
    else
        self.down_dt = self.down_dt + dt
    end
end

function Platform:collide( node, dt, mtv_x, mtv_y )
    if not node.floor_pushback then return end

    if node.isPlayer then
        self.player_touched = true
        
        if self.dropping then
            return
        end
    end
    
    local _, wy1, _, wy2  = self.bb:bbox()
    local px1, py1, px2, py2 = node.bb:bbox()
    local distance = math.abs(node.velocity.y * dt) + 2.10

    if self.bb.polyline
                    and node.velocity.y >= 0
                    -- Prevent the player from being treadmilled through an object
                    and ( self.bb:contains(px2,py2) or self.bb:contains(px1,py2) ) then
        
        -- Use the MTV to keep players feet on the ground,
        -- fudge the Y a bit to prevent falling into steep angles
        node:floor_pushback(self, (py1 - 4 ) + mtv_y)

    elseif node.velocity.y >= 0 and math.abs(wy1 - py2) <= distance then
        
        node:floor_pushback(self, wy1 - node.height)
    end
end

function Platform:collide_end(node)
    if node.isPlayer then
        self.player_touched = false
        self.dropping = false
    end
end

function Platform:keypressed( button, player )
    if self.drop and button == 'DOWN' and self.down_dt > 0 and self.down_dt < 0.15 then
         self.dropping = true
         Timer.add( 0.25, function() self.dropping = false end )
    end
end

return Platform
