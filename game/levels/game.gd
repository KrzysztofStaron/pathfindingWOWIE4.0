extends Node

var ready_to_reset : bool
export var nexLevelPath : String

func set_state(_stage, _id):
	get_tree().change_scene(nexLevelPath)

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()

