extends RigidBody3D

@export var connected_nodes: Array = []
@export var repulsion_strength: float = 100.0
@export var attraction_strength: float = 100.0
@export var linear_damping: float = 10.0
@export var angular_damping: float = 10.0
@export var central_attraction_strength: float = 20.0
@export var max_force: float = 10.0
@export var min_distance: float = 2.0

func _ready():
	add_to_group("nodes")
	linear_damp = linear_damping
	angular_damp = angular_damping

func _integrate_forces(state: PhysicsDirectBodyState3D):
	apply_forces(state.get_step())

func apply_forces(delta: float):
	var center = Vector3.ZERO
	var direction_to_center = center - global_transform.origin
	var distance_to_center = direction_to_center.length()
	
	if distance_to_center > 0:
		direction_to_center = direction_to_center.normalized()
		var central_force = direction_to_center * central_attraction_strength
		central_force = clamp_vector(central_force, max_force)
		apply_central_force(central_force)

	
	for node in get_tree().get_nodes_in_group("nodes"):
		if node != self and node is RigidBody3D:
			var direction = node.global_transform.origin - global_transform.origin
			var distance = direction.length()
			if distance > 0:
				direction = direction.normalized()
				if node in connected_nodes and distance > min_distance:
					# Apply spring-damper force
					var displacement = direction * distance
					var spring_force = displacement * attraction_strength
					var relative_velocity = node.get_linear_velocity() - get_linear_velocity()
					var damping_force = relative_velocity * angular_damping
					var force = spring_force - damping_force
					force = clamp_vector(force, max_force)
					apply_central_force(force)
				else:
					# Apply repulsive force
					var repulsion_force = direction * repulsion_strength / distance
					repulsion_force = clamp_vector(repulsion_force, max_force)
					apply_central_force(-repulsion_force)

func clamp_vector(vec: Vector3, max_length: float) -> Vector3:
	if vec.length() > max_length:
		return vec.normalized() * max_length
	return vec
