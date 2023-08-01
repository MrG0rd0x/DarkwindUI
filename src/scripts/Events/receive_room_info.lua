-- Event Handler: gmcp.Room.Info
function receive_room_info(event)
  display(gmcp.Room.Info)
  debugc("Event triggered for "..event..", called receive_room_info")
  local room_id = getRoomIDbyHash(gmcp.Room.Info.num)
  if room_id > 0 then
    centerview(room_id)
  else
    debugc("Room not found")
  end
  mapper.current_room = room_id
  mapper.current_area = getRoomArea(room_id)
  build_compass(mapper.container)
end