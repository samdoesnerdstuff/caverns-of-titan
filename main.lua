-- Entrypoint for Caverns of Titan
-- (c) 2025 samdoesnerdstuff
-- SPDX-License-Identifier: Apache-2.0

local player = require("scripts/player")

function love.load()
    player:load()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end
