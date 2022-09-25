tool
class_name CinematicCamera2D, "res://addons/cinematic_camera/icons/cinematic_camera.svg"
extends Camera2D


## Cinematic camera 2D node
## Uses a CameraData2D to create smooth transitions between cameras


## Node path to the camera metadata node to use
export var _camera_data: NodePath
## Reference to camera metadata node
## Change this value to transition to another camera
onready var camera_data: CameraData2D = get_node_or_null(_camera_data) setget set_camera_data


## Called every frame
func _process(delta: float) -> void:
	if is_instance_valid(camera_data):
		camera_data.update_position(self)
		smoothing_speed = camera_data.smoothing_speed
		zoom = lerp(zoom, camera_data.zoom, delta * smoothing_speed)
		offset = lerp(offset, camera_data.offset, delta * smoothing_speed)


## Setter function for 'camera_data'
func set_camera_data(value: CameraData2D) -> void:
	camera_data = value
