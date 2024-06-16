extends Node3D

@export var connected_nodes: Array = []
@export var repulsion_strength: float = 100.0

func _ready():
	add_to_group("nodes")
	set_physics_process(true)

func _physics_process(delta):
	# Apply repulsive forces
	for node in get_tree().get_nodes_in_group("nodes"):
		if node != self and not node in connected_nodes:
			var direction = global_transform.origin - node.global_transform.origin
			var distance = direction.length()
			if distance > 0:
				var force = direction.normalized() * repulsion_strength / distance
				self.translate(force * delta)
