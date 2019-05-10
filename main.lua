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

  sounds = {
    ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
  }

  player1Score = 0
  player2Score = 0

  player1 = Paddle(30, 30, 10, 70)
  player2 = Paddle(WINDOW_WIDTH-30, WINDOW_HEIGHT-100, 10, 70)

  ball = Ball(WINDOW_WIDTH/2 - 5, WINDOW_HEIGHT/2 - 5, 10, 10)

  servingPlayer = 1

  gameState = 'start'
end

function love.update(dt)
  if gameState == 'serve' then
    ball.dy = math.random(-150, 150)
    if servingPlayer == 1 then
      ball.dx = math.random(240, 300)
    else
      ball.dx = -math.random(240, 300)
    end

  elseif gameState == 'play' then
    if ball:collides(player1) then
      ball.dx = -ball.dx * 1.03
      ball.x = player1.x + 10

      if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
      sounds.paddle_hit:play()
    end
    if ball:collides(player2) then
      ball.dx = -ball.dx * 1.03
      ball.x = player2.x -9

      if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
      sounds.paddle_hit:play()
    end
    if ball.y <= 0 then
      ball.y = 0
      ball.dy = -ball.dy
      sounds.wall_hit:play()
    end
    if ball.y >= WINDOW_HEIGHT - 10 then
      ball.y = WINDOW_HEIGHT - 10
      ball.dy = -ball.dy
      sounds.wall_hit:play()
    end


    if ball.x < 0 then
      servingPlayer = 1
      player2Score = player2Score + 1
      sounds.score:play()
      if player2Score == 10 then
        winningPlayer = 2
        gameState = 'done'
      else
        gameState = 'serve'
        ball:reset()
      end
    end

    if ball.x > WINDOW_WIDTH then
      servingPlayer = 2
      player1Score = player1Score + 1
      sounds.score:play()
      if player1Score == 10 then
        winningPlayer = 1
        gameState = 'done'
      else
        gameState = 'serve'
        ball:reset()
      end
    end
  end

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
      gameState = 'serve'
    elseif gameState == 'serve' then
      gameState = 'play'

    elseif gameState == 'done' then
      gameState = 'serve'
      ball:reset()

      player1Score = 0
      player2Score = 0
      if winningPlayer == 1 then
        servingPlayer = 2
      else
        servingPlayer = 1
      end
    end
  end
end

function love.draw()
  if gameState == 'start' then
    love.graphics.printf('Get your ass ready!',0,30,WINDOW_WIDTH,'center')
  elseif gameState == 'serve' then
    love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 0, 30, WINDOW_WIDTH, 'center')
  elseif gameState == 'play' then
  elseif gameState == 'done' then
    love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
        0, 30, WINDOW_WIDTH, 'center')
    love.graphics.printf('Press Enter to restart!', 0, 50, WINDOW_WIDTH, 'center')
  end
  love.graphics.print(tostring(player1Score), WINDOW_WIDTH / 2 - 250, WINDOW_HEIGHT/3)
  love.graphics.print(tostring(player2Score), WINDOW_WIDTH / 2 + 220, WINDOW_HEIGHT/3)
  player1:render()
  player2:render()
  ball:render()
end
