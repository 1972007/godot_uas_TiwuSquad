extends ColorRect


var inventory = preload("res://src/game/player/Inventory.tres")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var selectedItem = inventory.items[0]
onready var bar1 = 	$ProgressBar1
onready var bar2 = 	$ProgressBar2
onready var bar3 = 	$ProgressBar3

# Called when the node enters the scene tree for the first time.
func _ready():
	call_selection_update(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bar1.value =  inventory.items[0].durability
	bar1.max_value =  inventory.items[0].max_durability
	bar2.value =  inventory.items[1].durability
	bar2.max_value =  inventory.items[1].max_durability
	bar3.value =  inventory.items[2].durability
	bar3.max_value =  inventory.items[2].max_durability
	for i in range(get_child(0).get_child(0).get_child_count()):
		_artifact_ready_display(i)
func _on_slot1_pressed():
	call_selection_update(0)
	
func _artifact_ready_display(idx):
	
	if(not inventory.items[idx].ready_to_use):
		get_child(0).get_child(0).get_child(idx).modulate.a=0.2
	else:
		get_child(0).get_child(0).get_child(idx).modulate.a=1

func _on_slot2_pressed():
	call_selection_update(1)


func _on_slot3_pressed():
	call_selection_update(2)
func call_selection_update(idx):
	reset_selection()
	selectedItem = inventory.items[idx]
	get_child(0).get_child(idx+1).modulate.a=1
func reset_selection():
	for i in range(1,get_child(0).get_child_count()) :
		get_child(0).get_child(i).modulate.a=0
