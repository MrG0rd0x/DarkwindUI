function verify_room_gmcp()
  if not gmcp or not gmcp.Room or not gmcp.Room.Info then
    debug("No current area info in room payload")
    return false
  end
  return true
end

function get_coords(coords, dir, distance)
  if distance == nil then
    distance = MAP_SPACING
  end
  local x, y, z = unpack(coords)
  local coord_map = {
    ["sw"] = function (x, y, z) return x - distance, y - distance, z end,
    ["southwest"] = function (x, y, z) return x - distance, y - distance, z end,
    ["s"] = function (x, y, z) return x, y - distance, z end,
    ["south"] = function (x, y, z) return x, y - distance, z end,
    ["se"] = function (x, y, z) return x + distance, y - distance, z end,
    ["southeast"] = function (x, y, z) return x + distance, y - distance, z end,
    ["w"] = function (x, y, z) return x - distance, y, z end,
    ["west"] = function (x, y, z) return x - distance, y, z end,
    ["e"] = function (x, y, z) return x + distance, y, z end,
    ["east"] = function (x, y, z) return x + distance, y, z end,
    ["nw"] = function (x, y, z) return x - distance, y + distance, z end,
    ["northwest"] = function (x, y, z) return x - distance, y + distance, z end,
    ["n"] = function (x, y, z) return x, y + distance, z end,
    ["north"] = function (x, y, z) return x, y + distance, z end,
    ["ne"] = function (x, y, z) return x + distance, y + distance, z end,
    ["northeast"] = function (x, y, z) return x + distance, y + distance, z end,
    ["u"] = function (x, y, z) return x, y, z + distance end,
    ["up"] = function (x, y, z) return x, y, z + distance end,
    ["d"] = function (x, y, z) return x, y, z - distance end,
    ["down"] = function (x, y, z) return x, y, z - distance end,
  }
  coord_func = coord_map[dir]
  if coord_func == nil then
    return {nil, nil, nil}, "Unrecognized exit: "..dir
  end
  
  return {coord_func(x, y, z)}, nil
end

function error(...)
  if LOGLEVEL <= ERROR then
    fg("red")
    echo("ERROR: "..unpack(arg).."\n")
    resetFormat()
  end
end

function info(...)
  if LOGLEVEL <= INFO then
    fg("yellow")
    echo("INFO: "..unpack(arg).."\n")
    resetFormat()
  end
end

function debug(...)
  if LOGLEVEL <= DEBUG then
    fg("green")
    echo("DEBUG: "..unpack(arg).."\n")
    resetFormat()
  end
end

function invert_dir(dir)
  local invert_map = {
    nw = "se",
    northwest = "southeast",
    n = "s",
    north = "south",
    ne = "sw",
    northeast = "southwest",
    w = "e",
    west = "east",
    e = "w",
    east = "west",
    sw = "ne",
    southwest = "northeast",
    s = "n",
    south = "north",
    se = "nw",
    southeast = "northwest"
  }
  return invert_map[dir]
end