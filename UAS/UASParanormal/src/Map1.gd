extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var enemies_number = get_tree().get_nodes_in_group("Enemies").size()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/FOV.enabled=true
	$HUD/Stamina.value = $Player.stamina
	$Portal._disable()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player.set_artifact($TouchControl/InventoryContainer.selectedItem)
	if(enemies_number<=0):
		$Portal._enable()
	if($AudioStreamPlayer.playing==false):
		$AudioStreamPlayer.play()

func _on_Run_pressed():
	$Player.run_signal = true


func _on_Run_released():
	$Player.run_signal = false


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

func _enemy_died():
	enemies_number-=1
	if(enemies_number<=0):
		$Portal._enable()

func _on_GenericEnemy3_died():
	_enemy_died()


func _on_GenericEnemy_died():
	_enemy_died() # Replace with function body.


func _on_GenericEnemy2_died():
	_enemy_died() # Replace with function body.


func _on_ShadedEnemy_died():
	_enemy_died() # Replace with function body.


func _on_GenericEnemy4_died():
	_enemy_died() # Replace with function body.


func _on_GenericEnemy5_died():
	_enemy_died() # Replace with function body.
