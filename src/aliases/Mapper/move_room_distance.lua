local _, direction, distance = unpack(matches)
move_room(mapper.current_room, direction, distance)
centerview(mapper.current_room)