extends Control

func _ready():
    $VBoxContainer/StartButton.connect("pressed",Callable(self,"_on_StartButton_pressed"))
    $VBoxContainer/OptionsButton.connect("pressed",Callable(self,"_on_OptionsButton_pressed"))
    $VBoxContainer/QuitButton.connect("pressed",Callable(self,"_on_QuitButton_pressed"))

func _on_StartButton_pressed():
    get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_OptionsButton_pressed():
    print("Options button pressed")

func _on_QuitButton_pressed():
    get_tree().quit()
