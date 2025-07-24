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
