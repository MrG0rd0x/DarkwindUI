local _, exit_name, exit_dir = unpack(matches)
debugc("Adding exit "..exit_name.." to room "..mapper.current_room.." as "..exit_dir)
create_adjacent_room_custom_direction(mapper.current_room, exit_name, exit_dir)
centerview(mapper.current_room)