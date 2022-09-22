extends StaticBody
class_name Mushroom

onready var collision_shape = $CollisionShape

enum Types {
	Philosopher, Amoneeto, BarkEater, FireGoblet, RainbowRot, PixieChairs
}

const names = {
	Types.Amoneeto : "Amoneeto",
	Types.Philosopher : "Philosophers Cap",
	Types.BarkEater : "Bark Eater",
	Types.FireGoblet : "Fire Goblet",
	Types.RainbowRot : "Rainbow Rot",
	Types.PixieChairs : "Pixie Chairs"
}

export var type = Types.Amoneeto


const near_water = "growing near water"
const under_pine = "growing under Pine"
const under_maple = "growing under Maple"
const under_birch = "growing under Birch"
const under_willow = "growing under Willow"
const on_grave = "growing on a grave"

export var attributes : Dictionary = { 
	near_water : false,
	under_pine : false,
	under_willow : false,
	under_maple : false,
	under_birch : false,
	on_grave : false
}


func interaction():
	return str("[E] Pick Up ", names[type])

func interact(picker):
	get_parent().remove_child(self)
	$CollisionShape.disabled = true
	picker.mushrooms.add(self)
