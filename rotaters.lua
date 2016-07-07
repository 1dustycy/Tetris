function hlineRotater(obj,action)
  local offsets = obj:getOffsets()
  if offsets[1][1] == 0 and offsets[1][2] == -2 then
    if action then obj:writeOffsets({{-2,0},{-1,0},{0,0},{1,0}}) else
      return {{-2,0},{-1,0},{0,0},{1,0}}
    end
  else
    if action then obj:writeOffsets({{0,-2},{0,-1},{0,0},{0,1}}) else
      return {{0,-2},{0,-1},{0,0},{0,1}}
    end
  end
end

function cubeRotater(obj)
  return {{0,-1},{1,-1},{1,0},{0,0}}
end

function zlRotater(obj,action)
  local offsets = obj:getOffsets()
  if offsets[1][1] == 0 and offsets[1][2] == -1 then
    if action then obj:writeOffsets({{-1,0},{0,0},{0,-1},{1,-1}}) else
      return {{-1,0},{0,0},{0,-1},{1,-1}}
    end
  else
    if action then obj:writeOffsets({{0,-1},{1,0},{0,0},{1,1}}) else
      return {{0,-1},{1,0},{0,0},{1,1}}
    end
  end
end

function zrRotater(obj,action)
  local offsets = obj:getOffsets()
  if offsets[1][1] == 0 and offsets[1][2] == 1 then
    if action then obj:writeOffsets({{-1,-1},{0,-1},{0,0},{1,0}}) else
      return {{-1,-1},{0,-1},{0,0},{1,0}}
    end
  else
    if action then obj:writeOffsets({{0,1},{1,0},{0,0},{1,-1}}) else
      return {{0,1},{1,0},{0,0},{1,-1}}
    end
  end
end

function llRotater(obj,action)
  local offsets = obj:getOffsets()
  if offsets[1][1] == -1 and offsets[1][2] == -1 then
    if action then obj:writeOffsets({{-1,1},{0,1},{0,0},{0,-1}}) print(1) else
      return {{-1,1},{0,1},{0,0},{0,-1}}
    end
  elseif offsets[1][1] == -1 and offsets[1][2] == 1 then
    if action then obj:writeOffsets({{-1,0},{0,0},{1,0},{1,1}}) else
      return {{-1,0},{0,0},{1,0},{1,1}}
    end
  elseif offsets[1][1] == -1 and offsets[1][2] == 0 then
    if action then obj:writeOffsets({{1,-1},{0,-1},{0,0},{0,1}}) else
      return {{1,-1},{0,-1},{0,0},{0,1}}
    end
  else
    if action then obj:writeOffsets({{-1,-1},{-1,0},{0,0},{1,0}}) else
      return {{-1,-1},{-1,0},{0,0},{1,0}}
    end
  end
end

function rlRotater(obj,action)
  local offsets = obj:getOffsets()
  if offsets[1][1] == -1 and offsets[1][2] == 1 then
    if action then obj:writeOffsets({{0,-1},{0,0},{0,1},{1,1}}) else
      return {{0,-1},{0,0},{0,1},{1,1}}
    end
  elseif offsets[1][1] == 0 and offsets[1][2] == -1 then
    if action then obj:writeOffsets({{-1,0},{0,0},{1,0},{1,-1}}) else
      return {{-1,0},{0,0},{1,0},{1,-1}}
    end
  elseif offsets[1][1] == -1 and offsets[1][2] == 0 then
    if action then obj:writeOffsets({{-1,-1},{0,-1},{0,0},{0,1}}) else
      return {{-1,-1},{0,-1},{0,0},{0,1}}
    end
  else
    if action then obj:writeOffsets({{-1,1},{-1,0},{0,0},{1,0}}) else
      return {{-1,1},{-1,0},{0,0},{1,0}}
    end
  end
end

function fuRotater(obj,action)
  local offsets = obj:getOffsets()
  if offsets[1][1] == 1 and offsets[1][2] == 0 then
    if action then obj:writeOffsets({{0,-1},{0,0},{1,0},{-1,0}}) else
      return {{0,-1},{0,0},{1,0},{-1,0}}
    end
  elseif offsets[1][1] == 0 and offsets[1][2] == -1 then
    if action then obj:writeOffsets({{-1,0},{0,0},{0,-1},{0,1}}) else
      return {{-1,0},{0,0},{0,-1},{0,1}}
    end
  elseif offsets[1][1] == -1 and offsets[1][2] == 0 then
    if action then obj:writeOffsets({{0,1},{0,0},{-1,0},{1,0}}) else
      return {{0,1},{0,0},{-1,0},{1,0}}
    end
  else
    if action then obj:writeOffsets({{1,0},{0,0},{0,-1},{0,1}}) else
      return {{1,0},{0,0},{0,-1},{0,1}}
    end
  end
end
