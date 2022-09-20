tool extends Spatial

export var bake = false
export var mesh_ref = preload("res://Models/Bush_2.obj")
export var material_ref = preload("res://BushShader.tres")

onready var scatter = $Scatter3D

func _ready():
	pass


func _process(delta):
	if bake:
		bake = false
	else: return
	
	var multimesh = MultiMesh.new()
	multimesh.set_transform_format(MultiMesh.TRANSFORM_3D)
	multimesh.set_color_format(MultiMesh.COLOR_FLOAT)
	multimesh.set_instance_count(scatter.get_children().size())

	var mesh = mesh_ref.duplicate(true)
	mesh.surface_set_material(0, material_ref)
	multimesh.mesh = mesh
	
	var counter = 0

	for child in scatter.get_children():
		var transform = child.global_transform
		multimesh.set_instance_transform(counter, transform)
		counter += 1
		scatter.remove_child(child)
		child.queue_free()
		
		
	var instance = MultiMeshInstance.new()
	instance.set_multimesh(multimesh)
	add_child(instance)
	instance.set_owner(self.owner)

	
	
