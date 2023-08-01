echo("Commands:\n")
echo("  map init\n")
echo("  map new area NAME EXIT_DIRECTION\n")
echo("  map add room\n")
echo("  map add exit NAME DIRECTION\n")
echo("  map add portal NAME NEXT_ROOM_HASH DIRECTION")
echo("  map move room DIRECTION\n")
echo("  map move room DIRECTION DISTANCE\n")

-- TODO: Capture /^map .*/ to do subcommands accordingly