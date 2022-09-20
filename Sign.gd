tool extends Spatial


onready var line_template = preload("res://SignTextLine.tscn")

export var pixel_size = 0.01
export var initial_lines : Array = [
	"Hello",
	"This is a Recipe:",
	false,
	"2 x Amoneeta",
	"1 x Phylosipher Cap"
]


func _ready():
	render_lines(initial_lines)
		
func render_lines(lines):
	for line in $Lines.get_children():
		$Lines.remove_child(line)
		line.queue_free()
		
	var i = 0
	for text in lines:
		if text:
			var line = line_template.instance()
			line.mesh.text = text
			line.mesh.pixel_size = pixel_size
			$Lines.add_child(line)
			line.global_transform.origin = $TextStart.global_transform.origin + Vector3(0, -i * pixel_size * 20 , 0)
		i += 1
	
		
		
