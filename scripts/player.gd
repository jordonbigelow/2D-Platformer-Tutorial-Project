extends Node

@onready var _character = get_parent()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_character.jump()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_character.run(Input.get_axis("run_left", "run_right"))