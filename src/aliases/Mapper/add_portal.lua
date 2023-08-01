local _, portal_cmd, exit_hash, exit_dir = unpack(matches)
exit_dir = exit_dir:gsub("%s+", "")
debugc("Adding portal '"..portal_cmd.."' to room hash "..exit_hash.." to "..mapper.current_room.." as "..exit_dir)
create_portal_room(mapper.current_room, portal_cmd, exit_hash, exit_dir)
centerview(mapper.current_room)

