extends TextureButton

func _ready():
	connect("pressed", Callable(self, "_on_button_pressed"))
	var hbox_score_last = utils.get_main_node().find_child("hbox_score_last")
	if hbox_score_last:
		hbox_score_last.connect("counter_finished", Callable(self, "grab_focus"))
	pass # Replace with function body.

func _on_button_pressed():
	stage_manager.change_stage(stage_manager.GAME_STAGE)
	disabled = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
