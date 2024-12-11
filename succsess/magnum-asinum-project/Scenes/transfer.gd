extends Area2D

var lvl1status = false

func _on_body_entered(body: Node2D) -> void:
	lvl1status = true
	save()
	get_tree().change_scene_to_file("res://Scenes/hub.tscn")

func save():
	var save_data = {
		"lvl1_completed": lvl1status
		}
	
	var json_string = JSON.stringify(save_data) #converts to JSON
	var json_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	json_file.store_line(json_string)
	json_file.close()
