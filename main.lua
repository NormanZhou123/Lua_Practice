Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

PADDLE_SPEED = 600

function love.load()
  math.randomseed(os.time())
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
  player1Score = 0
  player2Score = 0

  Player1 = Paddle(30, 30, 10, 70)
  Player2 = Paddle(WINDOW_WIDTH-30, WINDOW_HEIGHT-100, 10, 70)

  ball = Ball(WINDOW_WIDTH/2 - 5, WINDOW_HEIGHT/2 - 5, 10, 10)

  gameState = 'start'
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
      player1.dy = PADDLE_SPEED
  else
      player1.dy = 0
  end
  if love.keyboard.isDown('up') then
      player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
      player2.dy = PADDLE_SPEED
  else
      player2.dy = 0
  end

  if gameState == 'play' then
    ball:update(dt)
  end
  player1:update(dt)
  player2:update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState =='start' then
      gameState = 'play'
    else
      gameState = 'start'
      ball:reset()
    end
  end
end

function love.draw()
  --love.graphics.clear(40, 45, 52, 255)
  if gameState == 'start' then
    love.graphics.printf('Get your ass ready!',0,30,WINDOW_WIDTH,'center')
  else
    love.graphics.printf('GO!', 0, 30, WINDOW_WIDTH, 'center')
  end
  love.graphics.print(tostring(player1Score), WINDOW_WIDTH / 2 - 250, WINDOW_HEIGHT/3)
  love.graphics.print(tostring(player1Score), WINDOW_WIDTH / 2 + 220, WINDOW_HEIGHT/3)
  player1:render()
  player2:render()
  ball:render()
end
