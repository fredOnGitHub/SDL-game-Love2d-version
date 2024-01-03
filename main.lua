-- Variables
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
FPS = 60
FRAME_TARGET_TIME = (1000 / FPS)

-- Initialize values for the the ball object
ball = {}
ball.width = 15
ball.height = 15
ball.x = 20
ball.y = 20
ball.vel_x = 300
ball.vel_y = 300

-- Initialize the values for the paddle object
paddle = {}
paddle.width = 100
paddle.height = 20
paddle.x = (WINDOW_WIDTH / 2) - (paddle.width / 2)
paddle.y = WINDOW_HEIGHT - 40
paddle.vel_x = 400

function love.load() -- Start
    love.graphics.setBackgroundColor(0, 0, 0)
end

function love.update(delta_time) -- Tourne en boucle
    input_utilisateur(delta_time)

    -- update ball and paddle position
    ball.x = ball.x + ball.vel_x * delta_time
    ball.y = ball.y + ball.vel_y * delta_time

    -- Check for ball collision with the walls
    if ball.x <= 0 or ball.x + ball.width >= WINDOW_WIDTH then
        ball.vel_x = -ball.vel_x
    end
    if ball.y < 0 then
        ball.vel_y = -ball.vel_y
    end

    -- Check for ball collision with the paddle
    if ball.y + ball.height >= paddle.y and ball.x + ball.width >= paddle.x and ball.x <= paddle.x + paddle.width then
        ball.vel_y = -ball.vel_y
    end
    -- Prevent paddle from moving outside the boundaries of the window
    if paddle.x <= 0 then
        paddle.x = 0;
    end
    if paddle.x >= WINDOW_WIDTH - paddle.width then
        paddle.x = WINDOW_WIDTH - paddle.width
    end

    -- Check for game over
    if ball.y + ball.height > WINDOW_HEIGHT then
        ball.x = WINDOW_WIDTH / 2
        ball.y = 0
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1.0)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
    love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.width, paddle.height)
end

function input_utilisateur(dt)
    -- fps = love.timer.getFPS()
    -- print(fps)
    -- gives after 3 sec : 60 fps
    if love.keyboard.isDown("escape") then
        love.event.quit()
    elseif love.keyboard.isDown("left") then
        paddle.x = paddle.x - dt * paddle.vel_x
    elseif love.keyboard.isDown("right") then
        paddle.x = paddle.x + dt * paddle.vel_x
    end
end

