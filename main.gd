extends Node3D

@export var NodeScene: PackedScene
@export var EdgeScene: PackedScene

var nodes = []
var edges = []

var adjacency_matrix = [
	[0, 1, 0],
	[1, 0, 1],
	[0, 1, 0]
]

func _ready():
	create_hypergraph()

func create_hypergraph():
	for i in range(adjacency_matrix.size()):
		var node_instance = NodeScene.instantiate()
		add_child(node_instance)
		node_instance.global_transform.origin = Vector3(randf() * 10 - 5, randf() * 10 - 5, randf() * 10 - 5)
		nodes.append(node_instance)

	for i in range(adjacency_matrix.size()):
		for j in range(i, adjacency_matrix.size()):
			if adjacency_matrix[i][j] == 1:
				var edge_instance = EdgeScene.instantiate()
				add_child(edge_instance)
				edge_instance.start_node = nodes[i]
				edge_instance.end_node = nodes[j]
				edges.append(edge_instance)
				nodes[i].connected_nodes.append(nodes[j])
				nodes[j].connected_nodes.append(nodes[i])
