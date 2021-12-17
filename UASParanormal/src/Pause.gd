extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
onready var _game_paused=false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(_game_paused==true):
		get_tree().paused=true
		$Paused.visible=true
	else:
		get_tree().paused=false
		$Paused.visible=false
func toggle_game_pause():
	if(_game_paused):
		_game_paused=false
	else:
		_game_paused=true
