extends Node2D


@onready var cinematic_camera: CinematicCamera2D = $CinematicCamera

@onready var virtual_camera_1: Node2D = $VirtualCamera1
@onready var virtual_camera_2: Node2D = $VirtualCamera2

@onready var camera_trigger_shape: CollisionShape2D = $CameraTrigger/CollisionShape


func _on_camera_trigger_body_exited(body: Node2D) -> void:
	if body.position.y < camera_trigger_shape.position.y:
		cinematic_camera.virtual_camera = virtual_camera_2
	else:
		cinematic_camera.virtual_camera = virtual_camera_1
