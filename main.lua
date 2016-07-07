require "canvas"
require "keyboardAction"
require "screenControl"

function love.load()
  size,startX,startY = 25,25,5
  moveSpeed = .8
  points = 0
  scInit()
  createBoard()
  pointsFont = love.graphics.newFont("font/wawa.otf",16)
  pointsText = love.graphics.newText(pointsFont,"Points: "..points)
  pointsTextX = startX*6
end

function love.draw()
  love.graphics.setBackgroundColor(255,255,255)
  love.graphics.setBlendMode("alpha")
  nextShape:draw()
  canvas:draw()
  currentShape:draw()
  love.graphics.setBlendMode("alpha","premultiplied")
  love.graphics.draw(board)
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.draw(pointsText,pointsTextX,startY)
end

local lastDown = love.timer.getTime()
local totalPassed = 0
function love.update(interval)
  totalPassed = totalPassed + interval
  if totalPassed >= moveSpeed then
    totalPassed = totalPassed - moveSpeed
    if boundaryClash().bottom or bottomClash() then swapShape() end
    pointsText:set("Points: "..points)
    pointsTextX = startX + 155 - pointsText:getWidth()/2
    currentShape:moveAnchor(1,0)
    updateSpeed = .8 - math.floor(points/500)/10
    moveSpeed = updateSpeed >= .2 and updateSpeed or .15
  end
  if love.keyboard.isDown("down") then
    if love.timer.getTime() - lastDown > .07 then
      currentShape:moveDown()
      lastDown = love.timer.getTime()
    end
  end
end
