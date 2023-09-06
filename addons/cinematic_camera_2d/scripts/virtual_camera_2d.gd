@tool
@icon("res://addons/cinematic_camera_2d/icons/virtual_camera_2d.svg")
class_name VirtualCamera2D
extends Node2D


## Node that represents a virtual camera. A scene may have several virtual cameras, one of them
## can be assigned to a CinematicCamera2D node to make the camera copy virtual camera's properties.


## The camera's relative offset.
@export var offset := Vector2.ZERO

## The camera's zoom.
@export var zoom := Vector2.ONE

@export_group("Limit", "limit_")
## Left scroll limit in pixels. The camera stops moving when reaching this value.
@export var limit_left: int = -10000000
## Top scroll limit in pixels. The camera stops moving when reaching this value.
@export var limit_top: int = -10000000
## Right scroll limit in pixels. The camera stops moving when reaching this value.
@export var limit_right: int = 10000000
## Bottom scroll limit in pixels. The camera stops moving when reaching this value.
@export var limit_bottom: int = 10000000

@export_group("Editor", "editor_")
## If true, draws the camera's limits rectangle in the editor.
@export var editor_draw_limits := true


# Called when CanvasItem has been requested to redraw.
func _draw() -> void:
	if Engine.is_editor_hint():
		# Draw limits while in the editor
		if editor_draw_limits:
			var rect := Rect2(limit_left, limit_top, limit_right - limit_left, limit_bottom - limit_top)
			draw_rect(rect, Color.YELLOW, false)


# Called every frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		# Needs to be called every frame in case the node is dragged in the editor
		queue_redraw()
