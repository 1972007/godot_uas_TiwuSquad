extends Node2D

# Declare member variables here. Examples:
# var a = 2
# # var b = "text"
# func _ready():
# 	$Player/FOV.enabled=true
onready var enemies_number =4
onready var shaded_enemies_number =1
onready var max_enemies = 7
onready var max_shaded_enemies = 4
var enemies_stunned=0
var enemy = preload("res://scenes/enemy_generic.tscn")
var boss_dead=false
var boss

export (PackedScene) var overScene
func _ready():
	$Player/FOV.enabled=true
	
func _process(delta):
	$Player.set_artifact($TouchControl/InventoryContainer.selectedItem)
	$HUD/Stamina.value = $Player.stamina

	

func _on_Pause_pressed():
	if($HUD/Pause._game_paused==true):
		$HUD/Pause._game_paused=false# Replace with function body.
		$Player._resumed_camera()
		
	elif($HUD/Pause._game_paused==false):
		$HUD/Pause._game_paused=true# Replace with function body.
		$Player._paused_camera()


func _on_Artifact_pressed():
	$Player.artifact_signal = true # Replace with function body.


func _on_Artifact_released():
	$Player.artifact_signal = false # Replace with function body.


func _on_TouchScreenButton_pressed():
	pass # Replace with function body.


func _on_Run_pressed():
	$Player.run_signal = true


func _on_Run_released():
	$Player.run_signal = false
func summon_boss():
	boss = preload("res://scenes/Boss.tscn").instance()
	boss.add_to_group("Boss")
	boss.position.x=1898
	boss.position.y=-2468
	$AudioStreamPlayer.stream = load("res://GameMusik/bos_Song.wav")
	get_tree().get_root().get_node("World").call_deferred("add_child",boss)


func _on_Area2D_body_entered(body):
	summon_boss() # Replace with function body.
