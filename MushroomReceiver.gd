extends Spatial

var _queue : Array = []


func _ready():
	pass # Replace with function body.


func add(mushroom : Spatial):
	#mushroom.visible = false
	#add_child(mushroom)
	_queue.push_back(mushroom)
	#mushroom.global_transform.origin = global_transform.origin

func pop():
	var mushroom = _queue.pop_back()
	if mushroom:
		pass#remove_child(mushroom)
	return mushroom

func drop():
	var mushroom : Spatial = _queue.pop_back()
	if mushroom:
		$RayCast.force_raycast_update()
		var point = $RayCast.get_collision_point()
		var collider = $RayCast.get_collider()
		if collider:
			get_tree().current_scene.add_child(mushroom)
			mushroom.global_transform.origin = point
			mushroom.collision_shape.disabled = false
			mushroom.visible = true
