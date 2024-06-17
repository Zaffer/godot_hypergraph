extends Node3D

@export var NodeScene: PackedScene
@export var EdgeScene: PackedScene
@export var num_nodes: int = 10

var nodes = []
var edges = []

var adjacency_matrix = []

func _ready():
	adjacency_matrix = generate_random_adjacency_matrix(num_nodes)

	for i in range(adjacency_matrix.size()):
		var node_instance = NodeScene.instantiate()
		add_child(node_instance)
		node_instance.global_transform.origin = Vector3(randf() * 10 - 5, randf() * 10 - 5, randf() * 10 - 5)
		nodes.append(node_instance)

	for i in range(adjacency_matrix.size()):
		for j in range(i, adjacency_matrix[i].size()):
			if adjacency_matrix[i][j] == 1:
				var edge_instance = EdgeScene.instantiate()
				add_child(edge_instance)
				edge_instance.start_node = nodes[i]
				edge_instance.end_node = nodes[j]
				edges.append(edge_instance)
				nodes[i].connected_nodes.append(nodes[j])
				nodes[j].connected_nodes.append(nodes[i])

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
			
		
func generate_random_adjacency_matrix(size: int) -> Array:
	var matrix = []
	for i in range(size):
		var row = []
		for j in range(size):
			if i == j:
				row.append(0)
			elif j < i:
				row.append(matrix[j][i])
			else:
				row.append(randi() % 2)
		matrix.append(row)
	return matrix
			
		
