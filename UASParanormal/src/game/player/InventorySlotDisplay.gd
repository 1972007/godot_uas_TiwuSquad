extends CenterContainer

var inventory = preload("res://src/game/player/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
		
	else:
		itemTextureRect.texture = load("res://textures/tilemap/Slot.png")
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
