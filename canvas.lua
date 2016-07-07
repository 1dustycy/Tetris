function createBoard()
  board = love.graphics.newCanvas(800, 600)
  love.graphics.setCanvas(board)
  love.graphics.clear()
  love.graphics.setBackgroundColor(255, 255, 255,255)
  love.graphics.setColor(0, 0, 0, 255)
  local x,y = startX*2,startY+size
  love.graphics.rectangle('line',x,y,size*10,size*20)
  local font = love.graphics.newFont("font/wawa.otf",30)
  text1 = love.graphics.newText(font,"下一位：")
  love.graphics.draw(text1,startX+size*12+10,startY+size)
  love.graphics.setCanvas()
end

function constructCanvas()
  local canvas = {}
  local map = {}
  local colorMap = {}

  function canvas:addShape(shape)
    local s = shape:getBoundary().shape
    for i=1,#s do
      table.insert(map,{s[i][1],s[i][2]})
      colorMap[hash2dcoords({s[i][1],s[i][2]},20)] = shape.color
    end
  end

  function canvas:draw()
    local res = {}
    for i=1,#map do
      local c = colorMap[hash2dcoords({map[i][1],map[i][2]},20)]
      table.insert(res,
        (love.graphics.setColor(c[1],c[2],c[3],128))
      )
      table.insert(res,
        (love.graphics.rectangle("fill",startX+size*map[i][2],startY+size*map[i][1],size,size))
      )
      table.insert(res,
        (love.graphics.setBlendMode("screen"))
      )
      table.insert(res,
        (love.graphics.setColor(235,235,235,60))
      )
      table.insert(res,
        (love.graphics.rectangle("line",startX+size*map[i][2],startY+size*map[i][1],size,size))
      )
      table.insert(res,
        (love.graphics.setBlendMode("alpha"))
      )
    end
    return res
  end

  function canvas:getCanvas()
    return map
  end

  function canvas:writeCanvas(newMap,colorList)
    for i=1,#colorList do
      colorMap[colorList[i][2]] = colorMap[colorList[i][1]]
      colorMap[colorList[i][1]] = nil
    end

    map = newMap
  end

  return canvas
end
