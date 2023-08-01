DEBUG, INFO, ERROR, NONE = 1, 2, 3, 4
LOGLEVEL = DEBUG

-- RGB COLOR ALIASES
light_gray = {220, 220, 220, 255}
gray = {190, 190, 190, 255}
dark_gray = {105, 105, 105, 255}
light_yellow = {240, 240, 140, 255}
yellow = {255, 255, 0, 255}
dark_yellow = {128, 128, 0, 255}
cyan = {0, 128, 128, 255}
blue = {0, 0, 255, 255}
brown = {139, 69, 19, 255}
green = {34, 139, 34, 255}
dark_green = {0, 100, 0, 255}


-- This table provides a means for a gmcp.Room.Info.environment 
-- to resolve to {environment_id, color}
ROOM_COLORS = {
  ["outside, city and road"] = {101, dark_gray},
  ["inside and city"] = {102, dark_yellow},
  ["outside and road"] = {103, gray},
  ["outside and city"] = {104, light_yellow},
  ["outside, city, road and beach"] = {105, yellow},
  ["city, road and beach"] = {106, yellow},
  ["sea, city and road"] = {107, cyan},
  ["sea"] = {108, blue},
  ["sea and city"] = {109, cyan},
  ["outside, sea, city and beach"] = {110, yellow},
  ["inside"] = {111, dark_yellow},
  ["outside, forest and road"] = {112, brown},
  ["outside and forest"] = {113, green},
  ["outside and plains"] = {114, dark_yellow},
  ["sea and beach"] = {115, yellow},
  ["forest and path"] = {116, green},
  ["plains"] = {117, dark_yellow},
  ["forest"] = {118, dark_green},
}

-- Amount of space between map squares
MAP_SPACING = 1
-- Width of map pane as a percentage of entire window
MAP_WIDTH = 50
-- Height of map pane as a percentage of entire window
MAP_HEIGHT = 100