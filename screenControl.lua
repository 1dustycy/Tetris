require "rotaters"
require "shapes"
require "misc"

function boundaryClash()
  local res = {}
  local window = {1,10,20}
  local shapeBoundary = currentShape:getBoundary()
  res.left = shapeBoundary.left == window[1]
  res.right = shapeBoundary.right == window[2]
  res.bottom = shapeBoundary.bottom == window[3]
  return res
end

function leftClash()
  local current = hash2dcoordsList(currentShape:getLeftBoundary(),20)
  local overall = hash2dcoordsList(canvas:getCanvas(),20)
  for k,v in pairs(current) do
    if overall[v] ~= nil then return true end
  end
  return false
end

function rightClash()
  local current = hash2dcoordsList(currentShape:getRightBoundary(),20)
  local overall = hash2dcoordsList(canvas:getCanvas(),20)

  for k,v in pairs(current) do
    if overall[v] ~= nil then return true end
  end
  return false
end

function bottomClash()
  local current = hash2dcoordsList(currentShape:getBottomBoundary(),20)
  local overall = hash2dcoordsList(canvas:getCanvas(),20)
  for k,v in pairs(current) do
    if overall[v] ~= nil then return true end
  end
  return false
end

function rotateBoundaryClash()
  local shapeBoundary = currentShape:getBoundary()
  if shapeBoundary.right > 10 then
    if action then return true else currentShape:moveAnchor(0,10-shapeBoundary.right) end
  end
  if shapeBoundary.left < 1 then
    if action then return true else currentShape:moveAnchor(0,math.abs(shapeBoundary.left-1)) end
  end
  if shapeBoundary.top < 2 then
    if action then return true else currentShape:moveAnchor(math.abs(shapeBoundary.top-1),0) end
  end
end

function rotateClash()
  local afterOffsets = currentShape:getRotateShape(false)
  local anchor = currentShape:getAnchor()
  local newShape = {}
  local map = hash2dcoordsList(canvas:getCanvas(),20)
  for i=1,#afterOffsets do
    table.insert(newShape,
    {anchor[1]+afterOffsets[i][1],anchor[2]+afterOffsets[i][2]}
    )
  end
  for i=1,#newShape do
    if newShape[i][1] > 20 then
      return true
    elseif newShape[i][2] < 1 then
      for i=1,#newShape do
        if map[hash2dcoords({newShape[i][1],newShape[i][2]+1},20)] ~= nil then return true end
      end
    elseif newShape[i][2] > 10 then
      for i=1,#newShape do
        if map[hash2dcoords({newShape[i][1],newShape[i][2]-1},20)] ~= nil then return true end
      end
    elseif newShape[i][1] >= 1 and newShape[i][1] <= 20 and newShape[i][2] >= 1 and newShape[i][2] <= 10 then
      if map[hash2dcoords(newShape[i],20)] ~= nil then return true end
    end
  end
  return false
end

function scanCanvas()
  local overall = hash2dcoordsList(canvas:getCanvas(),20)
  local linedUp = {}
  for i=1,20 do
    if overall[i] then
      local res = 0
      for j=1,9 do
        if overall[i+j*20] == nil then break end
        res = res + 1
      end
      if res == 9 then table.insert(linedUp,i) end
    end
  end
  if #linedUp > 0 then
    points = points +  100 * #linedUp * (1 + round(math.log(#linedUp,3),2))
    killLine(linedUp,overall)
  end
end

function killLine(victim,old)
  table.sort(victim, function (a,b) return (a > b) end)
  local new = old
  local colorList = {}
  for i=1,#victim do
    new[victim[i]+i-1] = nil
    for j=20,180,20 do
      new[victim[i]+j+i-1] = nil
    end
    local tempList = {}
    for k,v in pairs(new) do
      table.insert(tempList,v)
    end
    table.sort(tempList,function (a,b) return (hash2dcoordsReversed(a,20)[1] > hash2dcoordsReversed(b,20)[1]) end)
    for k=1,#tempList do
      if hash2dcoordsReversed(tempList[k],20)[1] < victim[i]+i-1 then
        new[tempList[k]] = nil
        new[tempList[k]+1] = tempList[k]+1
        table.insert(colorList,{tempList[k],tempList[k]+1})
      end
    end
  end
  canvas:writeCanvas(hash2dcoordsListReversed(new,20),colorList)
end

function scInit()
  canvas = constructCanvas()
  currentShape = constructShape()
  nextShape = constructNextShape()
end

function gameover()
  local map = hash2dcoordsList(canvas:getCanvas(),20)
  for i=1,181,20 do
    if map[i] ~= nil then
      canvas = nil
      currentShape = nil
      nextShape = nil
      moveSpeed = 0.8
      points = 0
      canvas = constructCanvas()
      currentShape = constructShape()
      nextShape = constructNextShape()
    end
  end

end

function swapShape()
  canvas:addShape(currentShape)
  scanCanvas()
  currentShape = nextShape
  local time = love.timer.getTime()
  currentShape:moveAnchor(-3,-8)
  nextShape = constructNextShape()
  gameover()
end
