@icon("res://addons/cinematic_camera_2d/icons/cinematic_camera_2d.svg")
class_name CinematicCamera2D
extends Camera2D


## Cinematic camera node for 2D scenes.
## Uses a VirtualCamera2D to create transitions between cameras.


## The node that this camera is supposed to follow.
## The camera's global position will be set to this node's global position every frame.
@export var follow_node: Node2D = null
## The current virtual camera node. A scene may have several virtual cameras, but only needs one
## cinematic camera. Update this value to transition between different cameras.
@export var virtual_camera: VirtualCamera2D = null
## The speed at which the transitions take place. Used by zoom and offset.
@export var transition_speed: float = 1.0


# Called every frame.
func _process(delta: float) -> void:
	# Update the camera if a virtual camera was assigned
	if is_instance_valid(virtual_camera):
		# Update zoom and offset
		zoom = zoom.move_toward(virtual_camera.zoom, delta * max(0.0, transition_speed))
		offset = offset.move_toward(virtual_camera.offset, delta * max(0.0, transition_speed))
		# Clamp camera position within bounds
		var half_bounds := get_viewport_rect().size / zoom / 2.0
		var top_left := Vector2(virtual_camera.limit_left, virtual_camera.limit_top)
		var bottom_right := Vector2(virtual_camera.limit_right, virtual_camera.limit_bottom)
		top_left += virtual_camera.global_position + half_bounds - offset
		bottom_right += virtual_camera.global_position - half_bounds - offset
		# Follow the follow node if assigned
		if is_instance_valid(follow_node):
			global_position = follow_node.global_position.clamp(top_left, bottom_right)
		# Use camera position if no follow node is assigned
		else:
			global_position = global_position.clamp(top_left, bottom_right)
	# Use the same position as the follow node if no virtual camera is assigned
	elif is_instance_valid(follow_node):
		global_position = follow_node.global_position
