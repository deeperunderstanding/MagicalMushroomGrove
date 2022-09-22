extends Area


func _on_WaterFlagger_body_entered(body):
	if body is Mushroom:
		body.attributes[Mushroom.near_water] = true


