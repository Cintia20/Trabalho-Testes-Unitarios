# models/pipe_spawner_model.gd
class_name PipeSpawnerModel

const PIPE_WIDTH = 26
const GROUND_HEIGHT = 56
const OFFSET_Y = 55
const OFFSET_X = 65

var position: Vector2
var viewport_size: Vector2

func _init(viewport_size: Vector2, start_position: Vector2):
	position = start_position
	self.viewport_size = viewport_size

func get_initial_position(camera_offset_x: float) -> Vector2:
	var init_pos = position
	init_pos.x += viewport_size.x + PIPE_WIDTH / 2 + camera_offset_x
	init_pos.y = randf_range(OFFSET_Y, viewport_size.y - GROUND_HEIGHT - OFFSET_Y)
	return init_pos

func get_next_position(current_pos: Vector2) -> Vector2:
	var next_pos = current_pos
	next_pos.x += PIPE_WIDTH / 2 + OFFSET_X + PIPE_WIDTH / 2
	next_pos.y = randf_range(OFFSET_Y, viewport_size.y - GROUND_HEIGHT - OFFSET_Y)
	return next_pos
