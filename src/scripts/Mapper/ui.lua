function open_map_window()
  main.container = Geyser.Container:new({
    x = 0,
    y = 0,
    width="100%",
    height="100%",
    name="main",
  })
  
  mapper.container = Geyser.Mapper:new({
    x = (100 - MAP_WIDTH).."%",
    y = 0,
    width = MAP_WIDTH.."%",
    height = MAP_HEIGHT.."%",
    name="mapper",
  }, main.container)
  
  build_compass(mapper.container)
end

function build_compass(base)
  mapper.compass = mapper.compass or Geyser.Label:new({
    x = "5%",
    y = "10%",
    width = "20%",
    height = "20%",
    name = "mapper.compass",
  }, base)
  
  mapper.compass.grid = mapper.compass or Geyser.HBox:new({
    x = 0,
    y = 0,
    width = "100%",
    height = "100%",
    name = "mapper.compass.grid",
  }, mapper.compass)
  
  mapper.compass.grid.left = mapper.compass.grid.left or Geyser.VBox:new({
    name = "mapper.compass.grid.left"
  }, mapper.compass.grid)
  mapper.compass.nw = mapper.compass.nw or Geyser.Label:new({
    name = "mapper.compass.nw"
  }, mapper.compass.grid.left)
  mapper.compass.w = mapper.compass.w or Geyser.Label:new({
    name = "mapper.compass.w"
  }, mapper.compass.grid.left)
  mapper.compass.sw = mapper.compass.sw or Geyser.Label:new({
    name = "mapper.compass.sw"
  }, mapper.compass.grid.left)

  mapper.compass.grid.center = mapper.compass.grid.center or Geyser.VBox:new({
    name = "mapper.compass.grid.center"
  }, mapper.compass.grid)
  mapper.compass.n = mapper.compass.n or Geyser.Label:new({
    name = "mapper.compass.n"
  }, mapper.compass.grid.center)
  mapper.compass.center = mapper.compass.center or Geyser.Label:new({
    name = "mapper.compass.center"
  }, mapper.compass.grid.center)
  mapper.compass.s = mapper.compass.s or Geyser.Label:new({
    name = "mapper.compass.s"
  }, mapper.compass.grid.center)

  mapper.compass.grid.right = mapper.compass.grid.right or Geyser.VBox:new({
    name = "mapper.compass.grid.right"
  }, mapper.compass.grid)
  mapper.compass.ne = mapper.compass.ne or Geyser.Label:new({
    name = "mapper.compass.ne"
  }, mapper.compass.grid.right)
  mapper.compass.e = mapper.compass.e or Geyser.Label:new({
    name = "mapper.compass.e"
  }, mapper.compass.grid.right)
  mapper.compass.se = mapper.compass.se or Geyser.Label:new({
    name = "mapper.compass.se"
  }, mapper.compass.grid.right)
  
  mapper.compass.nw:setColor(0,0,0)
  mapper.compass.n:setColor(0,0,0)
  mapper.compass.ne:setColor(0,0,0)
  mapper.compass.w:setColor(0,0,0)
  mapper.compass.center:setColor(0,0,0)
  mapper.compass.e:setColor(0,0,0)
  mapper.compass.sw:setColor(0,0,0)
  mapper.compass.s:setColor(0,0,0)
  mapper.compass.se:setColor(0,0,0)
  if verify_room_gmcp then
    update_compass()
  end
end

function mapper.compass.click(name)
  send(name)
end