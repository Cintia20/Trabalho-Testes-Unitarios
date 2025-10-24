class_name ScoreModel

signal score_changed(new_score)

var current_score: int = 0
var best_score: int = 0

func reset():
	current_score = 0

func add_point():
	current_score += 1
	if current_score > best_score:
		best_score = current_score
	emit_signal("score_changed", current_score)

func get_current_score() -> int:
	return current_score

func get_best_score() -> int:
	return best_score
