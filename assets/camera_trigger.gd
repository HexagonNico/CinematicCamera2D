extends Area2D


export var camera: NodePath

export var camera_left: NodePath
export var camera_right: NodePath


# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# warning-ignore:return_value_discarded
	connect("body_exited", self, "_on_body_exited")


func _on_body_exited(body: Node) -> void:
	if body.global_position.x > global_position.x:
		get_node(camera).camera_data = get_node(camera_right)
	else:
		get_node(camera).camera_data = get_node(camera_left)
