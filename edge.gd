extends Node3D

@export var start_node: Node3D
@export var end_node: Node3D
@export var node_radius: float = 0.5  # Adjust based on the radius of the node spheres

func _ready():
	_update_edge()

func _process(delta):
	_update_edge()

func _update_edge():
	if start_node and end_node:
		var start_pos = start_node.global_transform.origin
		var end_pos = end_node.global_transform.origin
		var direction = end_pos - start_pos
		var distance = direction.length()

		# Adjust the end position to be on the surface of the end node's radius
		direction = direction.normalized()
		var adjusted_end_pos = end_pos - direction * node_radius
		var adjusted_distance = (adjusted_end_pos - start_pos).length()

		# Position the edge at the midpoint between start and adjusted end positions
		global_transform.origin = start_pos

		# Orient the edge to look at the adjusted end position
		look_at(adjusted_end_pos, Vector3.UP)

		# Scale the edge to the adjusted distance between the nodes minus the node radius
		var scale_factor = adjusted_distance / 3  # Assuming the edge mesh length is 1 unit
		scale = Vector3(1, 1, scale_factor)
