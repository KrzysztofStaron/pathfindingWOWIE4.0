extends StaticBody2D

var state : bool
export var states : PoolIntArray
export var type := "or"
export var open : Array
onready var shake : Node = get_tree().get_root().get_children()[2].get_node("player/cam/shake")

export var closeOnStart := true
func _ready() -> void:
	if closeOnStart:
		$AnimationPlayer.play("close")
	
func set_state(newState : bool, id : int) -> void:
	if type == "or":
		if newState and !states.has(1):
			$AnimationPlayer.play("open")
		elif !newState and states.count(1) == 1:
			$AnimationPlayer.play("close")
	elif type == "and":
		if states.count(1) == len(states)-1 and newState:
			$AnimationPlayer.play("open")
		elif states.count(1) == len(states) and !newState:
			$AnimationPlayer.play("close")
	elif type == "not":
		if newState and !states.has(1):
			$AnimationPlayer.play("close")
		elif !newState and states.count(1) == 1:
			$AnimationPlayer.play("open")
		
	states[id] = newState as int

func playSound() -> void:
	$AudioStreamPlayer2D.stream = open[rand_range(0, 3) as int]
	$AudioStreamPlayer2D.pitch_scale = 0.6 + rand_range(0, 1)
	$AudioStreamPlayer2D.play()
	
	shake.start()
	
func kill() -> void:
	for body in $kill.get_overlapping_bodies():
		if body.name == "robot" or body.name == "player":
			body.destroy()
		
