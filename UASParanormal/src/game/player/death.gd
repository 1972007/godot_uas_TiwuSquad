extends Area2D

export (PackedScene) var overScene

func _on_DeathBox_body_entered(body):
	print(body.name)
	if body.is_in_group("Enemies") or body.is_in_group("Boss"):
		if(not body.stunned):
			print("You died!")
			Global.res = "Fail"
			if(overScene!=null):
				get_tree().change_scene_to(overScene)
			else:
				get_tree().reload_current_scene()
