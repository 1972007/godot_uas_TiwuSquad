extends Resource
class_name Inventory

signal items_changed(indexes)
export(Array,Resource) var items=[null,null,null]
onready var selected
func set_item(item_idx,item):
	var prevItem = items[item_idx]
	items[item_idx] = item
	emit_signal("items_changed",[item_idx])
	return prevItem

func swap_items(item_idx,target_idx):
	var targetItem = items[target_idx]
	var item=items[item_idx]
	items[target_idx] = item
	items[item_idx] = targetItem
	emit_signal("items_changed",[item_idx,target_idx])

func remove_item(item_idx,item):
	var prevItem = items[item_idx]
	items[item_idx] = null
	emit_signal("items_changed",[item_idx])
	return prevItem
func add_inventory(item):
	pass
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	passW
