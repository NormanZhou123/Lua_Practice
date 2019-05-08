Ball = Class{}

function Ball:init(x,y,width,height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  self.dx = math.random(2) == 1 and 300 or -300
  self.dy = math.random(-100, 100)

end

function Ball:reset()
  self.x = WINDOW_WIDTH/2 -5
  self.y = WINDOW_HEIGHT/2 -5
  self.dx = math.random(2) == 1 and 300 or -300
  self.dy = math.random(-100, 100)
end

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
