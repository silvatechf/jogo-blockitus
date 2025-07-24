extends Control

func _ready():
    $VBoxContainer/RestartButton.connect("pressed",Callable(self,"_on_RestartButton_pressed"))
    $VBoxContainer/MainMenuButton.connect("pressed",Callable(self,"_on_MainMenuButton_pressed"))

func _on_RestartButton_pressed():
    get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_MainMenuButton_pressed():
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
