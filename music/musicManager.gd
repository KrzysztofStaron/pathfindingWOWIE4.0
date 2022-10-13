extends AudioStreamPlayer

func set_music(volume : int) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), -70 + 70*(volume / 100.0))

func set_sfx(volume : int) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), -70 + 70*(volume / 100.0))

func _ready() -> void:
	set_music(70)
	set_sfx(70)
	
	play()

func _process(_delta: float) -> void:
	if get_playback_position() > 45.5:
		play()
	 
