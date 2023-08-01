-- Event Handler: sysLoadEvent
function init_mapper()
  mudlet = mudlet or {}
  mudlet.mapper_script = true
  mapper = mapper or {}
  main = main or {}
  
  open_map_window()

  setRoomCoordinates(mapper.current_room, 0, 0, 0)
  setAreaUserData(area_id, "center", tostring(room_id))
  centerview(mapper.current_room)
end

function new_map()
  if not verify_room_gmcp() then
    echo("No GMCP info.")
    return
  end

  local area_id = get_or_create_area("Darkwind City")
  mapper.current_area = area_id
  local room_id = create_room(gmcp.Room.Info.num)
  mapper.current_room = room_id
  
  setAreaUserData(area_id, "center", tostring(room_id))
  centerview(room_id)
end