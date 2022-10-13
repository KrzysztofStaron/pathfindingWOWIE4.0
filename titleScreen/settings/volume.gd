extends TextureButton

export var clickSound : AudioStream

export var volume := 70
export var settingName : String

func _ready() -> void:
	$Label.text = str(settingName, ": ", volume, "%")
	if settingName == "music":
		MusicManager.set_music(volume)
	elif settingName == "sfx":
		MusicManager.set_sfx(volume)

func _on_volume_pressed() -> void:
	get_node("%audio2").set_stream(clickSound)
	get_node("%audio2").pitch_scale = 0.6 + rand_range(0, 1)
	get_node("%audio2").play()
	volume += 10
	if volume > 100:
		volume = 0
	
	$Label.text = str(settingName, ": ", volume, "%")
	if settingName == "music":
		MusicManager.set_music(volume)
	elif settingName == "sfx":
		MusicManager.set_sfx(volume)
