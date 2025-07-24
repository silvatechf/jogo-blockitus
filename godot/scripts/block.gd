extends Node2D

var color = Color.RED
var shape = [Vector2(0, 0), Vector2(1, 0), Vector2(0, 1), Vector2(1, 1)] # Default to a square

func _draw():
    for cell in shape:
        draw_rect(Rect2(cell.x * 32, cell.y * 32, 32, 32), color)

func move_down():
    position.y += 32

func move_left():
    position.x -= 32

func move_right():
    position.x += 32

func rotate():
    for i in range(shape.size()):
        var x = shape[i].y
        var y = -shape[i].x
        shape[i] = Vector2(x, y)
