extends Node

func _ready():
    var save_game = preload("res://scripts/save_game.gd").new()
    add_child(save_game)
    save_game.name = "SaveGame"
