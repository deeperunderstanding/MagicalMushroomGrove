class_name Recipes

enum RecipeState { CONTINUE, SUCCESS, FAILURE }

class Recipe extends Reference:
	func validate(mushroom):
		pass
		
	func text_lines() -> Array:
		return []

class SimpleQuantityRecipe extends Recipe:
	
	var recipe = {}
	var name = null
	
	func _init(recipe_map : Dictionary, _name = null):
		recipe = recipe_map
		name = _name
		
	func validate(mushroom):
		if recipe.has(mushroom.type):
			recipe[mushroom.type] -= 1
		else:
			return RecipeState.FAILURE
			
		var missing = 0
		for key in recipe:
			var amnt = recipe[key]
			if amnt < 0:
				return RecipeState.FAILURE
			else:
				missing += amnt
		if missing == 0:
			return RecipeState.SUCCESS
		else:
			return RecipeState.CONTINUE
			
	func text_lines():
		var lines = []
		lines.append("Recipe: ")
		lines.append(name)
		lines.append(false)
		for key in recipe:
			var amnt = recipe[key]
			lines.append(str(amnt) + "x " + Mushroom.names[key])
		return lines
		
		
class OrderedQuantityRecipe extends Recipe:
	
	var recipe = []
	var name = null
	
	func _init(recipe_list : Array, _name = null):
		recipe = recipe_list
		name = _name
		
	func validate(mushroom):
		var rec = recipe.pop_front()
		if rec and rec == mushroom.type:
			if recipe.size() > 0:
				return RecipeState.CONTINUE
			else:
				return RecipeState.SUCCESS
		else:
			return RecipeState.FAILURE
			
	func text_lines():
		var lines = []
		var recipe_copy = [] + recipe
		
		lines.append("Recipe: ")
		lines.append(name)
		lines.append(false)
		
		_append_lines(0, recipe_copy.pop_front(), lines, recipe_copy)
		
		lines.append(false)
		lines.append("ADD IN ORDER!")
		return lines
		
	func _append_lines(amnt, type, lines, _recipe):
		var count = amnt + 1
		if _recipe.size() > 0:
			var next = _recipe[0]
			if next == type:
				_append_lines(count, _recipe.pop_front(), lines, _recipe)
			else:
				lines.append(str(count) + "x " + Mushroom.names[type])
				_append_lines(0, _recipe.pop_front(), lines, _recipe)
		else:
			lines.append(str(count) + "x " + Mushroom.names[type])
			return lines
		
		
class AttributeRecipePart extends Reference:
	
	var quantity = 0
	var type = Mushroom.Types.Amoneeto
	var attributes = []
	
	func _init(_quantity : int, _type : int, _attributes : Array):
		quantity = _quantity
		type = _type
		attributes = _attributes
		
		
	func validate(mushroom : Mushroom):
		if mushroom.type == type:
			
			var matching = 0
			for key in attributes:
				if mushroom.attributes[key]:
					matching += 1
			
			if matching == attributes.size():
				quantity -= 1
				return true
			else:
				return false
					
		else:
			return false
			
	
		
class QuantityWithAttributeRecipe extends Recipe:
	
	var recipe = null
	var name = ""
	
	func _init(recipe_list : Array, _name = null):
		recipe = recipe_list
		name = _name
		
	func validate(mushroom):
		var validated = false
		for line in recipe:
			validated = line.validate(mushroom)
			if validated:
				break
				
		if not validated:
			return RecipeState.FAILURE
				
		var finished = 0
		for line in recipe:
			if line.quantity == 0:
				finished += 1
		
		if finished == recipe.size():
			return RecipeState.SUCCESS
		else:
			return RecipeState.CONTINUE
		
			
	func text_lines():
		var lines = []
		lines.append("Recipe: ")
		lines.append(name)
		lines.append(false)
		for part in recipe:
			lines.append(str(part.quantity) + "x " + Mushroom.names[part.type])
			for att in part.attributes:
				lines.append(str("	- " + att))
		return lines
		
		
class OrderedQuantityWithAttributeRecipe extends Recipe:
	
	var recipe = null
	var name = ""
	
	func _init(recipe_list : Array, _name = null):
		recipe = recipe_list
		name = _name
		
	func validate(mushroom):
		var part = recipe[0]
		var valid = false
		
		if part:
			valid = part.validate(mushroom)
		
		if part.quantity == 0:
			recipe.pop_front()
		
		if valid:
			if recipe.size() > 0:
				return RecipeState.CONTINUE
			else:
				return RecipeState.SUCCESS
		else:	
			return RecipeState.FAILURE
				
	
	func text_lines():
		var lines = []
		lines.append("Recipe: ")
		lines.append(name)
		lines.append(false)
		for part in recipe:
			lines.append(str(part.quantity) + "x " + Mushroom.names[part.type])
			for att in part.attributes:
				lines.append(str("	- " + att))
				
		lines.append(false)
		lines.append("ADD IN ORDER!")
		return lines
