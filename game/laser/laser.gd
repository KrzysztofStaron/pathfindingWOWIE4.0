extends Node2D

export var cooldown := 1.0
export var workingTime := 0.9
	
func _ready():
	_on_cooldown_timeout()

func _on_area_body_entered(body: Node) -> void:
	if body.name == "player" or body.name == "robot":
		body.destroy()

func _on_cooldown_timeout() -> void:
	# working
	
	$working.start(workingTime)
	for child in $beams.get_children():
		child.get_node("anim").play("show")
	$audio.pitch_scale = rand_range(0.7, 1.3)
	$audio.play()
	
	get_node("area").monitoring = true

func _on_working_timeout() -> void:
	# cooldown
	for child in $beams.get_children():
		child.get_node("anim").play("hide")
	
	$cooldown.start(cooldown + rand_range(0.0, 2.0))
	get_node("area").monitoring = false
