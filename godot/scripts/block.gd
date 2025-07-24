extends Node2D

enum BlockType { NORMAL, BOMB, GHOST, WILDCARD }

var type = BlockType.NORMAL
var color = Color.RED
var shape = []
var position = Vector2(0, 0)

func _draw():
    for cell in shape:
        draw_rect(Rect2((position.x + cell.x) * 32, (position.y + cell.y) * 32, 32, 32), color)

func move_down():
    position.y += 1

func move_left():
    position.x -= 1

func move_right():
    position.x += 1

func rotate():
    for i in range(shape.size()):
        var x = shape[i].y
        var y = -shape[i].x
        shape[i] = Vector2(x, y)
