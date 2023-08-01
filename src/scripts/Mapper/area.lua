function get_or_create_area(area_name)
  local area_id = getAreaTable()[area_name]
  if not area_id then
    area_id = addAreaName(area_name)
    debug("Created new area "..area_name.."("..area_id..")")
  end

  return area_id
end