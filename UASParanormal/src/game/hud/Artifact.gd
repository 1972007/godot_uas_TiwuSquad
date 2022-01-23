extends ProgressBar

onready var player = get_node("../../Player")

var EXH_RATE = 1 #exhaustion rate
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func _process(delta):
	if(player.artifact_signal and player.artifact_ready and value>0):
		_reduce_bar()
	if(value<=0):
		player.artifact_ready = false
func _reduce_bar():
	value-=EXH_RATE
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
