extends KinematicBody2D

export var speed : float = 60
onready var acceleration :  float = speed * 9
var velocity := Vector2.ZERO

var endScreen := false

func destroy() -> void:
	set_physics_process(false)
	set_process(false)
	if endScreen:
		return
	get_node("cam/shake").start()
	endScreen = true
	$Sprite/audio.play()
	$Sprite.hide()
	z_index = 20
	get_node("../").ready_to_reset = true
	get_node("cam").goto_player()

func _physics_process(delta) -> void:
	var dir : Vector2 = MoveInput.vector("move_left", "move_right", "move_up", "move_down")
	velocity.y = move_toward(velocity.y, dir.y * speed, acceleration * delta)
	velocity.x = move_toward(velocity.x, dir.x * speed, acceleration * delta)
	
	velocity = move_and_slide(velocity)
	
func _process(_delta: float) -> void:
	if velocity == Vector2.ZERO:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("walk")
	
	if velocity.x < 0:
		$Sprite.set_scale(Vector2(-1, 1))
	elif velocity.x > 0:
		$Sprite.set_scale(Vector2(1, 1))
	
	for body in get_node("%playerBoxDetectorX").get_overlapping_bodies():
		body.push(Vector2(velocity.x, 0))
	
	if velocity.y < 0:
		for body in get_node("%playerBoxDetectorY").get_overlapping_bodies():
			body.push(Vector2(0, velocity.y))
	else:
		for body in get_node("%playerBoxDetectorY2").get_overlapping_bodies():
			body.push(Vector2(0, velocity.y))
