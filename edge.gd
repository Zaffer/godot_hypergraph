extends Node3D

@export var start_node: Node3D
@export var end_node: Node3D

func _ready():
	#set_physics_process(true)
	pass

func _physics_process(delta):
	if start_node and end_node:
		var start_pos = start_node.global_transform.origin
		var end_pos = end_node.global_transform.origin
		var direction = end_pos - start_pos
		global_transform.origin = start_pos
		look_at(end_pos, Vector3.UP)
		scale.z = direction.length()
