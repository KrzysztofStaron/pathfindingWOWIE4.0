extends KinematicBody2D

export var speed := 40.0
export var goto : Array

export var crush : AudioStream

var endScreen := false
onready var shake : Node = get_node("../player/cam/shake")
onready var player : Node = get_node("../player")

var hlast : bool
var vlast : bool

func destroy(dead := true) -> void:
	if endScreen:
		return
	shake.start()
	endScreen = true
	
	if dead:
		$AudioStreamPlayer2D.stream = crush
		$AudioStreamPlayer2D.play()
		$Sprite.hide()
	
	z_index = 20
	get_node("../").ready_to_reset = true
	get_node("../player/cam").goto_robot()
	
func _ready() -> void:
	$Sprite.hframes = 3
	$Sprite.vframes = 3
	$NavigationAgent2D.set_navigation(get_node("../nav"))
	get_node("NavigationAgent2D").set_target_location(get_global_position()+Vector2(20, 1))
		
func _physics_process(delta: float) -> void:
	if position.y < player.position.y:
		player.z_index = 3
	else:
		player.z_index = 1
	
	if $Sprite.hframes == 1 or hlast:
		if !hlast:
			hlast = true
		else:
			hlast = false
		
		print("H fixed")
		$Sprite.hframes = 3 as int

	if $Sprite.vframes == 1 or vlast:
		if !vlast:
			vlast = true
		else:
			vlast = false
		print("V fixed")
		$Sprite.vframes = 3 as int
	
	var pos : Vector2 = get_node("NavigationAgent2D").get_next_location()
	var dif := pos - global_position
	
	if !get_node("NavigationAgent2D").is_navigation_finished():
		if dif.x < 0:
			$Sprite.set_scale(Vector2(-1, 1))
		elif dif.x > 0:
			$Sprite.set_scale(Vector2(1, 1))
		
		global_position += dif * speed * delta
		$AnimationPlayer.play("walk")
	else:
		move_and_slide(Vector2.ZERO)
		$AnimationPlayer.play("idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("robot_action") and !endScreen:	
		$AudioStreamPlayer2D.stream = goto[rand_range(0, 3) as int]
		$AudioStreamPlayer2D.pitch_scale = 0.6 + rand_range(0, 1)
		$AudioStreamPlayer2D.play()
		get_node("NavigationAgent2D").set_target_location(get_global_mouse_position() - Vector2(0, 9.5))


func _on_Timer_timeout() -> void:
	if $Sprite/battery.frame < 5:
		$Sprite/battery.frame += 1
	else:
		$Timer.queue_free()
		set_physics_process(false)
		$AnimationPlayer.play("lostPower")
		destroy(false)
