extends AnimatedSprite2D

const MEDAL_RADIUS = 11

func _ready():
	to_random_pos()
	get_parent().connect("medal_shown", Callable(get_node("anim"), "play").bind("shine"))
	pass

func to_random_pos():
	var random_angle = deg_to_rad(randf_range(0, 360))
	var rand_radius =  randf_range(0, MEDAL_RADIUS)
	var x = rand_radius*sin(random_angle) + MEDAL_RADIUS;
	var y = rand_radius*cos(random_angle) + MEDAL_RADIUS;
	position = Vector2(x, y)
	pass
