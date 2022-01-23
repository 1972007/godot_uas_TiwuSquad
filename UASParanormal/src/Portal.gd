extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spawned=false
var time=0
export var next_scene : PackedScene



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _disable():
	monitoring=false
	visible = false
func _enable():
	monitoring=true
	visible = true
func _on_Area2D_body_entered(body):
	if(body.name=="Player"):
		get_tree().change_scene_to(next_scene)
