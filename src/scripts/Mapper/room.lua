function create_current_room()
  if not verify_room_gmcp() then
    echo("\nSomething went wrong acquire GMCP room info.\n")
    echo("\nIf you've just logged in, leave the room and come back.\n")
    echo("\nEnsure that GMCP is enabled in Mudlet.\n")
    return -1
  end
  
  local room_id = getRoomIDbyHash(gmcp.Room.Info.num)
  if room_id ~= -1 then
    debugc("Will not create; room already exists")
  else
    debugc("Room does not exist; creating...")
    room_id = create_room(gmcp.Room.Info.num)
  end
  
  update_room(room_id, gmcp.Room.Info.name, gmcp.Room.Info.exits)

  centerview(room_id)
  mapper.current_room = room_id
  return room_id
end

function update_room(room_id, name, exits)
  debugc("Updating room "..room_id.." ("..name..")")
  setRoomName(room_id, name)
  set_room_env(room_id)
  for exit_dir, exit_hash in pairs(exits) do
    debugc("Discovered exit to "..exit_dir)
    local next_room = create_adjacent_room(room_id, exit_hash, exit_dir)
    if next_room > 0 then
      debugc("Creating exit...")
      setExit(room_id, next_room, exit_dir)
      debugc("Exit to "..exit_dir.." now linked to "..next_room)
    else
      debugc("Something went wrong with exit to"..exit_dir.."; skipping...")
    end
  end  
end

function create_adjacent_room(room_id, exit_hash, exit_dir)
  local current_coords = {getRoomCoordinates(room_id)}
  local coords, err = get_coords(current_coords, exit_dir)
  if err ~= nil then
    debugc("Recieved error on direction lookup: "..err)
    echo("Exit for '"..exit_dir.."' must be created by hand.\n")
    echo("  map add exit "..exit_dir.." DIR\n")
    echo("Where DIR is the direction the exit will be linked on the map.\n")
    return -1
  end
  
  local next_room = getRoomIDbyHash(exit_hash)
  if next_room < 0 then
    debugc("Room at exit "..exit_dir.." is not on map")
    next_room = create_room(exit_hash)
    debugc("Created room "..next_room.." for "..exit_dir.." exit")
  else
    debugc("Room at exit "..exit_dir.." already exists ("..next_room..")")
  end
  
  local x, y, z = getRoomCoordinates(next_room)
  if x == 0 and y == 0 and z == 0 then
    local center = getAreaUserData(mapper.current_area, "center")
    if tonumber(center) ~= next_room then
      local newx, newy, newz = unpack(coords)
      debugc("Assignging new room at "..exit_dir.." coordinates "..newx..","..newy..","..newz)
      setRoomCoordinates(next_room, newx, newy, newz)
    end      
  end
  return next_room
end

function create_adjacent_room_custom_direction(room_id, exit_name, exit_dir)
  local exit_hash = gmcp.Room.Info.exits[exit_name]
  if exit_hash == nil then
    echo("Exit "..exit_name.." not found.")
    return -1
  end
  local next_room = create_adjacent_room(room_id, exit_hash, exit_dir)
  if next_room > 0 then
      debugc("Creating exit...")
      addSpecialExit(room_id, next_room, exit_name)
      setExit(room_id, next_room, exit_dir)
      debugc("Exit to "..exit_dir.." now linked to "..next_room)
    else
      debugc("Something went wrong with exit to"..exit_dir.."; skipping...")
    end
  return next_room
end

function create_portal_room(room_id, portal_cmd, exit_hash, exit_dir)
  local next_room = create_adjacent_room(room_id, exit_hash, exit_dir)
  if next_room > 0 then
    addSpecialExit(room_id, next_room, portal_cmd)
    setExit(room_id, next_room, exit_dir)
    debugc("Exit to "..exit_dir.." now linked to "..next_room)
  else
    debug("Something went wrong")    
  end
end

function create_room(room_hash)
  local room_id = createRoomID()
  addRoom(room_id)
  setRoomIDbyHash(room_id, room_hash)
  setRoomArea(room_id, mapper.current_area)
  debugc("Created new room "..room_hash.."("..room_id..")")
  return room_id
end

function move_room(room_id, dir, distance)
  if distance == nil then
    distance = MAP_SPACING
  end
  debugc("Moving room "..room_id.." "..dir.." by "..distance)
  local current_coords = {getRoomCoordinates(room_id)}
  local coords, err = get_coords(current_coords, dir, distance)
  if err ~= nil then
    debugc("Recieved error on direction lookup: "..err)
    echo("Invalid direction "..dir.."\n")
    return -1
  end
  local x, y, z = unpack(coords)
  debugc("Moving room "..dir.." to coordinates "..x..","..y..","..z)
  setRoomCoordinates(room_id, x, y, z)
end

function set_room_env(room_id)
  room_env = ROOM_COLORS[gmcp.Room.Info.environment]
  if room_env == nil then
    error("This room has no config for its environment '"..gmcp.Room.Info.environment.."'")
    return
  end
  local env_id, env_color = unpack(room_env)
  if getCustomEnvColorTable()[env_id] == nil then
    setCustomEnvColor(env_id, unpack(env_color))
  end
  setRoomEnv(room_id, env_id)
end

function move_room_new_area(room_id, area_name)
  -- Create new area, move room
  local old_coords = {getRoomCoordinates(room_id)}
  local old_area = getRoomArea(room_id)
  local area_id = get_or_create_area(area_name)
  setRoomArea(room_id, area_id)
  mapper.current_area = area_id
  setAreaUserData(area_id, "center", tostring(room_id))
  centerview(room_id)
end

function update_compass()
  -- Reset position; forces redraw
  mapper.compass:move("5%", "10%")
  
  -- Clear
  mapper.compass.nw:echo("")
  mapper.compass.n:echo("")
  mapper.compass.ne:echo("")
  mapper.compass.w:echo("")
  mapper.compass.center:echo("")
  mapper.compass.e:echo("")
  mapper.compass.sw:echo("")
  mapper.compass.s:echo("")
  mapper.compass.se:echo("")
  mapper.compass.nw:setColor(0,0,0)
  mapper.compass.n:setColor(0,0,0)
  mapper.compass.ne:setColor(0,0,0)
  mapper.compass.w:setColor(0,0,0)
  mapper.compass.center:setColor(105,105,105)
  mapper.compass.e:setColor(0,0,0)
  mapper.compass.sw:setColor(0,0,0)
  mapper.compass.s:setColor(0,0,0)
  mapper.compass.se:setColor(0,0,0)

  
  LONG_DIRECTION_MAP = {
    northwest = "nw",
    north = "n",
    northeast = "ne",
    west = "w",
    east = "e",
    southwest = "sw",
    south = "s",
    southeast = "se",
  }
  
  for exit_dir, room_id in pairs(getRoomExits(mapper.current_room)) do
    if LONG_DIRECTION_MAP[exit_dir] then
      exit_dir = LONG_DIRECTION_MAP[exit_dir]
    end
    if mapper.compass[exit_dir] then
      special_exit = getSpecialExits(mapper.current_room)[room_id]
      if special_exit then
        exit_name, _ = next(special_exit)
        mapper.compass[exit_dir]:setColor(200,200,200)
        mapper.compass[exit_dir]:echo(exit_name)
        mapper.compass[exit_dir]:setFormat("cb18")
        mapper.compass[exit_dir]:setFgColor("black")
        local maxw = mapper.compass[exit_dir]:get_width()
        local w, _ = mapper.compass[exit_dir]:getSizeHint()
        local font_size = 18
        while w > maxw do
          font_size = font_size - 1
          mapper.compass[exit_dir]:setFontSize(font_size)
          w, _ = mapper.compass[exit_dir]:getSizeHint()
        end
      else
        mapper.compass[exit_dir]:setColor(200,200,200)
      end
    end  
  end 
end