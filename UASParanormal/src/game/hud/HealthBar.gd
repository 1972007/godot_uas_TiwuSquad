extends Control

class_name HealthBar
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _set_max_val(max_value):
	$TextureProgress.max_value=max_value
func _set_val(value):
	$TextureProgress.value=value

