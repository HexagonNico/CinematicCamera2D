extends CharacterBody2D


func _physics_process(_delta: float) -> void:
	var input := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = 80.0 * input
	move_and_slide()
