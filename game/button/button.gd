extends Area2D

export var output : String 
export var click : Array
export var reversed : bool
export var id : int

func _ready() -> void:
	if reversed:
		get_node(output).set_state(true, id)

func playSound() -> void:
	var audio := $AudioStreamPlayer2D
	audio.stream = click[rand_range(0, 5) as int]
	audio.pitch_scale = 0.6 + rand_range(0, 1)
	audio.play()

# stand
func _on_button_body_entered(_body: Node) -> void:
	if len(get_overlapping_bodies()) == 1:
		$AnimationPlayer.play("on")
		get_node(output).set_state(!reversed, id)

# no stands
func _on_button_body_exited(_body: Node) -> void:
	if len(get_overlapping_bodies()) < 1:
		$AnimationPlayer.play("off")
		get_node(output).set_state(reversed, id)
