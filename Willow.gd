extends StaticBody


func interaction():
	return "A Whispering Willow Tree"
	
func interact(other):
	pass


func _on_Area_body_entered(body):
	if body is Mushroom:
		body.attributes[Mushroom.under_willow] = true
