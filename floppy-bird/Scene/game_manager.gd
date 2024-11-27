extends Node
enum GameState {IDLE, RUNNING, ENDED}

var game_state

@onready var game_manager = $"."

@onready var bird = get_node("../Bird") as Bird
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var ground = $"../Ground" as Ground
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI

var points = 0

func _ready():
	game_state = GameState.IDLE
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)



func on_game_started():
	game_state = GameState.RUNNING
	pipe_spawner.start_spawning_pipes

func end_game():
	if fade != null:
		fade.play()
	ground.stop()
	bird.stop()
	pipe_spawner.stop()
	ui.on_game_over()

func on_point_scored():
	points += 1
	ui.update_points(points)
