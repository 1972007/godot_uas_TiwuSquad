extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	#$Player/FOV.enabled=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TouchScreenButton_pressed():
	$Player.artifact_signal = true # Replace with function body.


func _on_TouchScreenButton_released():
	$Player.artifact_signal = false # Replace with function body.




func _on_Pause_pressed():
	pass# Replace with function body.


func _on_Area2D_body_entered(body):
	if(body.name=="Player"):
		get_tree().change_scene("res://maps/map_test_2.tscn")
