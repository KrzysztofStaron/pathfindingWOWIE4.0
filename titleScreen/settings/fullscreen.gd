extends TextureButton

export var clickSound : AudioStream

func fullscreen() -> void:
	get_node("%audio2").stream = clickSound
	get_node("%audio2").pitch_scale = 0.6 + rand_range(0, 1)
	get_node("%audio2").play()
	OS.window_fullscreen = !OS.window_fullscreen
