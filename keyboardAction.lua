
function love.keypressed(key)
  if key == "up" then currentShape:rotate()
  elseif key == "left" then currentShape:moveLeft()
  elseif key == "right" then currentShape:moveRight()
  end
end
