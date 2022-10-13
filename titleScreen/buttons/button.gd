extends TextureButton

export var clickSound : AudioStream

func click() -> void:
	var audio := get_node("%audio")
	audio.stream = clickSound
	audio.pitch_scale = 0.6 + rand_range(0, 1)
	audio.play()
