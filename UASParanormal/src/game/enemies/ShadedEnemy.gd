extends "res://src/game/enemies/enemy_generic.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var alpha=$Sprite.material.get_shader_param("alpha")
onready var invisible =true
onready var CLOAK_RATE=0.005
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	sprite = $Sprite
	scale_x = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not get_tree().paused):
		
		alpha=$Sprite.material.get_shader_param("alpha")
		if(invisible==false and alpha<1):
			alpha+=CLOAK_RATE
		elif(invisible==true and alpha>0):
			alpha-=CLOAK_RATE
		
		$Sprite.material.set_shader_param("alpha",alpha)


func _on_Timer_timeout():
	if(invisible==false):
		invisible=true
	else:
		invisible=false
	$Timer.start()
		# Replace with function body.
