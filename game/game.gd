extends Node2D

@export var pipes_scene: PackedScene

@onready var pipes_holder: Node = $PipesHolder
@onready var spawn_u: Marker2D = $SpawnU
@onready var spawn_l: Marker2D = $SpawnL
@onready var spawn_timer: Timer = $SpawnTimer
@onready var engine_sound: AudioStreamPlayer = $EngineSound
@onready var game_over_sound: AudioStreamPlayer = $GameOverSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.set_score(0)
	GameManager.on_game_over.connect(on_game_over)
	spawn_pipes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_pipes() -> void:
	var y_pos = randf_range(spawn_u.position.y, spawn_l.position.y)
	var new_pipes = pipes_scene.instantiate()
	
	new_pipes.position = Vector2(spawn_l.position.x, y_pos)
	pipes_holder.add_child(new_pipes)

func stop_pipes() -> void:
	spawn_timer.stop()
	for pipe in pipes_holder.get_children():
		pipe.set_process(false)

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func on_game_over() -> void:
	stop_pipes()
	engine_sound.stop()
	game_over_sound.play()
