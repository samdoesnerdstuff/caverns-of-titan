-- (c) 2025 samdoesnerdstuff
-- SPDX-License-Identifier: Apache-2.0

local player = {
    x = 0,
    y = 0,
    speed = 64,
    direction = "right",
    sprite = nil,
    quads = {},
    curr_anim = nil,
    curr_frame = 1,
    frame_time = 0.1,
    timer = 0
}

function player:load()
    self.sprite = love.graphics.newImage("(player spritesheet here)")

    local frame_width, frame_height = 32, 32
    local img_width, img_height = self.sprite:getWidth(), self.sprite:getHeight()

    local quads = {}
    for y = 0, img_height - frame_height, frame_height do
        local row = {}
        for x = 0, img_width - frame_width, frame_width do
            table.insert(row. love.graphics.newQuad(x, y, frame_width, frame_height, img_width, img_height))
        end
        table.insert(quads, row)
    end

    --definition of animations and by extension, the spritesheet
    self.animations = {
        -- Idling
        idle_right = {},
        idle_left = {},
        idle_up = {},
        idle_down = {},

        -- Walking / running
        walking_right = {},
        walking_left = {},
        walking_up = {},
        walking_down = {},
    }
end

function player:set_animation(name)
    if self.curr_anim ~= name then
        self.curr_anim = name
        self.curr_frame = 1
        self.timer = 0
    end
end

function player:update(dt)
    local moving = false

    if love.keyboard.isDown("right", "d") then
        self.x = self.x + self.speed * dt
        moving = true
    elseif love.keyboard.isDown("left", "a") then
        self.x = self.x - self.speed * dt
        moving = true
    end

    if love.keyboard.isDown("down", "s") then
        self.y = self.y + self.speed * dt
        moving = true
    elseif love.keyboard.isDown("up", "w") then
        self.y = self.y - self.speed * dt
        moving = true
    end

    -- check/switch animation
    if moving then
        if self.direction == "right" then
            self.set_animation("walking_right")
        elseif self.direction == "left" then
            self.set_animation("walking_left")
        elseif self.direction == "up"
            self.set_animation("walking_up")
        elseif self.direction == "down"
            self.set_animation("walking_down")
        else end
    else
        if self.direction == "right" then
            self.set_animation("idle_right")
        elseif self.direction == "left" then
            self.set_animation("idle_left")
        elseif self.direction == "up"
            self.set_animation("idle_up")
        elseif self.direction == "down"
            self.set_animation("idle_down")
        else end
    end
end

function player:draw()
    local anim = self.animations[self.curr_anim]
    local frame = anim.frames[self.curr_frame]
    love.graphics.draw(self.sprite, frame, self.x, self.y)
end

return player