# res://models/bird_model.gd
class_name BirdModel

const STATE_FLYING = 0
const STATE_FLAPPING = 1
const STATE_HIT = 2
const STATE_GROUNDED = 3

signal state_changed(new_state)

var state = STATE_FLAPPING

func set_state(new_state):
	if state == new_state:
		return
	state = new_state
	emit_signal("state_changed", state)

func get_state():
	return state

func on_collision(collider_groups: Array):
	if STATE_HIT == state or STATE_GROUNDED == state:
		return
	
	if "pipes" in collider_groups:
		set_state(STATE_HIT)
	elif "grounds" in collider_groups:
		set_state(STATE_GROUNDED)

func flap():
	if state == STATE_FLAPPING:
		# lógica para flap, se precisar
		pass
