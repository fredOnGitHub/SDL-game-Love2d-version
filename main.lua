-- Variables
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

vel_ball = 800
vel_paddle = 500

-- Initialize values for the the ball object
ball = {}
ball.width = 15
ball.height = 15
ball.x = 20
ball.y = 20
ball.vel_x = vel_ball
ball.vel_y = vel_ball

-- Initialize the values for the paddle object
paddle = {}
paddle.width = 100
paddle.height = 20
paddle.x = (WINDOW_WIDTH / 2) - (paddle.width / 2)
paddle.y = WINDOW_HEIGHT - 40
paddle.vel_x = vel_paddle

function love.load() -- Start
    love.graphics.setBackgroundColor(0, 0, 0)
    waiting = false
end

function love.update(delta_time) -- Loop

    -- print("dt", delta_time)

    if not waiting then

        input_utilisateur(delta_time)

        FPS = love.timer.getFPS()
        -- print(FPS)
        -- gives 60 fps after 3 sec
        FRAME_TARGET_TIME = (1000 / FPS)

        -- update ball and paddle position
        ball.x = ball.x + ball.vel_x * delta_time
        ball.y = ball.y + ball.vel_y * delta_time

        -- print(string.format("%-5.2f  %-5.2f", ball.x, ball.y))

        if ball.x <= 0 then
            ball.x = 0
            ball.vel_x = -ball.vel_x
        end

        if ball.x + ball.width >= WINDOW_WIDTH then
            ball.x = -ball.width + WINDOW_WIDTH
            ball.vel_x = -ball.vel_x
        end

        if ball.y < 0 then
            ball.y = 0
            ball.vel_y = -ball.vel_y
        end

        -- Check for game over
        if ball.y + ball.height > WINDOW_HEIGHT then
            ball.x = love.math.random(2, WINDOW_WIDTH - ball.width - 2)
            ball.y = 0
            -- print(ball.x)
            d = love.math.random(0, 1) -- 0 or 1
            if d == 0 then ball.vel_y = -ball.vel_y end
        end

        -- Check for ball collision with the paddle
        if ball.y + ball.height >= paddle.y and ball.x + ball.width >= paddle.x and
            ball.x <= paddle.x + paddle.width then
            ball.y = -ball.height + paddle.y
            ball.vel_y = -ball.vel_y
        end

        -- Prevent paddle from moving outside the boundaries of the window
        if paddle.x <= 0 then paddle.x = 0; end
        if paddle.x >= WINDOW_WIDTH - paddle.width then
            paddle.x = WINDOW_WIDTH - paddle.width
        end

    else
        print("wait")
        love.timer.sleep(5)
        waiting = not waiting
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1.0)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
    love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.width,
                            paddle.height)
end

function input_utilisateur(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    elseif love.keyboard.isDown("p") then
        waiting = not waiting
    end
    if love.keyboard.isDown("left") then
        paddle.x = paddle.x - dt * paddle.vel_x
    end
    if love.keyboard.isDown("right") then
        paddle.x = paddle.x + dt * paddle.vel_x
    end
end

-- MacOS (to see console output)
-- clear; /Applications/love.app/Contents/MacOS/love "SDL game - Lua version with paddle"
