extends Spatial
class_name AlchemyStation

signal failed
signal next
signal done

var recipes = [
	Recipes.SimpleQuantityRecipe.new({
		Mushroom.Types.Philosopher : 2,
		Mushroom.Types.Amoneeto : 3,
		Mushroom.Types.BarkEater : 1, 
	}, "Hermes Endeavour"),
	Recipes.OrderedQuantityRecipe.new([
		Mushroom.Types.BarkEater, 
		Mushroom.Types.Amoneeto,
		Mushroom.Types.Amoneeto,
		Mushroom.Types.BarkEater,
		Mushroom.Types.FireGoblet,
		Mushroom.Types.FireGoblet
		
	], "Circes Call"),
	Recipes.QuantityWithAttributeRecipe.new([
		Recipes.AttributeRecipePart.new(3, Mushroom.Types.Philosopher, [Mushroom.under_pine]),
		Recipes.AttributeRecipePart.new(4, Mushroom.Types.Amoneeto, [Mushroom.under_willow]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.BarkEater, [Mushroom.near_water]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.PixieChairs, [Mushroom.near_water])
	], "Potion C"),
	Recipes.OrderedQuantityWithAttributeRecipe.new([
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.FireGoblet, [Mushroom.on_grave]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.RainbowRot, [Mushroom.near_water]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.PixieChairs, [Mushroom.on_grave])
	], "Potion D")
]


var t_recipes = [
	Recipes.SimpleQuantityRecipe.new({
		Mushroom.Types.Amoneeto : 1
	}, "Test A"),
]


func _ready():
	_next()

func _next():
	var next = recipes.pop_front()
	$Cauldron.recipe = next
	$Sign_2/RecipeDisplay.render_lines(next.text_lines())
	
func _on_Cauldron_recipe_failure():
	emit_signal("failed")

func _on_Cauldron_recipe_success():
	if recipes.size() > 0:
		emit_signal("next")
		_next()
	else:
		emit_signal("done")
