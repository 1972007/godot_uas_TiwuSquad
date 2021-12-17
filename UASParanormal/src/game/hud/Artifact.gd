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
	$Label2.text = "x"+ str(player.artifact_total)
	if(value==min_value):
		if(player.artifact_total>0):
			player.artifact_total-=1
	if(not player.artifact_ready):
		if(value==max_value):
			player._set_artifact_ready(true)
	if(player.artifact_signal and player.artifact_ready and player.artifact_total>0):
		_reduce_bar()
		if(value<=0 and player.artifact_total>0):
			player._reduce_artifact()
			if(player.artifact_total>0):
				value=100
	
func _reduce_bar():
	value-=EXH_RATE
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
