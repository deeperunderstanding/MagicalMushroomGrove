extends StaticBody


func _ready():
	pass # Replace with function body.

func interaction():
	return "A Pine Tree"

func interact(other):
	pass

func _on_Area_body_entered(body):
	if body is Mushroom:
		body.attributes[Mushroom.under_pine] = true

