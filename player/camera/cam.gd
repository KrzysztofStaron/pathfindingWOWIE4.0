extends Camera2D

export var reset : PackedScene
var endScreen := false

func destroy():
	if endScreen:
		return
		
	endScreen = true
	
	z_index = 18
	var newReset := reset.instance()
	add_child(newReset)
	newReset.get_node("anim").play("show")

func goto_robot():
	destroy()
	
	var pos : Vector2 = get_node("../../robot").get_global_position()
	
	$Tween.interpolate_property(self, "global_position", get_global_position(), pos, 0.3)
	$Tween.start()

func goto_player():
	destroy()
