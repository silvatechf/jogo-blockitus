extends Node2D

const GRID_WIDTH = 10
const GRID_HEIGHT = 20
const CELL_SIZE = 32

var grid = []

func _ready():
    grid.resize(GRID_WIDTH * GRID_HEIGHT)
    grid.fill(0)

func _draw():
    for x in range(GRID_WIDTH):
        for y in range(GRID_HEIGHT):
            draw_rect(Rect2(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE), Color.BLACK, false)

func set_cell(x, y, value):
    grid[y * GRID_WIDTH + x] = value

func get_cell(x, y):
    return grid[y * GRID_WIDTH + x]

func clear_lines():
    var lines_cleared = 0
    for y in range(GRID_HEIGHT):
        var is_line_full = true
        for x in range(GRID_WIDTH):
            if get_cell(x, y) == 0:
                is_line_full = false
                break
        if is_line_full:
            lines_cleared += 1
            for y2 in range(y, 0, -1):
                for x2 in range(GRID_WIDTH):
                    set_cell(x2, y2, get_cell(x2, y2 - 1))
            for x2 in range(GRID_WIDTH):
                set_cell(x2, 0, 0)
    return lines_cleared
