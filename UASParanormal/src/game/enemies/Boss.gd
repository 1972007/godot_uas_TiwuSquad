extends "res://src/game/enemies/enemy_generic.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 100
var stam =100
var speed=300
var exhaust_rate=0.05
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = hash("Godot")
	rng.state = 100
	# add_child(bullet2)
	# add_child(bullet3)
	# add_child(bullet4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(stam<100):
		stam+=delta
	
func speed_up():
	if(stam>0):
		SPEED=speed
		stam-=exhaust_rate

