extends Control

@onready var game_over_label: Label = $GameOverLabel
@onready var press_space_label: Label = $PressSpaceLabel
@onready var timer: Timer = $Timer

var _can_press_space: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _can_press_space == true:
		if Input.is_action_just_pressed("fly") == true:
			GameManager.load_main_scene()

func on_game_over() -> void:
	show()
	timer.start()

func run_sequence() -> void:
	game_over_label.hide()
	press_space_label.show()
	_can_press_space = true

func _on_timer_timeout() -> void:
	run_sequence()
