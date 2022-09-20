extends Readable




func _on_Area_body_entered(body):
	if body is Mushroom:
		body.attributes[Mushroom.on_grave] = true
