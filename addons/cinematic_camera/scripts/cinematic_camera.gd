tool
class_name CinematicCamera2D, "res://addons/cinematic_camera/icons/cinematic_camera.svg"
extends Camera2D


## Cinematic camera 2D node.
## Uses a CameraData2D to create smooth transitions between cameras.


## Node path to the camera metadata node to use.
export var _camera_data: NodePath setget _set_camera_data
## Reference to camera metadata node.
## Change this value to transition to another camera.
onready var camera_data: CameraData2D = get_node_or_null(_camera_data) setget set_camera_data


## Called every frame.
func _process(delta: float) -> void:
	if is_instance_valid(camera_data):
		camera_data.update_position(self)
		smoothing_speed = camera_data.smoothing_speed
		if camera_data.zoom.x != 0.0:
			zoom.x = lerp(zoom.x, camera_data.zoom.x, delta * smoothing_speed)
		if camera_data.zoom.y != 0.0:
			zoom.y = lerp(zoom.y, camera_data.zoom.y, delta * smoothing_speed)
		zoom = lerp(zoom, camera_data.zoom, delta * smoothing_speed)
		offset = lerp(offset, camera_data.offset, delta * smoothing_speed)


## Setter function for 'camera_data'
func set_camera_data(value: CameraData2D) -> void:
	camera_data = value


## Setter function for '_camera_data'
func _set_camera_data(value: NodePath) -> void:
	_camera_data = value
	if Engine.editor_hint:
		camera_data = get_node_or_null(_camera_data)
