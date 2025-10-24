extends "res://addons/gut/test.gd"

var ScoreModel = preload("res://models/score_model.gd")
var BirdModel = preload("res://models/bird_Models.gd")
var PipeSpawnerModel = preload("res://models/spawner_pipe_models.gd")

# ===== TESTES DO SCORE MODEL =====
func test_score_starts_at_zero():
	var score = ScoreModel.new()
	assert_eq(score.get_current_score(), 0, "O score inicial deve ser 0.")

func test_score_increases_by_one():
	var score = ScoreModel.new()
	score.add_point()
	assert_eq(score.get_current_score(), 1, "O score deveria ser 1 depois de add_point().")

func test_score_reset():
	var score = ScoreModel.new()
	score.add_point()
	score.add_point()
	score.reset()
	assert_eq(score.get_current_score(), 0, "O score deveria ser 0 após reset.")

func test_best_score_updates_correctly():
	var score = ScoreModel.new()
	score.add_point()  # current=1, best=1
	score.add_point()  # current=2, best=2
	score.reset()      # current=0, best=2
	score.add_point()  # current=1, best=2 (não muda)
	assert_eq(score.get_best_score(), 2, "O best score deveria manter o maior valor.")

func test_score_changed_signal():
	var score = ScoreModel.new()
	watch_signals(score)
	score.add_point()
	assert_signal_emitted(score, "score_changed", "Sinal score_changed deveria ser emitido.")

# ===== TESTES DO BIRD MODEL =====
func test_bird_initial_state():
	var bird = BirdModel.new()
	assert_eq(bird.get_state(), BirdModel.STATE_FLAPPING, "Estado inicial deveria ser FLAPPING.")

func test_bird_state_transition():
	var bird = BirdModel.new()
	bird.set_state(BirdModel.STATE_HIT)
	assert_eq(bird.get_state(), BirdModel.STATE_HIT, "Estado deveria mudar para HIT.")

func test_bird_collision_with_pipes():
	var bird = BirdModel.new()
	var pipe_groups = ["pipes"]
	bird.on_collision(pipe_groups)
	assert_eq(bird.get_state(), BirdModel.STATE_HIT, "Colisão com pipes deveria mudar estado para HIT.")

func test_bird_collision_with_ground():
	var bird = BirdModel.new()
	var ground_groups = ["grounds"]
	bird.on_collision(ground_groups)
	assert_eq(bird.get_state(), BirdModel.STATE_GROUNDED, "Colisão com ground deveria mudar estado para GROUNDED.")

func test_bird_no_state_change_after_hit():
	var bird = BirdModel.new()
	bird.set_state(BirdModel.STATE_HIT)
	bird.on_collision(["pipes"])  # Não deveria mudar nada
	assert_eq(bird.get_state(), BirdModel.STATE_HIT, "Estado não deveria mudar após já estar HIT.")

# ===== TESTES DO PIPE SPAWNER MODEL =====
func test_pipe_initial_position():
	var viewport_size = Vector2(400, 600)
	var start_pos = Vector2(100, 300)
	var spawner = PipeSpawnerModel.new(viewport_size, start_pos)
	
	var camera_offset = 50.0
	var initial_pos = spawner.get_initial_position(camera_offset)
	
	# Verifica se a posição X está correta
	var expected_x = start_pos.x + viewport_size.x + spawner.PIPE_WIDTH / 2 + camera_offset
	assert_eq(initial_pos.x, expected_x, "Posição X inicial deveria estar correta.")
	
	# Verifica se a posição Y está dentro dos limites
	assert_true(initial_pos.y >= spawner.OFFSET_Y, "Posição Y deveria ser maior ou igual a OFFSET_Y.")
	assert_true(initial_pos.y <= viewport_size.y - spawner.GROUND_HEIGHT - spawner.OFFSET_Y, 
		"Posição Y deveria considerar o ground height.")

func test_pipe_next_position():
	var viewport_size = Vector2(400, 600)
	var start_pos = Vector2(100, 300)
	var spawner = PipeSpawnerModel.new(viewport_size, start_pos)
	
	var current_pos = Vector2(200, 250)
	var next_pos = spawner.get_next_position(current_pos)
	
	# Verifica cálculo da próxima posição X
	var expected_x = current_pos.x + spawner.PIPE_WIDTH / 2 + spawner.OFFSET_X + spawner.PIPE_WIDTH / 2
	assert_eq(next_pos.x, expected_x, "Próxima posição X deveria estar correta.")
	
	# Verifica se a posição Y está dentro dos limites
	assert_true(next_pos.y >= spawner.OFFSET_Y, "Próxima posição Y deveria ser maior ou igual a OFFSET_Y.")
	assert_true(next_pos.y <= viewport_size.y - spawner.GROUND_HEIGHT - spawner.OFFSET_Y, 
		"Próxima posição Y deveria considerar o ground height.")

# ===== TESTES DE EDGE CASES =====
func test_multiple_score_additions():
	var score = ScoreModel.new()
	for i in range(10):
		score.add_point()
	assert_eq(score.get_current_score(), 10, "Score deveria ser 10 após 10 adições.")
	assert_eq(score.get_best_score(), 10, "Best score deveria ser 10.")

func test_bird_state_same_state_no_change():
	var bird = BirdModel.new()
	watch_signals(bird)
	bird.set_state(BirdModel.STATE_FLAPPING)  # Mesmo estado atual
	assert_signal_not_emitted(bird, "state_changed", "Sinal não deveria ser emitido para mesmo estado.")

func test_pipe_position_randomness():
	var viewport_size = Vector2(400, 600)
	var start_pos = Vector2(100, 300)
	var spawner = PipeSpawnerModel.new(viewport_size, start_pos)
	
	var camera_offset = 50.0
	var pos1 = spawner.get_initial_position(camera_offset)
	var pos2 = spawner.get_initial_position(camera_offset)
	
	# As posições Y devem ser diferentes (aleatórias)
	# Nota: Em testes reais, você pode querer mockar o randf_range
	assert_true(pos1.y != pos2.y, "Posições Y deveriam ser aleatórias e diferentes.")
