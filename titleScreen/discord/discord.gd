extends TextureButton

export var clickSound : AudioStream

func _onClick():
	get_node("%audio").stream = clickSound
	get_node("%audio").pitch_scale = 0.6 + rand_range(0, 1)
	get_node("%audio").play()

	if OS.shell_open("https://discord.gg/PwsWJAqTu9"):
		printerr("discord link cannot be loaded")
