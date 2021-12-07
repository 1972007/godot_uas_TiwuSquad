extends Node2D

var inventoryManager

export(bool) var clear_inventory = true
onready var _inventory_any = $CanvasInventory/Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_tree().get_root().has_node("InventoryManager"))
	if get_tree().get_root().has_node("InventoryManager"):
		
		inventoryManager = get_tree().get_root().get_node("InventoryManager")
		inventoryManager.player = $Player
		if clear_inventory:
			inventoryManager.clear_inventory(_inventory_any.inventory)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TouchScreenButton_pressed():
	$Player.artifact_signal = true # Replace with function body.


func _on_TouchScreenButton_released():
	$Player.artifact_signal = false # Replace with function body.
