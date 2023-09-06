
# Cinematic Camera 2D plugin

A plugin that adds a VirtualCamera2D node and a CinematicCamera2D node that allow to create smooth transitions between cameras.

## Installing the plugin in your project

The procedure is the same as other Godot plugins.
See the [Godot docs](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) for a full explanation.

1. Click the **AssetLib** tab at the top of the editor and look for Cinematic Camera 2D.

2. Download the plugin and install the contents of the `addons` and the `script_templates` folders into your project's directory. You don't need the contents of the `example` folder.

3. Go to `Project -> Project Settings... -> Plugins` and enable the plugin by checking "Enable".

It is also possible to install the plugin manually by downloading the zip archive from the [Releases section](https://github.com/HexagonNico/GodotPlugin-CinematicCamera2D/releases).

## Plugin contents

The plugin contains two [script classes](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#doc-gdscript-basics-class-name): `VirtualCamera2D` and `CinematicCamera2D`.
Both can be added to your scenes as nodes through the "Create New Node" menu.

The **VirtualCamera2D** node contains the camera's data.

The **CinematicCamera2D** node is the actual camera and contains a reference to a virtual camera node.

![Create node](/example/readme/create_node.png)

## Creating cinematic camera

Open the "Create New Node" menu and search for "VirtualCamera2D". Add this node in your level scene.

![Virtual camera inspector](/example/readme/virtual_camera_inspector.png)

This node contains data about the camera's zoom level, offset, and limits.

Now add a "CinematicCamera2D" node and assign the virtual camera to the 'Virtual camera' property in the inspector.
When you run the game, the cinematic camera will copy the properties of the virtual camera.

![Cinematic camera inspector](/example/readme/cinematic_camera_inspector.png)

## Following the player

The cinematic camera also has a 'Follow node' property.
Setting this property to your player's node will make the camera copy the player's global position, allowing you to create a camera that follows the player.
Enable position smoothing in the camera's properties to create a smooth movement.

## Create transitions between cameras

It is possible to create smooth transitions between cameras if there are more virtual cameras in the scene.
If the camera's position smoothing is enabled and the `virtual_camera` property of the CinematicCamera2D is updated, the camera will move towards the new one.

Example:
```
@onready var cinematic_camera: CinematicCamera2D = $CinematicCamera

@onready var virtual_camera_1: Node2D = $VirtualCamera1
@onready var virtual_camera_2: Node2D = $VirtualCamera2

@onready var camera_trigger_shape: CollisionShape2D = $CameraTrigger/CollisionShape

func _on_camera_trigger_body_exited(body: Node2D) -> void:
	if body.position.y < camera_trigger_shape.position.y:
		cinematic_camera.virtual_camera = virtual_camera_2
	else:
		cinematic_camera.virtual_camera = virtual_camera_1
```

If the second camera has a different zoom, offset, or limits, the camera will slowly update its values towards the new ones.
