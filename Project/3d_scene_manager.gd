extends Node

const TILE_SIZE = 24
const VIEWPORT_SCALE = 2

@onready var viewport_rect := $ViewportRect
@onready var subviewport := $SubViewport
@onready var camera := $SubViewport/Camera3D

func _ready():
	resize(Vector2i(20, 10), 1)
	await(get_tree().create_timer(5).timeout)
	resize(Vector2i(20, 10), 2)
	await(get_tree().create_timer(5).timeout)
	resize(Vector2i(20, 10), 3)
	await(get_tree().create_timer(5).timeout)
	resize(Vector2i(20, 10), 4)


func resize(size_in_tiles: Vector2i, scale = -1):
	viewport_rect.size = size_in_tiles * TILE_SIZE
	if scale > 0:
		viewport_rect.scale = Vector2i.ONE * scale
	viewport_rect.position = get_viewport().size / 2
	viewport_rect.position -= viewport_rect.scale * viewport_rect.size / 2
	subviewport.size = viewport_rect.size * VIEWPORT_SCALE * scale
	subviewport.size.y = (subviewport.size.y / 2.0 * sqrt(2.0))
	camera.size = viewport_rect.size.x / 10.0
