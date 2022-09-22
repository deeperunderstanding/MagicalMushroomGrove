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
	}, "Brew of Courage"),
	Recipes.OrderedQuantityRecipe.new([
		Mushroom.Types.BarkEater, 
		Mushroom.Types.Amoneeto,
		Mushroom.Types.Amoneeto,
		Mushroom.Types.BarkEater,
		Mushroom.Types.FireGoblet,
		Mushroom.Types.FireGoblet
	], "Call of the Wood Nymph"),
	Recipes.SimpleQuantityRecipe.new({
		Mushroom.Types.Philosopher : 1,
		Mushroom.Types.Amoneeto : 1,
		Mushroom.Types.BarkEater : 1, 
		Mushroom.Types.FireGoblet : 1, 
		Mushroom.Types.PixieChairs : 1, 
		Mushroom.Types.RainbowRot : 1, 
	}, "Scent of the Grove"),
	Recipes.QuantityWithAttributeRecipe.new([
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.FireGoblet, [Mushroom.near_water]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.Amoneeto, [Mushroom.near_water]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.PixieChairs, [Mushroom.near_water])
	], "Potion of Water Breathing"),
	Recipes.QuantityWithAttributeRecipe.new([
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.RainbowRot, [Mushroom.under_pine]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.FireGoblet, [Mushroom.under_birch]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.PixieChairs, [Mushroom.under_willow]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.Philosopher, [Mushroom.under_maple])
	], "Arborists Brew"),
	Recipes.OrderedQuantityWithAttributeRecipe.new([
		Recipes.AttributeRecipePart.new(3, Mushroom.Types.Philosopher, [Mushroom.on_grave]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.Amoneeto, [Mushroom.on_grave]),
		Recipes.AttributeRecipePart.new(2, Mushroom.Types.FireGoblet, [Mushroom.on_grave]),
		Recipes.AttributeRecipePart.new(3, Mushroom.Types.PixieChairs, [Mushroom.on_grave])
	], "Potion of the shallow grave"),
	Recipes.OrderedQuantityWithAttributeRecipe.new([
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.Philosopher, [Mushroom.near_water]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.Amoneeto, [Mushroom.under_birch]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.FireGoblet, [Mushroom.on_grave]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.PixieChairs, [Mushroom.under_pine]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.RainbowRot, [Mushroom.under_willow]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.BarkEater, [Mushroom.under_maple])
	], "Brew of Transcendence")
]


var x_recipes = [
	Recipes.OrderedQuantityWithAttributeRecipe.new([
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.Philosopher, [Mushroom.near_water]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.Amoneeto, [Mushroom.under_birch]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.FireGoblet, [Mushroom.on_grave]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.PixieChairs, [Mushroom.under_pine]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.RainbowRot, [Mushroom.under_willow]),
		Recipes.AttributeRecipePart.new(1, Mushroom.Types.BarkEater, [Mushroom.under_maple])
	], "Brew of Transcendence")
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
