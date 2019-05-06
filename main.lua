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

  player1Y = 30
  player2Y = WINDOW_HEIGHT - 100

  ballX = WINDOW_WIDTH/2 - 5
  ballY = WINDOW_HEIGHT/2 - 5

  ballDX = math.random(2) == 1 and 300 or -300
  ballDY = math.random(-50,50)

  gameState = 'start'
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
      player1Y = math.min(WINDOW_HEIGHT - 70, player1Y + PADDLE_SPEED * dt)
  end
  if love.keyboard.isDown('up') then
      player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('down') then
      player2Y = math.min(WINDOW_HEIGHT - 70, player2Y + PADDLE_SPEED * dt)
  end

  if gameState == 'play' then
    ballX = ballX + ballDX * dt
    ballY = ballY + ballDY * dt
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState =='start' then
      gameState = 'play'
    else
      gameState = 'start'
      ballX = WINDOW_WIDTH/2 - 5
      ballY = WINDOW_HEIGHT/2 - 5

      ballDX = math.random(2) == 1 and 300 or -300
      ballDY = math.random(-100,100) * 1.5
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
  love.graphics.rectangle('fill', 30, player1Y, 10, 70)
  love.graphics.rectangle('fill', WINDOW_WIDTH-30, player2Y, 10, 70)
  love.graphics.rectangle('fill', ballX, ballY, 10, 10)
end
