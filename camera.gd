extends Camera3D

@export var sensitivity := 0.3
@export var speed := 5.0
@export var zoom_speed := 2.0

var is_panning := false
var is_rotating := false
var last_mouse_position := Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			is_panning = event.pressed
		elif event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			is_rotating = event.pressed

		if event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_UP:
			translate(transform.basis.z * zoom_speed)
		elif event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
			translate(-transform.basis.z * zoom_speed)
	
	if event is InputEventMouseMotion:
		var mouse_movement = event.relative
		
		if is_rotating:
			rotate_y(deg_to_rad(-mouse_movement.x * sensitivity))
			var x_rotation = deg_to_rad(-mouse_movement.y * sensitivity)
			var new_rotation = rotation.x + x_rotation
			if new_rotation < deg_to_rad(90) and new_rotation > deg_to_rad(-90):
				rotate_x(x_rotation)
		
		if is_panning:
			translate(-transform.basis.x * mouse_movement.x * 0.01)
			translate(transform.basis.y * mouse_movement.y * 0.01)
