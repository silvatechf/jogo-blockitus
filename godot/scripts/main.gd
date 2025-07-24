extends Node2D

var grid
var current_block

func _ready():
    grid = get_node("Grid")
    add_child(grid)
    spawn_block()

func _process(delta):
    if Input.is_action_just_pressed("ui_left"):
        current_block.move_left()
    if Input.is_action_just_pressed("ui_right"):
        current_block.move_right()
    if Input.is_action_just_pressed("ui_down"):
        current_block.move_down()
    if Input.is_action_just_pressed("ui_accept"):
        current_block.rotate()

func spawn_block():
    var block_scene = preload("res://scenes/block.tscn")
    current_block = block_scene.instantiate()
    add_child(current_block)
