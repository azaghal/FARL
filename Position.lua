local Position = {}
function Position.add(pos1, pos2)
    return { x = pos1.x + pos2.x, y = pos1.y + pos2.y}
end

function Position.subtract(pos1, pos2)
    return { x = pos1.x - pos2.x, y = pos1.y - pos2.y}
end

function Position.equals(pos1, pos2)
    return pos1.x == pos2.x and pos1.y == pos2.y
end

Position._translate = {
    [0] = { x = 0, y = -1},
    [1] = { x = 1, y = -1},
    [2] = { x = 1, y = 0},
    [3] = { x = 1, y = 1},

    [4] = { x = 0, y = 1},
    [5] = { x = -1, y = 1},
    [6] = { x = -1, y = 0},
    [7] = { x = -1, y = -1},
}
--!this will mess up diagonal rails if the distance isn't a multiple of 2..
function Position.translate(pos, distance, direction)
    local t = Position._translate[direction]
    return {x = pos.x + distance * t.x, y = pos.y + distance * t.y}
end

function Position.expand_to_area(pos, radius)
    if #pos == 2 then
        return { left_top = { x = pos[1] - radius, y = pos[2] - radius }, right_bottom = { x = pos[1] + radius, y = pos[2] + radius } }
    end
    return { left_top = { x = pos.x - radius, y = pos.y - radius}, right_bottom = { x = pos.x + radius, y = pos.y + radius } }
end

function Position.distance_squared(pos1, pos2)
    local axbx = pos1.x - pos2.x
    local ayby = pos1.y - pos2.y
    return axbx * axbx + ayby * ayby
end

function Position.distance(pos1, pos2)
    return math.sqrt(Position.distance_squared(pos1, pos2))
end

local to_rad = math.pi / 180
function Position.rotate(v, degree)
    local cos = math.cos(degree * to_rad)
    local sin = math.sin(degree * to_rad)
    return {x = cos * v.x - sin * v.y,
            y = sin * v.x + cos * v.y}
end

return Position