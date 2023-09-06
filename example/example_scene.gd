extends Node2D


@onready var player: Sprite2D = $Player
@onready var cinematic_camera: CinematicCamera2D = $CinematicCamera



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	player.position += input * 300 * delta


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var cam1 := $VirtualCamera1
		var cam2 := $VirtualCamera2
		if cinematic_camera.virtual_camera == cam1:
			cinematic_camera.virtual_camera = cam2
		else:
			cinematic_camera.virtual_camera = cam1
