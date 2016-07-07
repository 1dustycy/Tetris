function getShapeParam(shape)
  local shapes = {
    hline  = {
      {{0,-2},{0,-1},{0,0},{0,1}},
      hlineRotater,
      {255,255,0}
    },
    cube = {
      {{0,-1},{1,-1},{1,0},{0,0}},
      cubeRotater,
      {140,255,0}
    },
    zl = {
      {{0,-1},{1,0},{0,0},{1,1}},
      zlRotater,
      {255,89,0}
    },
    zr = {
      {{0,1},{1,0},{0,0},{1,-1}},
      zrRotater,
      {255,25,0}
    },
    ll = {
      {{-1,-1},{-1,0},{0,0},{1,0}},
      llRotater,
      {0,47,255}
    },
    rl = {
      {{-1,1},{-1,0},{0,0},{1,0}},
      rlRotater,
      {0,221,255}
    },
    fu = {
      {{1,0},{0,0},{0,-1},{0,1}},
      fuRotater,
      {85,0,255}
    }
  }
 return shapes[shape][1],shapes[shape][2],shapes[shape][3]
end

function getRandomShape()
  local list = {"hline","cube","zl","zr","ll","rl","fu"}
  math.randomseed(love.timer.getTime())
  return list[math.random(1,#list)]
end
function constructShape()
  local shape = {}
  local shapeName = getRandomShape()
  shape.offsets,shape.rotater,shape.color = getShapeParam(shapeName)
  shape.anchor = shapeName == "rl" and {2,6} or shapeName =="ll" and {2,6} or {1,6}
  function shape:getBoundary()
    local res = {}
    local xmin,xmax,ymax,ymin = shape.offsets[1][2],shape.offsets[1][2],shape.offsets[1][1],shape.offsets[1][1]
    for i=2,4 do
      xmin = shape.offsets[i][2] < xmin and shape.offsets[i][2] or xmin
      xmax = shape.offsets[i][2] > xmax and shape.offsets[i][2] or xmax
      ymax = shape.offsets[i][1] > ymax and shape.offsets[i][1] or ymax
      ymin = shape.offsets[i][1] < ymin and shape.offsets[i][1] or ymin
    end

    res.left,res.right,res.bottom,res.top =
    shape.anchor[2]+xmin,shape.anchor[2]+xmax,shape.anchor[1]+ymax,shape.anchor[1]+ymin
    res.shape = {}
    for i=1,#shape.offsets do
      table.insert(res.shape,{shape.anchor[1]+shape.offsets[i][1],shape.anchor[2]+shape.offsets[i][2]})
    end
    return res
  end

  function shape:getLeftBoundary()
    local leftBoundary = {}
    local currentShape = shape:getBoundary().shape
    for i=1,#currentShape do
      table.insert(leftBoundary,{currentShape[i][1],currentShape[i][2]-1})
    end
    return leftBoundary
  end

  function shape:getRightBoundary()
    local rightBoundary = {}
    local currentShape = shape:getBoundary().shape
    for i=1,#currentShape do
      table.insert(rightBoundary,{currentShape[i][1],currentShape[i][2]+1})
    end
    return rightBoundary
  end

  function shape:getBottomBoundary()
    local bottomBoundary = {}
    local currentShape = shape:getBoundary().shape
    for i=1,#currentShape do
      table.insert(bottomBoundary,{currentShape[i][1]+1,currentShape[i][2]})
    end
    return bottomBoundary
  end

  function shape:moveAnchor(y,x)
    local y = y or 0
    local x = x or 0
    shape.anchor[1] = shape.anchor[1]+y
    shape.anchor[2] = shape.anchor[2]+x
  end

  function shape:moveLeft()
    if not boundaryClash().left and not leftClash() then
      shape:moveAnchor(0,-1)
    end
  end

  function shape:moveRight()
    if not boundaryClash().right and not rightClash() then
      shape:moveAnchor(0,1)
    end
  end

  function shape:moveDown()
    if not boundaryClash().bottom and not bottomClash() then
      shape:moveAnchor(1,0)
    end
  end

  function shape:rotate()
    if not rotateClash() then
      if not rotateBoundaryClash() then
        shape.rotater(self,true)
        rotateBoundaryClash()
      end
    end
  end

  function shape:getRotateShape()
    return shape.rotater(self,false)
  end

  function shape:getAnchor()
    return shape.anchor
  end

  function shape:writeOffsets(newOffsets)
    shape.offsets = newOffsets
  end

  function shape:getOffsets()
    return shape.offsets
  end

  function shape:draw()
    local res = {}
    local s = shape:getBoundary().shape
    for i=1,#s do
      table.insert(res,
        (love.graphics.setColor(shape.color[1],shape.color[2],shape.color[3],128))
      )
      table.insert(res,
        (love.graphics.rectangle("fill",startX+size*(s[i][2]),startY+size*(s[i][1]),size,size))
      )
      table.insert(res,
        (love.graphics.setBlendMode("screen"))
      )
      table.insert(res,
        (love.graphics.setColor(235,235,235,60))
      )
      table.insert(res,
        (love.graphics.rectangle("line",startX+size*(s[i][2]),startY+size*(s[i][1]),size,size))
      )
      table.insert(res,
        (love.graphics.setBlendMode("alpha"))
      )
    end
    return res
  end
  return shape
end

function constructNextShape()
  local res = constructShape()
  res:moveAnchor(2,8)
  currentShape:moveAnchor(0,0)
  return res
end
