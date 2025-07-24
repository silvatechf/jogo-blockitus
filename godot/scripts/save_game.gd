extends Node

var coins = 0
var unlocked_themes = ["default"]
var unlocked_soundtracks = ["default"]

func save_game():
    var file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
    file.store_var(coins)
    file.store_var(unlocked_themes)
    file.store_var(unlocked_soundtracks)
    file.close()

func load_game():
    var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
    if file:
        coins = file.get_var()
        unlocked_themes = file.get_var()
        unlocked_soundtracks = file.get_var()
        file.close()
