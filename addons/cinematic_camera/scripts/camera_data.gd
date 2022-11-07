tool
class_name CameraData2D, "res://addons/cinematic_camera/icons/camera_data.svg"
extends Node2D


## Contains parameters used by a CinematicCamera2D.
## Works as a logic camera to be used in combination with a CinematicCamera2D.


## Path to the node that the camera should follow. If this is set to a Node2D,
## the camera will keep the same position as this node. If this is unset,
## the camera will keep the same position as the virtual camera.
export var _follow_node: NodePath setget _set_follow_node
## Reference to the node that the camera should follow. If this is set to a Node2D,
## the camera will keep the same position as this node. If this is unset,
## the camera will keep the same position as the virtual camera.
onready var follow_node: Node = get_node_or_null(_follow_node) setget set_follow_node

## Camera offset. The offset of the cinematic camera will transition smoothly
## to this value, according to its 'smoothing_speed'.
export var offset: Vector2 = Vector2.ZERO setget set_offset

## Camera zoom. The zoom of the cinematic camera will transition smoothly
## to this value, according to its 'smoothing_speed'.
export var zoom: Vector2 = Vector2.ONE setget set_zoom

## Smoothing speed. Used as the position, offset and zoom smoothing speed.
export var smoothing_speed: float = 5.0 setget set_smoothing_speed

## Left limit of the camera. Note that this does not affect the limit
## of the actual camera to allow for transitions between cameras with
## different limits.
export var limit_left: int = -10000000 setget set_limit_left
## Top limit of the camera. Note that this does not affect the limit
## of the actual camera to allow for transitions between cameras with
## different limits.
export var limit_top: int = -10000000 setget set_limit_top
## Right limit of the camera. Note that this does not affect the limit
## of the actual camera to allow for transitions between cameras with
## different limits.
export var limit_right: int = 10000000 setget set_limit_right
## Bottom limit of the camera. Note that this does not affect the limit
## of the actual camera to allow for transitions between cameras with
## different limits.
export var limit_bottom: int = 10000000 setget set_limit_bottom


## Draw the canvas item.
## Used while in the editor to draw gizmos.
func _draw() -> void:
	if Engine.editor_hint:
		draw_multiline(PoolVector2Array([
			Vector2(limit_left, limit_top), Vector2(limit_left, limit_bottom),
			Vector2(limit_left, limit_bottom), Vector2(limit_right, limit_bottom),
			Vector2(limit_right, limit_bottom), Vector2(limit_right, limit_top),
			Vector2(limit_right, limit_top), Vector2(limit_left, limit_top)
		]), Color.yellow)


## Updates the position of the given camera.
## Takes this camera's limits into account.
func update_position(camera: Node2D) -> void:
	# Update camera position
	if is_instance_valid(follow_node) and follow_node is Node2D:
		camera.global_position = follow_node.global_position
	else:
		camera.global_position = global_position
	# Make came stay within its limits
	var camera_bounds = get_viewport().get_size_override() * zoom / 2
	camera.global_position.x = clamp(camera.global_position.x, global_position.x + limit_left + camera_bounds.x, global_position.x + limit_right - camera_bounds.x)
	camera.global_position.y = clamp(camera.global_position.y, global_position.y + limit_top + camera_bounds.y, global_position.y + limit_bottom - camera_bounds.y)


## Setter function for 'follow_node'
func set_follow_node(value: Node) -> void:
	follow_node = value


## Setter function for 'offset'
func set_offset(value: Vector2) -> void:
	offset = value


## Setter function for 'zoom'
func set_zoom(value: Vector2) -> void:
	zoom = value


## Setter function for 'smoothing_speed'
func set_smoothing_speed(value: float) -> void:
	smoothing_speed = value


## Setter function for 'limit_left'
## Updates gizmos in the editor
func set_limit_left(value: int) -> void:
	limit_left = value
	if Engine.editor_hint:
		update()


## Setter function for 'limit_top'
## Updates gizmos in the editor
func set_limit_top(value: int) -> void:
	limit_top = value
	if Engine.editor_hint:
		update()


## Setter function for 'limit_right'
## Updates gizmos in the editor
func set_limit_right(value: int) -> void:
	limit_right = value
	if Engine.editor_hint:
		update()


## Setter function for 'limit_bottom'
## Updates gizmos in the editor
func set_limit_bottom(value: int) -> void:
	limit_bottom = value
	if Engine.editor_hint:
		update()


## Setter function for '_follow_node'
func _set_follow_node(value: NodePath):
	_follow_node = value
	if Engine.editor_hint:
		follow_node = get_node_or_null(_follow_node)
