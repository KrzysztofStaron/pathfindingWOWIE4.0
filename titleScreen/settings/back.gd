extends TextureButton

export var clickSound : AudioStream

func back() -> void:
	var audio := get_node("%audio2")
	audio.stream = clickSound
	audio.pitch_scale = 0.6 + rand_range(0, 1)
	audio.play()
	
	get_node("../").hide()
	get_node("../../buttons").show()
