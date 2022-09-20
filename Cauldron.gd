extends StaticBody
class_name Cauldron

signal recipe_success
signal recipe_failure

var interacting = false

var recipe = Recipes.Recipe.new()

func interaction():
	return "[E] Drop Mushroom into Cauldron"

func interact(actor):
	if not interacting:
		interacting = true
	
		var mush : Spatial = actor.mushrooms.pop()
		if mush:
			$MushroomHolder.add_child(mush)
			mush.scale = Vector3(0.5, 0.5, 0.5)
			mush.visible = true
			mush.global_transform.origin = $MushroomHolder.global_transform.origin
			$AnimationPlayer.play("add_mushroom")
			yield($AnimationPlayer, "animation_finished")
			_validate_recipe(mush)
			mush.queue_free()

		interacting = false


func _validate_recipe(mush : Mushroom):
	var result = recipe.validate(mush)
	if result == Recipes.RecipeState.FAILURE:
		emit_signal("recipe_failure")
	elif result == Recipes.RecipeState.SUCCESS:
		emit_signal("recipe_success")
