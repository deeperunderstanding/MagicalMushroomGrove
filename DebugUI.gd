extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	$MatChange.set_text("Mat. Changes: " + str(Performance.get_monitor(Performance.RENDER_MATERIAL_CHANGES_IN_FRAME)))
	$ShaderChanges.set_text("Shader Changes: " + str(Performance.get_monitor(Performance.RENDER_SHADER_CHANGES_IN_FRAME)))
	$Vertices.set_text("Vertices: " + str(Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME)))
	$ProcTime.set_text("Proc. Time: " + str(Performance.get_monitor(Performance.TIME_PROCESS)))
	$PhysProcTime.set_text("Phys. Proc. Time: " + str(Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS)))
