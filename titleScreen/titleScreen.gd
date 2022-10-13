extends Control

func quit():
	get_tree().quit()

func settings() -> void:
	$CenterContainer/buttons.hide()
	$CenterContainer/settings.show()

func play() -> void:
	get_tree().change_scene("res://game/levels/tutorial/tutorial.tscn")
