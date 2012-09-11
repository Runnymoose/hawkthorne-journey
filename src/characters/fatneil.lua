
local anim8 = require 'vendor/anim8'

local plyr = {}
plyr.name = 'fatneil'
plyr.offset = 8
plyr.ow = 9
plyr.costumes = {
    {name='Fat Neil', sheet='images/fatneil.png'},
}

local beam = love.graphics.newImage('images/jeff_beam.png')

function plyr.new(sheet)
    local new_plyr = {}
    new_plyr.sheet = sheet
    new_plyr.sheet:setFilter('nearest', 'nearest')

    local g = anim8.newGrid(48, 48, new_plyr.sheet:getWidth(),
        new_plyr.sheet:getHeight())

    local warp = anim8.newGrid(36, 223, beam:getWidth(),
        beam:getHeight())

    new_plyr.hand_offsets = {
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 6,32},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{12,32},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{10, 7},{ 5, 5},{ 5, 5} },
        { { 5, 3},{ 5, 5},{ 5, 3},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { {10, 5},{10, 7},{10, 5},{10, 7},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} },
        { { 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5},{ 5, 5} }
    }
    new_plyr.beam = beam
    new_plyr.animations = {
        dead = {
            right = anim8.newAnimation('once', g('4,6'), 1),
            left = anim8.newAnimation('once', g('4,5'), 1)
        },
        crouch = {
            right = anim8.newAnimation('once', g(3,6), 1),
            left = anim8.newAnimation('once', g(3,5), 1)
        },
        crouchwalk = { --state for walking towards the camera
            left = anim8.newAnimation('loop', g('3-4,3'), 0.16),
            right = anim8.newAnimation('loop', g('3-4,3'), 0.16),
        },
        hold = {
            right = anim8.newAnimation('once', g(7,9), 1),
            left = anim8.newAnimation('once', g(7,10), 1),
        },
        holdwalk = { --state for walking away from the camera
            left = anim8.newAnimation('loop', g('1-2,12'), 0.16),
            right = anim8.newAnimation('loop', g('1-2,11'), 0.16),
        },
        gaze = {
            right = anim8.newAnimation('once', g(5,2), 1),
            left = anim8.newAnimation('once', g(5,1), 1),
        },
        gazewalk = { --state for walking away from the camera
            left = anim8.newAnimation('loop', g('2-3,4'), 0.16),
            right = anim8.newAnimation('loop', g('2-3,4'), 0.16),
        },
        jump = {
            right = anim8.newAnimation('once', g('7,2'), 1),
            left = anim8.newAnimation('once', g('7,1'), 1)
        },
        walk = {
            right = anim8.newAnimation('loop', g('2-4,2', '3,2'), 0.16),
            left = anim8.newAnimation('loop', g('2-4,1', '3,1'), 0.16)
        },
        idle = {
            right = anim8.newAnimation('once', g(1,2), 1),
            left = anim8.newAnimation('once', g(1,1), 1)
        },
        warp = anim8.newAnimation('once', warp('1-4,1'), 0.08),
    }
    return new_plyr
end

return plyr
