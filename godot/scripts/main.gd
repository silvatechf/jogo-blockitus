extends Node2D

enum GameMode { CLASSIC, BLITZ, ZEN, CHALLENGE }

var grid
var current_block
var gravity = 1.0
var gravity_direction = Vector2(0, 1)
var game_mode = GameMode.CLASSIC
var time_limit = 120 # For Blitz mode
var score = 0
var save_game

func _ready():
    print("Main scene ready.")
    save_game = get_node("/root/SaveGame")
    save_game.load_game()
    grid = get_node("Grid")
    spawn_block()
    var timer = Timer.new()
    timer.wait_time = 5
    timer.autostart = true
    timer.connect("timeout",Callable(self,"trigger_gravity_event"))
    add_child(timer)

func _process(delta):
    if game_mode == GameMode.BLITZ:
        time_limit -= delta
        if time_limit <= 0:
            end_game()

    if Input.is_action_just_pressed("ui_left"):
        current_block.move_left()
        Input.start_joy_vibration(0, 0.5, 0.5, 0.1)
    if Input.is_action_just_pressed("ui_right"):
        current_block.move_right()
        Input.start_joy_vibration(0, 0.5, 0.5, 0.1)
    if Input.is_action_just_pressed("ui_down"):
        current_block.move_down()
        Input.start_joy_vibration(0, 0.8, 0.8, 0.2)
    if Input.is_action_just_pressed("ui_accept"):
        current_block.rotate()
        Input.start_joy_vibration(0, 0.6, 0.6, 0.15)

    current_block.position += gravity_direction * gravity * delta

    if is_block_landed():
        place_block()
        var lines_cleared = grid.clear_lines()
        if lines_cleared > 0:
            score += lines_cleared * 100
            $ScoreLabel.text = "Score: " + str(score)
        if is_game_over():
            end_game()
        else:
            spawn_block()

func is_game_over():
    for x in range(grid.GRID_WIDTH):
        if grid.get_cell(x, 0) != 0:
            return true
    return false

func is_block_landed():
    for cell in current_block.shape:
        var x = floor(current_block.position.x / 32) + cell.x
        var y = floor(current_block.position.y / 32) + cell.y
        if y >= grid.GRID_HEIGHT - 1 or (y >= 0 and grid.get_cell(x, y + 1) != 0):
            return true
    return false

func place_block():
    for cell in current_block.shape:
        var x = floor(current_block.position.x / 32) + cell.x
        var y = floor(current_block.position.y / 32) + cell.y
        grid.set_cell(x, y, 1)
    current_block.queue_free()

func spawn_block():
    print("Spawning new block.")
    var block_scene = preload("res://scenes/block.tscn")
    current_block = block_scene.instantiate()

    var block_type = randi() % 4
    if block_type == 1:
        current_block.type = preload("res://scripts/block.gd").BlockType.BOMB
        current_block.color = Color.ORANGE
    elif block_type == 2:
        current_block.type = preload("res://scripts/block.gd").BlockType.GHOST
        current_block.color = Color.PURPLE
    elif block_type == 3:
        current_block.type = preload("res://scripts/block.gd").BlockType.WILDCARD
        current_block.color = Color.WHITE

    add_child(current_block)

func trigger_gravity_event():
    var event_type = randi() % 3
    if event_type == 0:
        gravity_direction = Vector2(1, 0) # Shift right
    elif event_type == 1:
        gravity_direction = Vector2(-1, 0) # Shift left
    elif event_type == 2:
        gravity_direction = Vector2(0, -1) # Invert gravity

func end_game():
    print("Game over.")
    get_tree().change_scene_to_file("res://scenes/game_over.tscn")
