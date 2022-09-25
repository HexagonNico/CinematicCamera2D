extends KinematicBody2D


export var speed: float = 120.0

var velocity: Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
	var horizontal = Input.get_axis("ui_left", "ui_right")
	var vertical = Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(horizontal, vertical) * speed


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
